import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:state_mng/app/person/data/person_firebase.dart';
import 'package:state_mng/app/user/data/user_firebase.dart';
import 'package:state_mng/app/person/domain/repositories/person_repository.dart';
import 'package:state_mng/app/user/domain/repositories/user_repository.dart';
import 'package:state_mng/app/user/ui/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<UserRepository>(create: (_) => UserFirebase()),
        Provider<PersonRepository>(create: (_) => PersonFirebase()),
      ],
      child: MaterialApp(
        home: HomeView.init(),
      ),
    );
  }
}
