import 'package:flutter/material.dart';
import 'package:todo_app/app.dart';
import 'package:todo_app/core/di/di.dart';

void main() async {
  await initDependencies();
  runApp(const App());
}
