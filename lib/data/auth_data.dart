import 'package:firebase_auth/firebase_auth.dart';
import 'package:todolist/data/firestore.dart';

abstract class authenticationDataSource {
  Future<void> register(String email, String password, String confirmpass);

  Future<void> login(String email, String password);
}

class AuthenticationRemote extends authenticationDataSource {
  @override
  Future<void> login(String email, String password) async {
    // TODO: implement login
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(), password: password.trim());
  }

  @override
  Future<void> register(String email, String password,
      String confirmpass) async {
    // TODO: implement register
    if (confirmpass == password) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.trim(), password: password.trim()).then((value) {
        Firestore_Datasource().CreateUser(email);
      });
    }
  }
}