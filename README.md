# Animation Tutorial

This repository has all the code that has been done in live.

## Which type of animation to choose?

1. If you want to animate any parameter of TextStyle the go with `AnimatedDefaultTextStyle`
2. If you want basic animations and the implicit animation widget is available like AnimatedContainer, then go with Implicit Animations
3. If implicit animation widget is not available, then go with Explicit animation.
4. If you want different animations to start and end at different points, then go with Staggered Animations.
5. And if you want animations in `Custom Painter` then go with Custom Painter Animations. This will allow you to animation any pixel of your app with any kind of animation you want.

## Heres how each part works

### Animated Text Style

Heres example code of it
```dart
AnimatedDefaultTextStyle(
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
```

To use `AnimatedDefaultTextStyle`, we need to update the value of any parameter which we want to animate. For example, here we are changing font size from 25 to 30 with setState when isButtonPressed bool is changed. We can animate all the parameters of TextStyle in same way.

### Implicit Animation

Implicit animations are kind of similar to AnimatedDefaultTextStyle. In this, we would replace normal widgets with animated widgets one.
For Example: 
- Container -> AnimatedContainer
- Padding -> AnimatedPadding
- Opacity -> AnimatedOpacity
and so on...

Then after that, we would set duration of animation by 
```dart
const Duration(seconds: 1)
```
And finally we would update the parameter that we want to animate with setState and variable.
Heres full code explaining that
```dart
AnimatedContainer(
  height: isButtonPressed ? 200 : 100,
  width: isButtonPressed ? 200 : 100,
  duration: const Duration(seconds: 1),
  color: isButtonPressed ? Colors.red : Colors.blue,
),
```
For example, the height is swapped between 200 and 100 depending on isButtonPressed bool value.

### Explicit Animation

Explicit Animations allows one to create much advanced animations, and also can animate preety much any parameter!!!
For this we need to first declare Animation and AnimationController.

```dart
late AnimationController controller;
late Animation sizeAnimation;
late Animation colorAnimation;
```

Now we need to extend our widget with `SingleTickerProviderStateMixin` like this:

```dart
class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {
```

After this, we would initialize variables in initState like this:

```dart
@override
void initState() {
  controller = AnimationController(vsync: this, duration: const Duration(seconds: 2));
  sizeAnimation = Tween(begin: 100.0, end: 200.0).animate(controller);
  colorAnimation = ColorTween(begin: Colors.blue, end: Colors.red).animate(controller);

  super.initState();
}
```

As the controller is initialized, it also needs to be disposed so that memory leak in app doesn't occur and also increases performance of app

```dart
@override
void dispose() {
  controller.dispose();

  super.dispose();
}
```

And now we just need to wrap the widget that we need to animate with AnimatedBuilder and then animate the parameter by passing Animation widget with .value method called

```dart
AnimatedBuilder(
  animation: controller,
  builder: (context, child) => Container(
    height: sizeAnimation.value,
    width: sizeAnimation.value,
    color: colorAnimation.value,
  ),
),
```

### Staggered Animation

Staggered Animations are very similar to Explicit Animation. The ony difference is that in this, we are defining different animations with different start and end points. So the only change in the code is as like that we are not directly passing controller in `.animate()`, but passing `CurvedAnimation` and then in `curve` we can use `Interval()` and pass curve accordingly (default is `Curves.linear`). Heres a little example of it:

```dart
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
```

### Animated Custom Painter

In this one, we are using Custom Painter to draw any kind of shapes, patterns, and so on. And then we are animating different aspects of it. In the given below example, I am animating a arc so that it sweeps full rotation. All the code will be same as that of Explicit Animation. The change is in the Painter. In it, we pass the controller with the help of constructor and then use that controller to create Animation variables and finally use them to animate different parts of custom painter. Heres the example of it:

```dart
class AnimatedCustomPainter extends CustomPainter {
  Paint _paint = Paint();
  final Animation<double> _sweep;
  final Animation _color;

  AnimatedCustomPainter(AnimationController controller)
      : _sweep = Tween<double>(begin: 0, end: 2 * pi).animate(controller),
        _color = ColorTween(begin: Colors.red, end: Colors.blue).animate(controller),
        super(repaint: controller);

  @override
  void paint(Canvas canvas, Size size) {
    _paint.color = _color.value;

    canvas.drawArc(
      Rect.fromPoints(Offset(50, 50), Offset(250, 250)),
      -pi / 2,
      _sweep.value,
      true,
      _paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
```
