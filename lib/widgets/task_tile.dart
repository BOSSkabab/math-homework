import 'package:flutter/material.dart';
import 'package:math_homework/pages_screen.dart';
import '../task.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({super.key, required this.task});
  final Task task;

  @override
  Widget build(BuildContext context) {
    const Color textColor = Colors.white70;
    final String firstPage =
        "asset/${getPages(task.pages)[0]}${task.type.text}.png";
    return GestureDetector(
      onDoubleTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PagesScreen(task: task),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 10),
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(firstPage),
                  ),
                ),
              ),
              Expanded(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    task.type.text,
                    style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: textColor),
                  ),
                  ...task.title.map(
                    (title) => Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                  ),
                  ...task.pages.map((page) => Text(page,
                      style: const TextStyle(
                        fontSize: 20,
                        color: textColor,
                        fontWeight: FontWeight.bold,
                      ))),
                  Text("${task.date.day}/${task.date.month}/${task.date.year}",
                      style: const TextStyle(
                          fontSize: 15,
                          color: textColor,
                          fontWeight: FontWeight.bold)),
                ],
              )),
              const SizedBox(width: 10),
            ],
          ),
          const Divider(
            color: textColor,
          ),
        ],
      ),
    );
  }
}

List<String> getPages(List<Object?> pages) => pages
    .map((page) => page.toString().contains(":")
        ? page
            .toString()
            .replaceAll(";", "")
            .replaceAll(",", "")
            .replaceAll(".", "")
            .split(":")[0]
            .replaceAll(" ", "")
        : "")
    .toList();
