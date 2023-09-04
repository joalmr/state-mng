import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:state_mng/app/person/domain/repositories/person_repository.dart';
import 'package:state_mng/app/person/domain/model/person_model.dart';

class PersonFirebase implements PersonRepository {
  final personRef =
      FirebaseFirestore.instance.collection('persons').withConverter(
            fromFirestore: (snapshot, _) {
              final person = Person.fromJson(snapshot.data()!);
              final newPerson = person.copyWith(id: snapshot.id);
              return newPerson;
            },
            toFirestore: (person, _) => person.toJson(),
          );

  @override
  Stream<List<Person>> getPersonStream() {
    final result = personRef.snapshots().map(
          (event) => event.docs
              .map(
                (e) => e.data(),
              )
              .toList(),
        );
    return result;
  }

  @override
  Future<Person> addPerson(Person person) async {
    final result = await personRef.add(person);
    return person.copyWith(id: result.id);
  }

  @override
  Future<Person> updatePerson(Person person) async {
    await personRef.doc(person.id).update(person.toJson());
    return person;
  }

  @override
  Future<void> deletePerson(String id) async {
    await personRef.doc(id).delete();
  }
}
