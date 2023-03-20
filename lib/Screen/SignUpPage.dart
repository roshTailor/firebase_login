import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login/Helper/FirebaseHelper.dart';
import 'package:firebase_login/Utils/Global.dart';
import 'package:firebase_login/Widget/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../CustomShape/CustomShape.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> signUpKey = GlobalKey<FormState>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Form(
        key: signUpKey,
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
                  "Sign In",
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
                  controller: AppController.userName,
                  decoration: InputDecoration(
                    labelText: 'User name',
                    floatingLabelStyle:
                        const TextStyle(color: Colors.deepOrange),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.deepOrange, width: 1.5)),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                  ),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please enter User name";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: AppController.email,
                  decoration: InputDecoration(
                    labelText: 'Email ID',
                    floatingLabelStyle:
                        const TextStyle(color: Colors.deepOrange),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.deepOrange, width: 1.5)),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
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
                    floatingLabelStyle:
                        const TextStyle(color: Colors.deepOrange),
                    focusedBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.deepOrange, width: 1.5)),
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
                      return "Please Enter the Email ID";
                    }
                    if (!RegExp(
                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
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
                  controller: AppController.confirmPassword,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    floatingLabelStyle:
                        const TextStyle(color: Colors.deepOrange),
                    focusedBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.deepOrange, width: 1.5)),
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
                        vertical: 10, horizontal: 20),
                  ),
                  validator: (val) {
                    if (val != AppController.password.text) {
                      return "Password doesn't match";
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                newButton(
                  onPressed: () async {
                    if (signUpKey.currentState!.validate()) {
                       await FirebaseHelper.authRegister(
                        context,
                        setState,
                        AppController.userName.text,
                        AppController.email.text,
                        AppController.password.text,
                      );
                    }
                    AppController.email.clear();
                    AppController.password.clear();
                    AppController.userName.clear();
                  },
                  title: "Sign Up",
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Already having account??",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, 'State', (route) => false);
                    AppController.email.clear();
                    AppController.password.clear();
                  },
                  child: const Text(
                    "LogIn here",
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
      ),
    );
  }
}
