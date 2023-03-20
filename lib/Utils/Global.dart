
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppController{
  static TextEditingController email = TextEditingController();
  static TextEditingController password = TextEditingController();
  static TextEditingController confirmPassword = TextEditingController();
  static TextEditingController userName = TextEditingController();
}
class BoolVar{
  static bool logIn = false, register = false,obscure=false;
}