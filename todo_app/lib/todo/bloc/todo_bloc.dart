import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/todo_model.dart';
import '../repository/todo_repository.dart';
import 'todo_event.dart';
import 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository repository;

  TodoBloc(this.repository) : super(TodoInitial()) {
    on<AddTodo>(_onAddTodo);
    on<RemoveTodo>(_onRemoveTodo);
    on<ToggleTodo>(_onToggleTodoStatus);
    on<LoadTodos>(_onLoadTodos);
    on<SearchTodo>(_onSearchTodo);
  }

  Future<void> _onAddTodo(
    AddTodo event,
    Emitter<TodoState> emit,
  ) async {
    if (event.title.isNotEmpty) {
      emit(TodoLoading());
      try {
        repository.addTodo(Todo(
          title: event.title,
          description: event.description.isEmpty ? "" : event.description,
        ));
        final todos = repository.getTodos();
        emit(TodoSuccess(items: todos));
      } catch (e) {
        emit(TodoError(message: 'Erro ao adicionar o Todo'));
      }
    } else {
      emit(TodoError(message: 'Título do Todo não pode ser vazio'));
    }
  }

  Future<void> _onRemoveTodo(
    RemoveTodo event,
    Emitter<TodoState> emit,
  ) async {
    emit(TodoLoading());
    try {
      repository.removeTodo(event.id);
      final todos = repository.getTodos();
      emit(TodoSuccess(items: todos));
    } catch (e) {
      emit(TodoError(message: 'Erro ao remover o Todo'));
    }
  }

  Future<void> _onToggleTodoStatus(
    ToggleTodo event,
    Emitter<TodoState> emit,
  ) async {
    try {
      repository.toggleTodoStatus(event.id);
      final todos = repository.getTodos();
      emit(TodoSuccess(items: todos));
    } catch (e) {
      emit(TodoError(message: 'Erro ao atualizar o status do Todo'));
    }
  }

  Future<void> _onLoadTodos(
    LoadTodos event,
    Emitter<TodoState> emit,
  ) async {
    emit(TodoLoading());
    try {
      final todos = repository.getTodos();
      emit(TodoSuccess(items: todos));
    } catch (e) {
      emit(TodoError(message: 'Erro ao carregar os Todos'));
    }
  }

  Future<void> _onSearchTodo(
    SearchTodo event,
    Emitter<TodoState> emit,
  ) async {
    if (event.query.length > 3) {
      try {
        List<Todo> todos = [];
        if (state is TodoSuccess) {
          todos = (state as TodoSuccess).items;
        } else {
          todos = repository.getTodos();
        }

        final filteredTodos = todos
            .where((todo) =>
                todo.title.toLowerCase().contains(event.query.toLowerCase()))
            .toList();

        emit(TodoSearchSuccess(items: filteredTodos));
      } catch (e) {
        emit(TodoError(message: 'Erro ao buscar Todos'));
      }
    }
  }
}
