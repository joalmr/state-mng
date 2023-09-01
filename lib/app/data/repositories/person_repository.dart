import 'package:state_mng/app/domain/models/person_model.dart';

abstract class PersonRepository {
  Future<List<Person>> getPerson();
  Future<void> addPerson(Person person);
  Future<void> updatePerson(Person person);
  Future<void> deletePerson(String id);
}
