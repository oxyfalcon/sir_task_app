import 'package:app/Provider/notify_provider.dart';
import 'package:flutter/material.dart';

class DeleteButton extends StatelessWidget {
  const DeleteButton({
    super.key,
    required this.todoState,
    required this.itr,
  });

  final TodoList todoState;
  final Todo itr;

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      color: Theme.of(context).cardColor,
      onPressed: () {
        todoState.deleTodo(itr);
      },
      icon: const Icon(Icons.delete),
    );
  }
}
