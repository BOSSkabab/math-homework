import 'package:flutter/material.dart';
import '../task.dart';
import 'task_tile.dart';

class TasksList extends StatelessWidget {
  const TasksList({super.key, required this.tasks});
  final List<Task?> tasks;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          ...tasks.map((task) => TaskTile(task: task!)),
        ],
      );
}
