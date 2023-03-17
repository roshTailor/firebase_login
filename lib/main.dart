import 'package:firebase_login/Screen/LoginPage.dart';
import 'package:firebase_login/Screen/SignUpPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      'login':(context)=> const LoginPage(),
      'signUp':(context)=> const SignUpPage(),
    },
  ));
}

