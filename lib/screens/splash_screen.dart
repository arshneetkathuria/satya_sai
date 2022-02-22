import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 2),
        lowerBound: 0.1,
        upperBound: 0.7)
      ..forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pushNamed(context, '/LanguageSelection');
      }
    });
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: double.infinity,
      child: Stack(alignment: Alignment.center, children: [
        Image.asset("assets/images/splashScreen.png",
            fit: BoxFit.fitWidth, width: double.infinity),
        AnimatedBuilder(
            animation: _controller,
            builder: (BuildContext context, Widget? child) {
              return Image.asset("assets/images/logo.png",
                  width: MediaQuery.of(context).size.width * _controller.value);
            })
      ]),
    ));
  }
}
