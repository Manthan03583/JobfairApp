import 'package:flutter/material.dart';

import '../commons/colorselect.dart';

TextStyle labelTextStyle() {
  return const TextStyle(color: Colors.black);
}

LinearGradient gradclr() {
  return LinearGradient(
      colors: [ColorSelect.secondary, const Color.fromARGB(255, 183, 58, 162)]);
}

String labelTextInput = "";
// ignore: prefer_typing_uninitialized_variables
var icon;
// ignore: prefer_typing_uninitialized_variables
var iconColor;

InputDecoration inputFieldDecoration({
  required String labelTextInput,
  required Icon icon,
}) {
  return InputDecoration(
    prefixIcon: icon,
    prefixIconColor: iconColor,
    labelText: labelTextInput,
    labelStyle: labelTextStyle(),
    contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Colors.blueAccent.withOpacity(0.3),
        width: 2,
        )),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide:  BorderSide(color: Color.fromARGB(255, 9, 94, 241),width: 2)),
    errorBorder: OutlineInputBorder(
      gapPadding: 0.0,
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(
        color: Colors.red,
        width: 2,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.red,
        width: 2
      ),
      borderRadius: BorderRadius.circular(15),
    ),
    hintStyle: const TextStyle(fontSize: 16, color: Colors.black),
    border: const OutlineInputBorder(),
  );
}
