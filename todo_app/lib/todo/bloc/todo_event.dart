sealed class TodoEvent {}

class AddTodo extends TodoEvent {
  final String title;
  final String description;

  AddTodo({
    required this.title,
    this.description = "",
  });
}

class RemoveTodo extends TodoEvent {
  final String id;

  RemoveTodo(this.id);
}

class ToggleTodo extends TodoEvent {
  final String id;

  ToggleTodo(this.id);
}

class SearchTodo extends TodoEvent {
  final String query;

  SearchTodo(this.query);
}

class LoadTodos extends TodoEvent {}
