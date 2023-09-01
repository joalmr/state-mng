import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_mng/app/data/repositories/person_repository.dart';
import 'package:state_mng/app/domain/models/person_model.dart';
import 'package:state_mng/app/domain/providers/person_provider.dart';

class PersonAddView extends StatefulWidget {
  const PersonAddView._();

  static Widget init({Person? person}) => ChangeNotifierProvider(
        lazy: false,
        create: (context) => PersonProvider(
          personRepository: context.read<PersonRepository>(),
          person: person,
        ),
        child: const PersonAddView._(),
      );

  @override
  State<PersonAddView> createState() => _PersonAddViewState();
}

class _PersonAddViewState extends State<PersonAddView> {
  final _controllerName = TextEditingController();
  final _controllerLastname = TextEditingController();
  final _controllerPhone = TextEditingController();

  Future<void> _loadInit() async {
    final person = context.read<PersonProvider>().person;
    if (person != null) {
      _controllerName.text = person.name;
      _controllerLastname.text = person.lastname;
      _controllerPhone.text = person.phone;
    }
  }

  @override
  void initState() {
    _loadInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PersonProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _controllerName,
                  decoration: const InputDecoration(
                    label: Text("Name"),
                  ),
                ),
                TextField(
                  controller: _controllerLastname,
                  decoration: const InputDecoration(
                    label: Text("Lastname"),
                  ),
                ),
                TextField(
                  controller: _controllerPhone,
                  decoration: const InputDecoration(
                    label: Text("Phone"),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.save),
            onPressed: () async {
              final newPerson = Person(
                name: _controllerName.text,
                lastname: _controllerLastname.text,
                phone: _controllerPhone.text,
              );
              await context.read<PersonProvider>().addPerson(newPerson);
              if (mounted) Navigator.pop(context);
            },
          ),
        );
      },
    );
  }
}
