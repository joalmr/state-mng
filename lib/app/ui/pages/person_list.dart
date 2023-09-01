import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_mng/app/data/repositories/person_repository.dart';
import 'package:state_mng/app/domain/providers/person_provider.dart';
import 'package:state_mng/app/ui/pages/person_add.dart';

class PersonListView extends StatefulWidget {
  const PersonListView._();

  static Widget init() => ChangeNotifierProvider(
        lazy: false,
        create: (context) => PersonProvider(
          personRepository: context.read<PersonRepository>(),
        )..load(),
        child: const PersonListView._(),
      );

  @override
  State<PersonListView> createState() => _PersonListViewState();
}

class _PersonListViewState extends State<PersonListView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PersonProvider>(builder: (context, provider, child) {
      final persons = provider.persons;
      return Scaffold(
        appBar: AppBar(),
        body: persons == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: persons.length,
                itemBuilder: (context, index) {
                  final person = persons[index];
                  return ListTile(
                    onTap: () async {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PersonAddView.init(person: person),
                          ));
                      //recarga
                      if (mounted) context.read<PersonProvider>().load();
                    },
                    onLongPress: () {
                      context.read<PersonProvider>().deletePerson(person.id!);
                    },
                    title: Text("${person.name} ${person.lastname}"),
                    subtitle: Text(person.phone),
                  );
                },
              ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {
            await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PersonAddView.init(),
                ));
            //recarga
            if (mounted) context.read<PersonProvider>().load();
          },
        ),
      );
    });
  }
}
