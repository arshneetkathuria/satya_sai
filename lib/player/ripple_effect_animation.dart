import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:satya_sai/constants/constants.dart';

class RippleEffectAnimation extends StatefulWidget {
  const RippleEffectAnimation({Key? key}) : super(key: key);

  @override
  _RippleEffectAnimationState createState() => _RippleEffectAnimationState();
}

class _RippleEffectAnimationState extends State<RippleEffectAnimation> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller=AnimationController(
vsync: this,
      duration: const Duration(seconds: 3),
      lowerBound: 0.5
    )..repeat();
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    _controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn),
      builder: (BuildContext context, Widget? child) {
       return Stack(
            alignment: Alignment.center,
            children: [
              _buildContainer(100*_controller.value),
              _buildContainer(150*_controller.value),
              _buildContainer(200*_controller.value),
            ]
       );
      }
    );
  }

  Widget _buildContainer(double radius)
  {
    return Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color:pink.withOpacity(1-_controller.value)
      ),
    );
  }
}
