import 'package:flutter/material.dart';
import 'view/HomePage.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
    theme: ThemeData(
        hintColor: Colors.white70,
        primaryColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
          hintStyle: TextStyle(color: Colors.white),
        )),
  ));
}
