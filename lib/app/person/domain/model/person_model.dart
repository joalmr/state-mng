// To parse this JSON data, do
//
//     final person = personFromJson(jsonString);

import 'dart:convert';

Person personFromJson(String str) => Person.fromJson(json.decode(str));

String personToJson(Person data) => json.encode(data.toJson());

class Person {
  String name;
  String lastname;
  String phone;
  String? id;

  Person({
    required this.name,
    required this.lastname,
    required this.phone,
    this.id,
  });

  Person copyWith({
    String? name,
    String? lastname,
    String? phone,
    String? id,
  }) =>
      Person(
        name: name ?? this.name,
        lastname: lastname ?? this.lastname,
        phone: phone ?? this.phone,
        id: id ?? this.id,
      );

  factory Person.fromJson(Map<String, dynamic> json) => Person(
        name: json["name"],
        lastname: json["lastname"],
        phone: json["phone"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "lastname": lastname,
        "phone": phone,
      };
}
