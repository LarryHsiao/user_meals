import 'package:flutter/material.dart';
import 'package:user_meals/landing_page.dart';

void main() {
  runApp(const UserMealApp());
}

class UserMealApp extends StatelessWidget {
  const UserMealApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User meals',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LandingPage(title: 'Flutter Demo Home Page'),
    );
  }
}

