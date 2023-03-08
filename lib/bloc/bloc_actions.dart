import 'package:flutter/foundation.dart' show immutable;
import 'person.dart';

// Defining the urls for persons1 and persons PersonUrl
const persons1Url = 'http://127.0.0.1:5500/api/persons1.json';
const persons2Url = 'http://127.0.0.1:5500/api/persons2.json';

// Type definition for the url loader
typedef PersonsLoader = Future<Iterable<Person>> Function(String url);

// Generic type for our the events of our bloc
@immutable
abstract class LoadAction {
  const LoadAction();
}

// Defining the event for loading persons
@immutable
class LoadPersonsAction implements LoadAction {
  final String url;
  final PersonsLoader loader;
  const LoadPersonsAction({
    required this.url,
    required this.loader,
  }) : super();
}
