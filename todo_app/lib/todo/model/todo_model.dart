// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:uuid/uuid.dart';

class Todo {
  String id;
  String title;
  String description;
  bool isDone;

  Todo({
    required this.title,
    this.description = "",
    this.isDone = false,
  }) : id = const Uuid().v4();

  Todo copyWith({
    String? id,
    String? title,
    String? description,
    bool? isDone,
  }) {
    return Todo(
      title: title ?? this.title,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
    );
  }
}
