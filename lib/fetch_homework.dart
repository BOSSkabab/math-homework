import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:math_homework/hasura_helper.dart';
import 'package:math_homework/task.dart';

Stream<List<Task>> fetchHomework() => getClient()
    .subscribe(
      SubscriptionOptions<List<Task>>(
          document: gql(fetchHomeworkSubscription),
          parserFn: (final Map<String, dynamic> data) {
            List<dynamic> tasks = data["homework"] as List<dynamic>;
            // print(data["homework"][0]["pages"]);
            return tasks.map<Task>((task) => Task.parse(task)).toList();
          }),
    )
    .map(
      (task) => task.mapQueryResult(),
    );

String fetchHomeworkSubscription = """
subscription fetchHomework {
  homework(where: {finished: {_eq: false}}) {
    date
    pages
    title
    type
  }
}
""";
