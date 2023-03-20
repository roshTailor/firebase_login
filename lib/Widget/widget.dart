import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget newButton({required onPressed, required String title}) {
  return CupertinoButton(
    onPressed: onPressed,
    color: Colors.orangeAccent,
    child: Text(title),

  );
}

Widget textFormField({required String label,required TextEditingController textController,required bool ObscureText,}) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: TextFormField(
      obscureText: ObscureText,
      controller: textController,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: const EdgeInsets.all(10),
      ),
    ),
  );
}
