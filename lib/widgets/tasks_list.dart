import 'package:flutter/material.dart';
import '../task.dart';
import 'task_tile.dart';

class TasksList extends StatelessWidget {
  const TasksList({super.key, required this.tasks});
  final List<Task?> tasks;

  @override
  Widget build(BuildContext context) => ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (BuildContext context, int index) => Column(
          children: [
            const SizedBox(height: 10),
            TaskTile(task: tasks[index]!),
            const SizedBox(height: 10),
            Container(height: 1, color: Colors.black)
          ],
        ),
      );
}
