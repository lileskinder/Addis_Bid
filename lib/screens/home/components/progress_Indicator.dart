import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimerProgressIndicator extends StatefulWidget {
  @override
  _TimerProgressIndicatorState createState() => _TimerProgressIndicatorState();
}

class _TimerProgressIndicatorState extends State<TimerProgressIndicator>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 30000), vsync: this);
    animation = Tween(begin: 1.0, end: 0.0).animate(controller)
      ..addListener(() {
        setState(() {
          //Do Something here
        });
      });
    controller.repeat();
  }

  @override
  void dispose() {
    controller.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(8),
        bottomRight: Radius.circular(8),
      ),
      child: LinearProgressIndicator(
        value: animation.value, // Defaults to 0.5.
        valueColor: AlwaysStoppedAnimation(Colors.pink),
        backgroundColor: Color(0xFFCFD8DC),
      ),
    );
  }
}
