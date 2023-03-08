import 'package:flutter/foundation.dart' show immutable;

// Creating a person class that can be initialized from our json object
//(or allow us to create a person directly from the json object)

@immutable
class Person {
  final String name;
  final int age;

  const Person({
    required this.name,
    required this.age,
  });

  Person.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        age = json['age'] as int;

  @override
  String toString() => 'Person (name:$name, age: $age)';
}
