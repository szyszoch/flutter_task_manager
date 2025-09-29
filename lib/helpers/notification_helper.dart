import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_task_manager/models/task.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class NotificationHelper {
  static const String _channelId = 'flutter_task_manager_channel';
  static const String _channelName = 'Menadżer Zadań';
  static const List<Duration> _scheduleDurations = [
    Duration(days: 1),
    Duration(hours: 3),
    Duration(hours: 1),
    Duration.zero,
  ];

  static final NotificationHelper _instance = NotificationHelper._internal();
  factory NotificationHelper() => _instance;

  NotificationHelper._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    tz.initializeTimeZones();
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: android);
    await flutterLocalNotificationsPlugin.initialize(settings);
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();
  }

  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
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
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledTime, tz.local),
      platform,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    );
  }

  Future<void> scheduleTaskNotification(
    Task task, {
    List<Duration> reminders = _scheduleDurations,
  }) async {
    if (task.id == null) return;

    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    final tz.TZDateTime deadlineTz = tz.TZDateTime.from(
      task.deadline,
      tz.local,
    );

    for (var i = 0; i < reminders.length; i++) {
      final scheduled = deadlineTz.subtract(reminders[i]);
      if (scheduled.isBefore(now)) continue;
      final notifId = task.id! * 10 + i;

      final title = _buildTaskTitle(task);
      final body = _buildTaskBody(task);

      await scheduleNotification(
        id: notifId,
        title: title,
        body: body,
        scheduledTime: scheduled,
      );
    }
  }

  String _buildTaskTitle(Task task) {
    if (task.isOverdue) {
      return 'Termin zadania minął!';
    } else {
      return 'Przypomnienie o zbliżającym się terminie';
    }
  }

  String _buildTaskBody(Task task) {
    final deadlineStr = DateFormat('dd.MM.yyyy HH:mm').format(task.deadline);
    if (task.isOverdue) {
      return 'Masz zaległe zadanie. Ostateczny termin: $deadlineStr';
    } else {
      return 'Za ${task.leftTime} kończy się czas na wykonanie zadania. Ostateczny termin: $deadlineStr';
    }
  }

  Future<void> cancelTaskNotifications(
    int taskId, {
    int reminderCount = 5,
  }) async {
    for (var i = 0; i < reminderCount; i++) {
      final notifId = taskId * 10 + i;
      await cancelNotification(notifId);
    }
  }
}
