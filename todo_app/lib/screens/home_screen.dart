import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_app/core/di/di.dart';
import 'package:todo_app/todo/bloc/todo_bloc.dart';
import 'package:todo_app/todo/bloc/todo_event.dart';
import 'package:todo_app/widget/add_todo_widget.dart';

import '../todo/bloc/todo_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final TodoBloc bloc;
  final TextEditingController searchController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    bloc = getIt<TodoBloc>();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  void _addTodoItem(BuildContext context, TodoBloc bloc) {
    showModalBottomSheet(
      backgroundColor: const Color(0xffff2f5f7),
      context: context,
      builder: (context) {
        return AddTodoWidget(
          titleController: titleController,
          descController: descController,
          onAdd: (String title, String description) {
            if (title.isNotEmpty) {
              bloc.add(AddTodo(title: title, description: description));
              titleController.clear();
              descController.clear();
              Navigator.pop(context);
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Todo List")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Buscar',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                bloc.add(SearchTodo(value));
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<TodoBloc, TodoState>(
                bloc: bloc,
                builder: (context, state) {
                  return switch (state) {
                    TodoInitial() => Center(
                        child: Lottie.asset('assets/empty.json'),
                      ),
                    TodoLoading() =>
                      const Center(child: CircularProgressIndicator()),
                    TodoSearchSuccess(:final items) => ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final todo = items[index];
                          return ListTile(
                            leading: Checkbox(
                              value: todo.isDone,
                              onChanged: (value) {
                                bloc.add(ToggleTodo(todo.id));
                              },
                            ),
                            title: Text(todo.title),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                bloc.add(RemoveTodo(todo.id));
                              },
                            ),
                          );
                        },
                      ),
                    TodoSuccess(:final items) => items.isEmpty
                        ? Center(child: Lottie.asset('assets/empty.json'))
                        : ListView.builder(
                            itemCount: items.length,
                            itemBuilder: (context, index) {
                              final todo = items[index];
                              return ListTile(
                                leading: Checkbox(
                                  value: todo.isDone,
                                  onChanged: (bool? value) {
                                    bloc.add(ToggleTodo(todo.id));
                                  },
                                ),
                                title: Text(todo.title),
                                subtitle: todo.description.isNotEmpty
                                    ? Text(todo.description)
                                    : null,
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    bloc.add(RemoveTodo(todo.id));
                                  },
                                ),
                              );
                            },
                          ),
                    TodoError(:final message) => Center(child: Text(message)),
                    _ => const SizedBox.shrink(),
                  };
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color.fromARGB(255, 160, 126, 194),
        onPressed: () => _addTodoItem(context, bloc),
        label: const Text(
          'Adicionar lembrete',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
        icon: const Icon(Icons.add, color: Colors.white, size: 25),
      ),
    );
  }
}
