import 'package:flutter/material.dart';
import 'package:todo_app/screens/home_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'To-Do App',
      home: HomeScreen(),
    );
  }
}

