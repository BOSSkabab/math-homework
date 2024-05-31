import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:math_homework/hasura_helper.dart';
import 'package:math_homework/task.dart';

Stream<List<Task>> fetchHomework() => getClient()
    .subscribe(
      SubscriptionOptions<List<Task>>(
        document: gql(fetchHomeworkSubscription),
        parserFn: (tasks) =>
            (tasks["data"]["homework"] as List<Map<String, dynamic>>)
                .map((task) => Task.fromJson(task))
                .toList(),
      ),
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
