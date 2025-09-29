import 'package:flutter_task_manager/helpers/week_helper.dart';
import 'package:flutter_task_manager/models/task.dart';

class StatisticsHelper {
  final int completedCount;
  final int ongoingCount;
  final int overdueCount;
  final String mostProductiveDay;
  final String busiestDay;
  final String averageCompletionTime;

  const StatisticsHelper({
    required this.completedCount,
    required this.ongoingCount,
    required this.overdueCount,
    required this.mostProductiveDay,
    required this.busiestDay,
    required this.averageCompletionTime,
  });

  factory StatisticsHelper.fromTasks(
    List<Task> completed,
    List<Task> ongoing,
    List<Task> overdue,
  ) {
    final completedCount = completed.length;
    final ongoingCount = ongoing.length;
    final overdueCount = overdue.length;

    final mostProductiveDay = _calculateMostProductiveDay(completed);
    final busiestDay = _calculateBusiestDay([
      ...completed,
      ...ongoing,
      ...overdue,
    ]);
    final averageCompletionTime = _calculateAverageCompletionTime(completed);

    return StatisticsHelper(
      completedCount: completedCount,
      ongoingCount: ongoingCount,
      overdueCount: overdueCount,
      mostProductiveDay: mostProductiveDay,
      busiestDay: busiestDay,
      averageCompletionTime: averageCompletionTime,
    );
  }

  static String _calculateMostProductiveDay(List<Task> tasks) {
    if (tasks.isEmpty) return '-';
    final dayCounts = <int, int>{};
    for (final task in tasks) {
      final weekday = task.completedAt!.weekday;
      dayCounts[weekday] = (dayCounts[weekday] ?? 0) + 1;
    }
    final mostProductive = dayCounts.entries
        .reduce((a, b) => a.value >= b.value ? a : b)
        .key;
    return weekday(mostProductive);
  }

  static String _calculateBusiestDay(List<Task> tasks) {
    if (tasks.isEmpty) return '-';
    final dayCounts = <int, int>{};
    for (final task in tasks) {
      final weekday = task.deadline.weekday;
      dayCounts[weekday] = (dayCounts[weekday] ?? 0) + 1;
    }
    final busiest = dayCounts.entries
        .reduce((a, b) => a.value >= b.value ? a : b)
        .key;
    return weekday(busiest);
  }

  static String _calculateAverageCompletionTime(List<Task> tasks) {
    if (tasks.isEmpty) return '-';
    final durations = tasks
        .map((t) => t.completedAt!.difference(t.deadline).inMinutes.abs())
        .toList();
    final avgMinutes = (durations.reduce((a, b) => a + b) / durations.length)
        .round();
    final hours = avgMinutes ~/ 60;
    final minutes = avgMinutes % 60;
    return '${hours}h ${minutes}m';
  }
}
