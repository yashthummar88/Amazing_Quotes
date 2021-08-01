import 'package:amazing_quotes/screens/category_screen.dart';
import 'package:amazing_quotes/screens/home_screen.dart';
import 'package:amazing_quotes/screens/quotes_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        canvasColor: Color(0xffedf2fb),
      ),
      routes: {
        "/": (context) => HomeScreen(),
        CategoryScreen.routes: (context) => CategoryScreen(),
      },
    ),
  );
}
