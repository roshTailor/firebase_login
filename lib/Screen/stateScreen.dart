import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_login/Screen/LoginPage.dart';
import 'package:flutter/material.dart';

import 'ProfilePage.dart';

class AuthState extends StatefulWidget {
  const AuthState({Key? key}) : super(key: key);

  @override
  State<AuthState> createState() => _AuthStateState();
}

class _AuthStateState extends State<AuthState> {
  User? user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapShot){
          print(snapShot.data);
          if(snapShot.data==null){
            return ProfilePage(user: user!,);
          }
          else{
            return const LoginPage();
          }
        },
      ),
    );
  }
}
