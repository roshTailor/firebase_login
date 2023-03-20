import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login/Helper/FirebaseHelper.dart';
import 'package:flutter/material.dart';

import '../Utils/Global.dart';

class ProfilePage extends StatefulWidget {
  final User user;

  const ProfilePage({super.key, required this.user});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late User _currentUser;

  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ProfilePage"),
        backgroundColor: Colors.orangeAccent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () async {
              User? user = await FirebaseHelper.refreshUser(_currentUser);
              if (user != null) {
                setState(() {
                  _currentUser = user;
                });
              }
            },
          ),
          BoolVar.isSigningOut
              ? const CircularProgressIndicator()
              : IconButton(
                  icon: const Icon(Icons.logout_outlined),
                  onPressed: () async {
                    setState(() {
                      BoolVar.isSigningOut = true;
                    });
                    await FirebaseAuth.instance.signOut();
                    setState(() {
                      BoolVar.isSigningOut = false;
                    });
                    Navigator.pushReplacementNamed(context,'LoginPage');
                  },
                ),

        ],
      ),
      body: Column(
        children: [
          ListTile(
            title: Text(
              '${_currentUser.displayName}',
            ),
            subtitle: Text(
              '${_currentUser.email}',
            ),
            leading: _currentUser.emailVerified
                ? const Icon(Icons.verified, color: Colors.green)
                : const Icon(Icons.not_interested, color: Colors.red),
            trailing: IconButton(
                    icon: Icon(Icons.send,color:(BoolVar.isSendingVerification)? Colors.red:Colors.grey),
                    onPressed: () async {
                      setState(() {
                        BoolVar.isSendingVerification = true;
                      });
                      await _currentUser.sendEmailVerification();
                      setState(() {
                        BoolVar.isSendingVerification = false;
                      });
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
