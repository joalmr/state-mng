import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:state_mng/app/data/repositories/person_repository.dart';
import 'package:state_mng/app/domain/models/person_model.dart';

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
  Future<List<Person>> getPerson() async {
    final querySnapshot = await personRef.get();
    final persons = querySnapshot.docs.map((e) => e.data()).toList();

    return persons;
  }

  @override
  Future<void> addPerson(Person person) async {
    await personRef.add(person);
  }

  @override
  Future<void> deletePerson(String id) async {
    await personRef.doc(id).delete();
  }

  @override
  Future<void> updatePerson(Person person) async {
    await personRef.doc(person.id).update(person.toJson());
  }
}
