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
        title: const Text('Implicit Animations'),
      ),
      body: Center(
        child: Column(
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
            AnimatedContainer(
              height: isButtonPressed ? 200 : 100,
              width: isButtonPressed ? 200 : 100,
              duration: const Duration(seconds: 1),
              color: isButtonPressed ? Colors.red : Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
