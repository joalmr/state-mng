import 'package:state_mng/app/domain/models/person_model.dart';

abstract class PersonRepository {
  Future<List<Person>> getPerson();
  Stream<List<Person>> getPersonStream();
  Future<Person> addPerson(Person person);
  Future<Person> updatePerson(Person person);
  Future<void> deletePerson(String id);
}
