import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:satya_sai/constants/constants.dart';
import 'package:satya_sai/generated/l10n.dart';
import 'package:satya_sai/model_class/exhibit_model.dart';
import 'package:satya_sai/player/audio_player.dart';
import 'package:satya_sai/player/ripple_effect_animation.dart';
import 'package:satya_sai/player/tcp_client.dart';
import 'package:satya_sai/provider/audio_player_provider.dart';
import 'package:satya_sai/provider/language_selection_provider.dart';
import 'package:satya_sai/provider/selected_exhibit_provider.dart';
import 'package:satya_sai/services/get_content.dart';

class ExhibitPlayerGrid extends StatefulWidget {
  const ExhibitPlayerGrid({Key? key}) : super(key: key);

  @override
  _ExhibitPlayerGridState createState() => _ExhibitPlayerGridState();
}

class _ExhibitPlayerGridState extends State<ExhibitPlayerGrid> {
  int currentIndex = 0;
  final Player _playerInstance = Player.playerInstance;
  GetContent _getContent = GetContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Image.asset("assets/images/splashScreen.png",
          fit: BoxFit.fitWidth, width: double.infinity),
      Column(children: [
        Align(
          alignment: Alignment.center,
          child: Image.asset(
            'assets/headphone.png',
            color: pink,
            height: 80,
          ),
        ),
         Align(
          alignment: Alignment.center,
          child: Text(
            S.of(context).clickAudio,
            style: const TextStyle(
                fontSize: 16, color: pink, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 20),
        Consumer<AudioPlayerProvider>(
            builder: (context, obj, _) =>  Consumer<LanguageSelectionProvider>(
              builder:(context,language,_)=> FutureBuilder(
                  future: _getContent.getAudioList(language.locale),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Zone> exhibitList = snapshot.data as List<Zone>;
                      return Expanded(
                          child: GridView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: exhibitList.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 15,
                                      mainAxisSpacing: 15),
                              itemBuilder: (context, index) {
                                currentIndex = index + 1;
                                return InkWell(
                                    borderRadius: BorderRadius.circular(60),
                                    onTap: () async {
                                      TcpClient.getTime(exhibitList[index].ip);
                                      _playerInstance.playFile(
                                          exhibitList[index].audio,
                                          exhibitList[index].ip,
                                          context);
                                      setState(() {
                                        obj.setSelectedIndex(index);
                                      });
                                      Provider.of<SelectedExhibitProvider>(
                                              context,
                                              listen: false)
                                          .setCurrentExhibit(exhibitList[index]);
                                    },
                                    child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          if (obj.selectedIndex == index)
                                            const RippleEffectAnimation()
                                          else if (obj.selectedIndex == -1)
                                            Container()
                                          else
                                            Container(),
                                          Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(65)),
                                            elevation: 5,
                                            child: Container(
                                                alignment: Alignment.center,
                                                width: 80,
                                                height: 80,
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Text(
                                                  (isDoubleDigit(currentIndex)
                                                          ? ' '
                                                          : '0') +
                                                      (currentIndex).toString(),
                                                  style: const TextStyle(
                                                      color: pink,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 25),
                                                )),
                                          ),
                                        ]));
                              }));
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }),
            )),
      ]),
    ]));
  }

  bool isDoubleDigit(int num) {
    if (num / 10 < 1) {
      return false;
    } else {
      return true;
    }
  }
}
