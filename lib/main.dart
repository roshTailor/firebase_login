import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_login/Screen/ProfilePage.dart';
import 'package:firebase_login/Screen/LoginPage.dart';
import 'package:firebase_login/Screen/SignUpPage.dart';
import 'package:firebase_login/Screen/stateScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Screen/SplashScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(
          bodyText2: GoogleFonts.lato(color: Colors.black),
          bodyText1: GoogleFonts.lato(color: Colors.black),
        ),
      ),
      routes: {
        '/': (context) => const Splash(),
        'LoginPage': (context) => const LoginPage(),
        'signUp': (context) => const SignUpPage(),
      },
    ),
  );
}
