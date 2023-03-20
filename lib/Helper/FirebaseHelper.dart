import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login/Utils/Global.dart';

import '../Screen/ProfilePage.dart';

class FirebaseHelper {
  static authRegister(context, setState, name, email, password) async {
    FirebaseAuth instance = FirebaseAuth.instance;
    User? user;
    try {
      setState(() {
        BoolVar.register = true;
      });
      final userCredential = await instance.createUserWithEmailAndPassword(
        email: AppController.email.text,
        password: AppController.password.text,
      );
      print("Create new user");
      user = userCredential.user;
      await user!.updateDisplayName(AppController.userName.text);
      await user.reload();
      user = instance.currentUser;
      print("Registered user :: $user");
      Navigator.pushReplacementNamed(
        context,
        'LoginPage',
      );
      setState(() {
        BoolVar.register = false;
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        BoolVar.register = false;
      });
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for this Email ID.');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("The account already exists for this Email ID."),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  static authLogin(context, setState) async {
    FirebaseAuth instance = FirebaseAuth.instance;
    User? user;
    try {
      setState(() {
        BoolVar.logIn = true;
      });
      final userCredential =
          await instance.signInWithEmailAndPassword(
        email: AppController.email.text,
        password: AppController.password.text,
      );
      user = userCredential.user;
      print("Sign in success Register User :: $user");
      Navigator.of(context)
          .pushReplacement(
        MaterialPageRoute(
          builder: (context) =>
              ProfilePage(user: user!),
        ),
      );
      setState(() {
        BoolVar.logIn = false;
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        BoolVar.logIn = false;
      });
      if (e.code == 'user-not-found') {
        print('No user found for this email.');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("No user found for this email."),
          ),
        );
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Wrong password provided."),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  static refreshUser(User user) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    await user.reload();
    User? refreshedUser = auth.currentUser;

    return refreshedUser;
  }
}
