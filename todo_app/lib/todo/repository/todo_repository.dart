import '../model/todo_model.dart';

abstract class TodoRepository {
  void addTodo(Todo todo);
  void toggleTodoStatus(String id);
  void removeTodo(String id);
  List<Todo> getTodos();
  List<Todo> searchTodos(String query);
}

class TodoRepositoryImpl implements TodoRepository {
  final List<Todo> _todos = [];

  @override
  void addTodo(Todo todo) {
    _todos.add(todo);
  }

  @override
  void removeTodo(String id) {
    _todos.removeWhere((todo) => todo.id == id);
  }

  @override
  void toggleTodoStatus(String id) {
    final todo = _todos.firstWhere((todo) => todo.id == id);
    todo.isDone = !todo.isDone;
  }

  @override
  List<Todo> getTodos() {
    return List.from(_todos);
  }

  @override
  List<Todo> searchTodos(String query) {
    return _todos
        .where((todo) => todo.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
