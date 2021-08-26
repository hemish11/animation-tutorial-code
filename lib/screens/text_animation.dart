import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isButtonPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text Animations'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              setState(() {
                isButtonPressed = !isButtonPressed;
              });
            },
            child: const Text(
              'Animate',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Center(
            child: AnimatedDefaultTextStyle(
              style: isButtonPressed
                  ? const TextStyle(
                      fontSize: 25,
                      color: Colors.red,
                      backgroundColor: Colors.cyan,
                    )
                  : const TextStyle(
                      fontSize: 30,
                      color: Colors.green,
                      backgroundColor: Colors.yellow,
                    ),
              duration: const Duration(seconds: 1),
              child: const Text('Hello World'),
            ),
          ),
        ],
      ),
    );
  }
}
