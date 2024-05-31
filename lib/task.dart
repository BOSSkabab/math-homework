class Task {
  Task({
    required this.pages,
    required this.type,
    required this.title,
    required this.date,
  });
  final String title;
  final DateTime date;
  final TaskType type;
  final String pages;

  Task.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        date = DateTime(json['date']).add(const Duration(days: 7)),
        type = TaskType.values
            .firstWhere((element) => element.text == json['type']),
        pages = json['pages'];
}

enum TaskType {
  geometry("גיאומטריה"),
  trigonometry("טריגונומטריה"),
  calculus('חדו"א'),
  miscellaneous("אחר");

  final String text;

  const TaskType(
    this.text,
  );
}
