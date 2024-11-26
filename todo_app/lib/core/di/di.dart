import 'package:get_it/get_it.dart';
import 'package:todo_app/todo/bloc/todo_bloc.dart';
import 'package:todo_app/todo/repository/todo_repository.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  getIt.registerFactory<TodoRepository>(
    () => TodoRepositoryImpl(),
  );

  getIt.registerFactory<TodoBloc>(
    () => TodoBloc(
      getIt<TodoRepository>(),
    ),
  );
}
