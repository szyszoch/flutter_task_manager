import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_task_manager/models/task.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class NotificationHelper {
  static const String _channelId = 'flutter_task_manager_channel';
  static const String _channelName = 'Menadżer Zadań';
  static const int _maxNotifyPerTask = 4;

  static const List<Duration> _reminders = [
    Duration(days: 1),
    Duration(hours: 3),
    Duration(hours: 1),
    Duration.zero,
  ];

  final FlutterLocalNotificationsPlugin _plugin;

  NotificationHelper(this._plugin);

  factory NotificationHelper.create() {
    final plugin = FlutterLocalNotificationsPlugin();
    return NotificationHelper(plugin);
  }

  int _generateIdForTaskNotification(int taskId, int index) {
    return taskId * _maxNotifyPerTask + index;
  }

  (int id, String title, String body, tz.TZDateTime time)
  _buildTaskNotification(
    int taskId,
    DateTime deadline,
    Duration timeBeforeDeadline,
    int index,
  ) {
    final int id = _generateIdForTaskNotification(taskId, index);
    final tz.TZDateTime scheduledDate = tz.TZDateTime.from(
      deadline,
      tz.local,
    ).subtract(timeBeforeDeadline);
    final hours = timeBeforeDeadline.inHours;
    final minutes = timeBeforeDeadline.inMinutes.remainder(60);
    final bool isImmediate = timeBeforeDeadline == Duration.zero;
    final String title = isImmediate
        ? 'Termin zadania wygasł'
        : 'Przypomnienie o zbliżającym się terminie';
    final String body = isImmediate
        ? 'Termin na wykonanie zadania właśnie minął.'
        : 'Za ${hours}h ${minutes}m kończy się czas na wykonanie zadania.';
    return (id, title, body, scheduledDate);
  }

  Future<void> init() async {
    tz.initializeTimeZones();
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: android);
    await _plugin.initialize(settings);
    _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();
  }

  Future<void> cancelNotification(int id) async {
    await _plugin.cancel(id);
  }

  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime,
  }) async {
    const android = AndroidNotificationDetails(
      _channelId,
      _channelName,
      importance: Importance.high,
      priority: Priority.high,
    );
    const platform = NotificationDetails(android: android);
    await _plugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledTime, tz.local),
      platform,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    );
  }

  Future<void> scheduleTaskNotification(Task task) async {
    if (task.id == null || task.isLate) return;

    final now = tz.TZDateTime.now(tz.local);

    for (var i = 0; i < _reminders.length; i++) {
      final (id, title, body, time) = _buildTaskNotification(
        task.id!,
        task.deadline,
        _reminders[i],
        i,
      );
      if (time.isBefore(now.add(Duration(minutes: 2)))) continue;
      await scheduleNotification(
        id: id,
        title: title,
        body: body,
        scheduledTime: time,
      );
    }
  }

  Future<void> cancelTaskNotifications(int taskId) async {
    for (var i = 0; i < _reminders.length; i++) {
      await cancelNotification(_generateIdForTaskNotification(taskId, i));
    }
  }
}
