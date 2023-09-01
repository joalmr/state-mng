import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_mng/app/data/repositories/person_repository.dart';
import 'package:state_mng/app/domain/models/person_model.dart';
import 'package:state_mng/app/domain/providers/person_provider_realtime.dart';
import 'package:state_mng/app/ui/pages/realtime/person_add_realtime.dart';

class PersonListRealtimeView extends StatefulWidget {
  const PersonListRealtimeView._();

  static Widget init() => ChangeNotifierProvider(
        lazy: false,
        create: (context) => PersonProviderRealtime(
          personRepository: context.read<PersonRepository>(),
        ),
        child: const PersonListRealtimeView._(),
      );

  @override
  State<PersonListRealtimeView> createState() => _PersonListViewState();
}

class _PersonListViewState extends State<PersonListRealtimeView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PersonProviderRealtime>(
        builder: (context, provider, child) {
      return Scaffold(
        appBar: AppBar(),
        body: StreamBuilder<List<Person>>(
          stream: context.read<PersonProviderRealtime>().loadStream(),
          builder: (context, snapshot) {
            if (!snapshot.hasData ||
                snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final data = snapshot.data!;
            if (data.isEmpty) {
              return const Center(
                child: Text("No tiene datos"),
              );
            }

            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final person = data[index];
                return ListTile(
                  onTap: () async {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              PersonAddRealtimeView.init(person: person),
                        ));
                  },
                  onLongPress: () {
                    context
                        .read<PersonProviderRealtime>()
                        .deletePerson(person.id!);
                  },
                  title: Text("${person.name} ${person.lastname}"),
                  subtitle: Text(person.phone),
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {
            await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PersonAddRealtimeView.init(),
                ));
          },
        ),
      );
    });
  }
}
