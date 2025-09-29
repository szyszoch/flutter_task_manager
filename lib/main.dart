import 'package:flutter/material.dart';
import 'package:flutter_task_manager/helpers/notification_helper.dart';
import 'package:flutter_task_manager/pages/home_page.dart';
import 'package:flutter_task_manager/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationHelper().init();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Manadżer zadań',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: const HomePage(),
    );
  }
}
