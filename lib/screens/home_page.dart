import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:satya_sai/player/tcp_server.dart';
import 'package:satya_sai/provider/audio_player_provider.dart';
import 'package:satya_sai/screens/language_slection/language_selection.dart';
import 'package:satya_sai/screens/splash_screen.dart';
import 'package:satya_sai/screens/swami_splash_screen.dart';

import 'landing_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AudioPlayerProvider>(
            create: (context) => AudioPlayerProvider())
      ],
      builder: (context, child) => const SwamiSplashScreen()
      // builder: (context, child) => const LandingPage()
    );
  }
}
