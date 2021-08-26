import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {
  bool isButtonPressed = true;
  late AnimationController controller;
  late Animation sizeAnimation;
  late Animation colorAnimation;

  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    sizeAnimation = Tween(begin: 100.0, end: 200.0).animate(controller);
    colorAnimation = ColorTween(begin: Colors.blue, end: Colors.red).animate(controller);

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explicit Animations'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                if (isButtonPressed) {
                  controller.forward();
                } else {
                  controller.reverse();
                }

                isButtonPressed = !isButtonPressed;
              },
              child: const Text(
                'Animate',
                style: TextStyle(fontSize: 18),
              ),
            ),
            AnimatedBuilder(
              animation: controller,
              builder: (context, child) => Container(
                height: sizeAnimation.value,
                width: sizeAnimation.value,
                color: colorAnimation.value,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
