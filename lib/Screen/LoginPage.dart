import 'package:firebase_login/Helper/FirebaseHelper.dart';
import 'package:firebase_login/Utils/Global.dart';
import 'package:firebase_login/Widget/widget.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FirebaseHelper instance = FirebaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        left: true,
        right: true,
        //minimum: const EdgeInsets.all(10),
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            const FlutterLogo(),
            const Text(
              "Login to your account",
              textAlign: TextAlign.center,
            ),
            textFormField(
                label: 'Email ID', textController: AppController.email, ObscureText: null),
            textFormField(
                label: 'Password', textController: AppController.password, ObscureText: null),
            newButton(
                onPressed: () {
                  instance.authCreateNewUser(
                    email: AppController.email.text,
                    password: AppController.password.text,
                  );
                },
                title: "Sign in"),
            const Text(
              "Or",
              textAlign: TextAlign.center,
            ),
            newButton(onPressed: () {}, title: "Sign up"),
          ],
        ),
      ),
    );
  }
}
