
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseHelper{
  static FirebaseHelper instance = FirebaseHelper();
  User? user;

  authCreateNewUser({required String email, required String password}) async {
    try {
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      print("Create new user");
      user = userCredential.user;
      print("Registered user :: $user");
    } catch (error) {
      print(error);
    }
  }

  authSignInUser({required String email, required String password}) async {
    try {
      final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      print("Sign in success");
    } catch (error) {
      print(error);
    }
  }

}