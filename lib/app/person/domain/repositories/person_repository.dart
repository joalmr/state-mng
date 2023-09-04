import 'package:state_mng/app/person/domain/model/person_model.dart';

abstract class PersonRepository {
  Stream<List<Person>> getPersonStream();
  Future<Person> addPerson(Person person);
  Future<Person> updatePerson(Person person);
  Future<void> deletePerson(String id);
}
