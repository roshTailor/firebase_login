
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_login/Helper/FirebaseHelper.dart';
import 'package:firebase_login/Utils/Global.dart';
import 'package:firebase_login/Widget/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../CustomShape/CustomShape.dart';
import 'ProfilePage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  User? user = FirebaseAuth.instance.currentUser;

  Future<FirebaseApp> initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>
              ProfilePage(user: user,
              ),
        ),
      );
    }
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> logInKey = GlobalKey<FormState>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: initializeFirebase(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Form(
              key: logInKey,
              child: CustomPaint(
                painter: CurvePainter(),
                child: SafeArea(
                  top: true,
                  left: true,
                  right: true,
                  minimum: const EdgeInsets.only(top: 70, left: 10, right: 10),
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(10),
                    children: [
                      const Text(
                        "Login",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      TextFormField(
                        controller: AppController.email,
                        decoration: InputDecoration(
                          labelText: 'Email ID',
                          floatingLabelStyle: const TextStyle(
                              color: Colors.deepOrange),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.deepOrange, width: 1.5)
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                        ),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Please Enter the Email ID";
                          }
                          if (!RegExp(
                              r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                              .hasMatch(val)) {
                            return "Enter Valid a Email ID";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        obscureText: BoolVar.obscure,
                        controller: AppController.password,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          floatingLabelStyle: const TextStyle(
                              color: Colors.deepOrange),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.deepOrange, width: 1.5)
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                BoolVar.obscure = !BoolVar.obscure;
                              });
                            },
                            icon: (!BoolVar.obscure)
                                ? const Icon(
                              CupertinoIcons.eye_slash,
                            )
                                : const Icon(
                              CupertinoIcons.eye,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 20,
                          ),
                        ),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Please Enter the Password";
                          }
                          if (!RegExp(
                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                              .hasMatch(val)) {
                            return "Enter Valid a Password";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      BoolVar.isProcessing ? const CircularProgressIndicator() :
                      newButton(
                          onPressed: () async {
                            if (logInKey.currentState!.validate()) {
                              await FirebaseHelper.authLogin(context, setState);
                            }
                          },
                          title: "Sign in"),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Not having account??",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'signUp');
                          AppController.email.clear();
                          AppController.password.clear();
                        },
                        child: const Text(
                          "Sign up here",
                          style: TextStyle(
                            color: Color(0xffF6820A),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
