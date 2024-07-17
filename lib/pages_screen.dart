import 'package:flutter/material.dart';
import 'package:math_homework/task.dart';
import 'package:zoom_widget/zoom_widget.dart';

class PagesScreen extends StatelessWidget {
  const PagesScreen({super.key, required this.task});
  final Task task;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final List<String> pages = getPages(task.pages);
    final List<String> pagesPath =
        pages.map((page) => "assets/$page${task.type.text}.png").toList();
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.grey,
            Colors.black,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text("Pages"),
        ),
        body: ListView.builder(
          itemCount: pages.length,
          itemBuilder: (context, index) => Expanded(
            child: Card(
                color: Colors.grey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(pages[index].toString()),
                    SizedBox(
                      width: screenSize.width - 40,
                      height: screenSize.height + 20,
                      child: Zoom(
                        initScale: 1.8,
                        child: Image.asset(
                          pagesPath[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20)
                  ],
                )),
          ),
        ),
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
            .split(":")[1]
            .replaceAll(" ", "")
        : "")
    .toList();
