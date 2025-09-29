import 'package:flutter/material.dart';
import 'package:flutter_task_manager/helpers/database_helper.dart';
import 'package:flutter_task_manager/helpers/statistics_helper.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  late final StatisticsHelper _stats;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStatistics();
  }

  Future<void> _loadStatistics() async {
    final db = DatabaseHelper.instance;
    _stats = StatisticsHelper.fromTasks(
      await db.completedTasks(),
      await db.ongoingTasks(),
      await db.overdueTasks(),
    );
    if (mounted) setState(() => isLoading = false);
  }

  Widget _buildStatisticCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color.withValues(alpha: 0.2),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) return const Center(child: CircularProgressIndicator());

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatisticCard(
            'Zakończone zadania',
            _stats.completedCount.toString(),
            Icons.check_circle_outline,
            Colors.green,
          ),
          const SizedBox(height: 16),
          _buildStatisticCard(
            'Zadania w toku',
            _stats.ongoingCount.toString(),
            Icons.hourglass_empty,
            Colors.orange,
          ),
          const SizedBox(height: 16),
          _buildStatisticCard(
            'Zadania zaległe',
            _stats.overdueCount.toString(),
            Icons.warning,
            Colors.red,
          ),
          const SizedBox(height: 16),
          _buildStatisticCard(
            'Największa aktywność w',
            _stats.mostProductiveDay,
            Icons.calendar_today,
            Colors.blue,
          ),
          const SizedBox(height: 16),
          _buildStatisticCard(
            'Najwięcej zadań w',
            _stats.busiestDay,
            Icons.event_busy,
            Colors.purple,
          ),
          const SizedBox(height: 16),
          _buildStatisticCard(
            'Średni czas ukończenia',
            _stats.averageCompletionTime,
            Icons.timer,
            Colors.teal,
          ),
        ],
      ),
    );
  }
}
