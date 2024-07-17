import 'package:flutter/material.dart';
import 'package:math_homework/fetch_homework.dart';
import 'package:math_homework/map_nullable.dart';
import 'task.dart';
import 'widgets/tasks_list.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Todo List'),
      );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Task> tasks = [
    Task.parse({
      "date": "30/05/2024 ",
      "pages": [" 449: 9;", " 450: 16;", " 451: 19."],
      "title": "משפט הקוסינוסים",
      "type": "טריגונומטריה"
    }),
    Task.parse({
      "date": "30/05/2024 ",
      "pages": [" 449: 9;", " 450: 16;", " 451: 19."],
      "title": "משפט הקוסינוסים",
      "type": "טריגונומטריה"
    }),
    Task.parse({
      "date": "30/05/2024 ",
      "pages": [" 449: 9;", " 450: 16;", " 451: 19."],
      "title": "משפט הקוסינוסים",
      "type": "טריגונומטריה"
    }),
    // Task(
    //     pages: ["692: 9;", " 693: 16;", "694: 18;", "700: 54. מהיום!"],
    //     type:
    //         TaskType.values.firstWhere((value) => value.text == "טריגונומטריה"),
    //     title: "משפט הקוסינוסים",
    //     date: parseDate("30/05/2024 "))
  ];
//{date: 30/05/2024 , pages: [ 692: 9;,  693: 16;,  694: 18;,  700: 54. מהיום!], title: משפט הקוסינוסים, type: טריגונומטריה}

  @override
  Widget build(BuildContext context) {
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
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: StreamBuilder<List<Task>>(
            stream: fetchHomework(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return snapshot.data?.mapNullable(
                      (final List<Task> tasks) => Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          TasksList(tasks: tasks),
                        ],
                      ),
                    ) ??
                    (throw Exception("No data"));
              }
            },
          ),
        ),
      ),
    );
  }
}
