import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_mng/app/data/repositories/user_repository.dart';
import 'package:state_mng/app/domain/providers/user_provider.dart';
import 'package:state_mng/app/ui/pages/realtime/person_add_realtime.dart';
import 'package:state_mng/app/ui/pages/realtime/person_list_realtime.dart';

class HomeView extends StatefulWidget {
  const HomeView._();

  static Widget init() => ChangeNotifierProvider(
        lazy: false,
        create: (context) => UserProvider(
          userRepository: context.read<UserRepository>(),
        ),
        child: const HomeView._(),
      );

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    String? email;

    return Consumer<UserProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(),
          backgroundColor: email == null ? null : Colors.green[100],
          body: SizedBox(
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 25),
                Text(email == null ? "Google Auth" : "Success! $email!"),
                TextButton(
                  onPressed: email == null
                      ? () async {
                          final response = await provider.signInGoogle();
                          email = response?.user?.email;
                        }
                      : () async {
                          await provider.signOut();
                          email = null;
                        },
                  child: email == null
                      ? const Text("Login")
                      : const Text("Cerrar"),
                ),
                const SizedBox(height: 50),
                Column(
                  children: [
                    TextButton(
                      onPressed: email == null
                          ? null
                          : () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => PersonListView.init()),
                              );
                            },
                      child: const Text("Lista personas realtime"),
                    ),
                    TextButton(
                      onPressed: email == null
                          ? null
                          : () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => PersonAddView.init()),
                              );
                            },
                      child: const Text("Agregar persona"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
