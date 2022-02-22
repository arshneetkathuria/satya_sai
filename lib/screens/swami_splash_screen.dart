import 'package:flutter/cupertino.dart';

class SwamiSplashScreen extends StatefulWidget {
  const SwamiSplashScreen({Key? key}) : super(key: key);

  @override
  _SwamiSplashScreenState createState() => _SwamiSplashScreenState();
}


class _SwamiSplashScreenState extends State<SwamiSplashScreen> {

  @override
  void didChangeDependencies() {
    Future.delayed(const Duration(seconds: 2),(){
      Navigator.pushNamed(context, '/SplashScreen');
    });
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: double.infinity,
        child: Stack(
            alignment: Alignment.center,
            children: [Image.asset("assets/images/splashScreen.png",
            fit: BoxFit.fitWidth, width: double.infinity),
              Positioned(
                top: 0,
                child: Image.asset("assets/images/flowers2.png", width: MediaQuery
                    .of(context)
                    .size
                    .width
                ),

              ),

              Positioned(
                top: 0,
                child: Image.asset("assets/images/flowers.png", width: MediaQuery
                    .of(context)
                    .size
                    .width
                 ),

              ),
              Image.asset("assets/images/Swami1.png", width: MediaQuery
                  .of(context)
                  .size
                  .width*0.6),
        ]),);
  }
}
