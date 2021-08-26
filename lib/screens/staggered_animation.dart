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
  Tween sizeTween = Tween(begin: 100.0, end: 200.0);
  ColorTween colorTween = ColorTween(begin: Colors.blue, end: Colors.red);

  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    sizeAnimation = sizeTween.animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 0.6, curve: Curves.easeInOutCubic),
      ),
    );
    colorAnimation = colorTween.animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.4, 1, curve: Curves.ease),
      ),
    );

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
        title: const Text('Staggered Animations'),
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
