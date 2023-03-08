import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:testing_bloc_course/bloc/bloc_actions.dart';
import 'package:testing_bloc_course/bloc/person.dart';
import 'package:testing_bloc_course/bloc/persons_bloc.dart';

// Defining the moceked Iterables of Person that are going to be returned from our PersonsLoader
const mockedPersons1 = [
  Person(
    name: 'Winna',
    age: 7,
  ),
  Person(
    name: 'Lucy',
    age: 19,
  ),
  Person(
    name: 'Cecy',
    age: 21,
  ),
];

const mockedPersons2 = [
  Person(
    name: 'Jota',
    age: 17,
  ),
  Person(
    name: 'John',
    age: 25,
  ),
  Person(
    name: 'Nado',
    age: 28,
  ),
];

// Defining the functions that are going to be the PersonsLoader and load our iterables of Person
Future<Iterable<Person>> mockGetPersons1(String url) =>
    Future.value(mockedPersons1);
Future<Iterable<Person>> mockGetPersons2(String url) =>
    Future.value(mockedPersons2);

// THE ACTUAL TESTING
void main() {
  group('bloc tests', () {
// write our tests
    late PersonsBloc bloc;

    setUp(() {
      bloc = PersonsBloc();
    });

    // Testing the initial state to be null
    blocTest<PersonsBloc, FetchResult?>(
      'Test initial state',
      build: () => bloc,
      verify: (bloc) => expect(
        bloc.state,
        null,
      ),
    );

    // fetch mock data (persons1) and compare it with the FetchResult
    blocTest(
      'Mock retrieving persons from first iterable',
      build: () => bloc,
      act: (bloc) {
        bloc.add(
          const LoadPersonsAction(
            url: 'dummy_url',
            loader: mockGetPersons1,
          ),
        );
        bloc.add(
          const LoadPersonsAction(
            url: 'dummy_url',
            loader: mockGetPersons1,
          ),
        );
      },
      expect: () => [
        const FetchResult(
          persons: mockedPersons1,
          isRetrievedFromCache: false,
        ),
        const FetchResult(
          persons: mockedPersons1,
          isRetrievedFromCache: true,
        ),
      ],
    );

    // fetch mock data (persons2) and compare it with the FetchResult
    blocTest(
      'Mock retrieving persons from seconditerable',
      build: () => bloc,
      act: (bloc) {
        bloc.add(
          const LoadPersonsAction(
            url: 'dummy_url',
            loader: mockGetPersons2,
          ),
        );
        bloc.add(
          const LoadPersonsAction(
            url: 'dummy_url',
            loader: mockGetPersons2,
          ),
        );
      },
      expect: () => [
        const FetchResult(
          persons: mockedPersons2,
          isRetrievedFromCache: false,
        ),
        const FetchResult(
          persons: mockedPersons2,
          isRetrievedFromCache: true,
        ),
      ],
    );
  });
}
