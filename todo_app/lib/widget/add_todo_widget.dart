import 'package:flutter/material.dart';

class AddTodoWidget extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descController;
  final void Function(String title, String description) onAdd;

  const AddTodoWidget({
    super.key,
    required this.titleController,
    required this.descController,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  titleController.clear();
                  descController.clear();
                  Navigator.of(context).pop();
                },
                child: const Text("Cancelar"),
              ),
              const Text("Novo Lembrete"),
              TextButton(
                onPressed: () {
                  final title = titleController.text;
                  final description = descController.text;
                  onAdd(title, description);
                },
                child: const Text("Adicionar"),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      hintText: 'Título',
                      border: InputBorder.none,
                    ),
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                    height: 1,
                  ),
                  TextField(
                    controller: descController,
                    maxLines: 5,
                    minLines: 3,
                    decoration: const InputDecoration(
                      hintText: 'Descrição',
                      border: InputBorder.none,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
