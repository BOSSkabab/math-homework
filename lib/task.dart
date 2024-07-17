class Task {
  Task({
    required this.pages,
    required this.type,
    required this.title,
    required this.date,
  });
  final List<String> title;
  final DateTime date;
  final TaskType type;
  final List<String> pages;

  static Task parse(task) => Task(
        pages: parsePages(task["pages"] as List<Object?>),
        type: TaskType.values
            .firstWhere((element) => element.text == task['type'] as String),
        title: (task["title"] as String)
            .split("-")
            .map((title) => "-${title.replaceAll(":", "")}")
            .toList(),
        date: parseDate(task['date'] as String),
      );
}

enum TaskType {
  geometry("גיאומטריה"),
  trigonometry("טריגונומטריה"),
  calculus('חדו״א'),
  miscellaneous("אחר");

  final String text;

  const TaskType(
    this.text,
  );
}

DateTime parseDate(String date) => DateTime.parse(
        "${(date).split('/')[2].replaceAll(" ", "")}-${(date).split('/')[1]}-${(date).split('/')[0]} 00:00:00")
    .add(const Duration(days: 7));

List<String> parsePages(List<Object?> pages) => pages
    .map((page) => page.toString().contains(":")
        ? "${page.toString().replaceAll(";", "").replaceAll(",", "").replaceAll(".", "").split(":")[1]} :${page.toString().replaceAll(";", "").replaceAll(",", "").replaceAll(".", "").split(":")[0].replaceAll(" ", "")}"
        : "")
    .toList();
