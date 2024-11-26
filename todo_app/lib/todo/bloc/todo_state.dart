import 'package:todo_app/todo/model/todo_model.dart';

sealed class TodoState {}

class TodoInitial extends TodoState {}

class TodoLoading extends TodoState {}

class TodoSuccess extends TodoState {
  final List<Todo> items;

  TodoSuccess({required this.items});
}

class TodoSearchSuccess extends TodoState {
  final List<Todo> items;

  TodoSearchSuccess({required this.items});
}

class TodoError extends TodoState {
  final String message;

  TodoError({required this.message});
}
