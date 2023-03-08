import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'bloc_actions.dart';
import 'person.dart';

extension IsEqualToEvenIgnoringOrder<T> on Iterable<T> {
  bool isEqualToEvenIgnoringOrde(Iterable<T> otherIterable) =>
      length == otherIterable.length &&
      {...this}.intersection({...otherIterable}).length == length;
}

// The output is isEqualToEvenIgnoringOrdergoing to be return ofter the event
@immutable
class FetchResult {
  final Iterable<Person> persons;
  final bool isRetrievedFromCache;

  const FetchResult({
    required this.persons,
    required this.isRetrievedFromCache,
  });

  @override
  String toString() =>
      'FetchResult (isRetrievedFromCache: $isRetrievedFromCache, person: $persons)';

  @override
  bool operator ==(covariant FetchResult other) =>
      persons.isEqualToEvenIgnoringOrde(other.persons) &&
      isRetrievedFromCache == other.isRetrievedFromCache;

  @override
  int get hashCode => Object.hash(persons, isRetrievedFromCache);
}

// Defining the bloc header, here we say when a given event happen what we return
class PersonsBloc extends Bloc<LoadAction, FetchResult?> {
  final Map<String, Iterable<Person>> _cache = {};
  PersonsBloc() : super(null) {
    on<LoadPersonsAction>(
      (event, emit) async {
        final url = event.url;

        if (_cache.containsKey(url)) {
          final cachedPersons = _cache[url]!;
          final result = FetchResult(
            persons: cachedPersons,
            isRetrievedFromCache: true,
          );
          emit(result);
        } else {
          final loader = event.loader;
          final persons = await loader(url);
          _cache[url] = persons;
          final result = FetchResult(
            persons: persons,
            isRetrievedFromCache: false,
          );
          emit(result);
        }
      },
    );
  }
}
