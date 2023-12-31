import 'package:flutter/material.dart';
import 'package:state_mng/app/data/repositories/person_repository.dart';
import 'package:state_mng/app/domain/models/person_model.dart';

class PersonProvider extends ChangeNotifier {
  PersonProvider({
    required this.personRepository,
    this.person,
  });
  final PersonRepository personRepository;
  final Person? person;

  List<Person>? persons;

  Future<void> load() async {
    persons = await personRepository.getPerson();
    notifyListeners();
  }

  Future<void> addPerson(Person newPerson) async {
    if (person != null) {
      await personRepository.updatePerson(newPerson.copyWith(id: person!.id));
    } else {
      await personRepository.addPerson(newPerson);
    }

    notifyListeners();
  }

  Future<void> deletePerson(String id) async {
    await personRepository.deletePerson(id);
    load();
  }
}
