import 'package:animation_tutorial_code/screens/explicit_animation.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Text Animation',
      home: MainScreen(),
    );
  }
}
