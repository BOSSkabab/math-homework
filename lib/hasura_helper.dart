import "package:flutter/material.dart";
import 'package:graphql_flutter/graphql_flutter.dart';

GraphQLClient getClient() {
  final HttpLink httpLink = HttpLink(
    "https://math-homework.hasura.app/v1/graphql",
  );
  final WebSocketLink webSocketLink = WebSocketLink(
    "wss://math-homework.hasura.app/v1/graphql",
    config: const SocketClientConfig(),
  );
  return GraphQLClient(
    link: Link.split(
      (final Request request) => request.isSubscription,
      webSocketLink,
      httpLink,
    ),
    cache: GraphQLCache(),
  );
}

extension MapQueryResult<A> on QueryResult<A?> {
  A mapQueryResult() => (hasException
      ? throw exception!
      : data == null
          ? (throw Exception("Data returned null"))
          : parsedData!);

  A? mapQueryResultNullable() => (hasException ? throw exception! : parsedData);
}

A queryResultToParsed<A>(final QueryResult<A> result) =>
    result.mapQueryResult();

extension MapSnapshot<T> on AsyncSnapshot<T> {
  V mapSnapshot<V>({
    required final V Function(T) onSuccess,
    required final V Function() onWaiting,
    required final V Function() onNoData,
    required final V Function(Object) onError,
  }) =>
      hasError
          ? onError(error!)
          : (ConnectionState.waiting == connectionState
              ? onWaiting()
              : (hasData ? onSuccess(data as T) : onNoData()));
}
