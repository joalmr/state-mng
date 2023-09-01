import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:state_mng/app/data/repositories/user_repository.dart';

class UserProvider extends ChangeNotifier {
  UserProvider({required this.userRepository});
  final UserRepository userRepository;

  Future<UserCredential?> signInGoogle() async {
    final response = await userRepository.signInGoogle();

    notifyListeners();
    return response;
  }

  Future<void> signOut() async {
    await userRepository.signOut();
    notifyListeners();
  }
}
