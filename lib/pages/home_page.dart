import 'package:flutter/material.dart';
import 'package:flutter_task_manager/pages/task_page.dart';
import 'package:flutter_task_manager/pages/statistics_page.dart';
import 'package:flutter_task_manager/models/task.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<GlobalKey<TaskPageState>> _taskKeys = List.generate(
    3,
    (_) => GlobalKey<TaskPageState>(),
  );

  List<Widget> get _tabs => [
    TaskPage(key: _taskKeys[0], type: TaskType.ongoing),
    TaskPage(key: _taskKeys[1], type: TaskType.completed),
    TaskPage(key: _taskKeys[2], type: TaskType.overdue),
    StatisticsPage(),
  ];

  List<String> get _headers => [
    'Zadania w toku',
    'Zadania ukończone',
    'Zadania zaległe',
    'Statystyki',
  ];

  bool get _isTaskTab => _currentIndex < 3;

  void _onTabTapped(int index) {
    setState(() => _currentIndex = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_headers[_currentIndex])),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _tabs,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.hourglass_empty),
            label: 'W toku',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.check), label: 'Ukończone'),
          BottomNavigationBarItem(
            icon: Icon(Icons.warning),
            label: 'Nieukończone',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Statystyki',
          ),
        ],
      ),
      floatingActionButton: _isTaskTab
          ? FloatingActionButton(
              onPressed: () =>
                  _taskKeys[_currentIndex].currentState?.createTask(),
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
