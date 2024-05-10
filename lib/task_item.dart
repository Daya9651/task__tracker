import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  final VoidCallback onToggleCompleted;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  TaskItem({required this.task, required this.onToggleCompleted, required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.title),
      subtitle: Text(task.description),
      leading: Checkbox(
        value: task.completed,
        onChanged: (value) => onToggleCompleted(),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: onEdit,
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
