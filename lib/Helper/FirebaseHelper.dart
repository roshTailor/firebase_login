
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login/Utils/Global.dart';

class FirebaseHelper {
  static FirebaseHelper instance = FirebaseHelper();
  User? user;

  authRegister(context, setState) async {
    try {
      setState(() {
        BoolVar.register = true;
      });
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: AppController.email.text,
        password: AppController.password.text,
      );
      print("Create new user");
      user = userCredential.user;
      await user!.updateDisplayName(AppController.userName.text);
      await user!.reload();

      print("Registered user :: $user");
      Navigator.pushReplacementNamed(
        context,
        'HomePage',
      );
      setState(() {
        BoolVar.register = false;
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        BoolVar.register = false;
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
    }catch (e) {
      print(e);
    }
  }

  authLogin(context, setState) async {
    try {
      setState(() {
        BoolVar.logIn = true;
      });
      final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: AppController.email.text,
        password: AppController.password.text,
      );
      user = userCredential.user;
      print("Sign in success Register User :: $user");
      Navigator.pushReplacementNamed(
        context,
        'HomePage',
      );
      setState(() {
        BoolVar.logIn = false;
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        BoolVar.logIn = false;
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
}
