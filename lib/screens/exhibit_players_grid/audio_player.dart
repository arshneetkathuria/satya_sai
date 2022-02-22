import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:satya_sai/constants/constants.dart';
import 'package:satya_sai/player/audio_player.dart';
import 'package:satya_sai/provider/audio_player_provider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class AudioPlayer extends StatefulWidget {
  const AudioPlayer({Key? key}) : super(key: key);

  @override
  _AudioPlayerState createState() => _AudioPlayerState();
}

class _AudioPlayerState extends State<AudioPlayer> {
  ValueNotifier volumeNotifier = ValueNotifier(1);
  StreamController durationController = StreamController<Duration>();
  late Duration position;
  late Duration totalDuration;
  late String ip;
  late String durationString;
  late final String exhibitAudioUrl;
  bool tapEnable = true;
  late bool isUrlNull;
  late Timer timer1;
  bool isPlaying = false;
  int count = 1;
  final _playerInstance = Player.playerInstance;
  @override
  void dispose() {
    durationController.close();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Container(
        padding: const EdgeInsets.only(top: 10),
        width: 70,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Consumer<AudioPlayerProvider>(builder: (context, obj, _) {
            // return Container();
            return StreamBuilder(
              stream: _playerInstance.player.fixedPlayer!.onDurationChanged,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  totalDuration = snapshot.data as Duration;
                  return StreamBuilder(
                      stream: _playerInstance.player.fixedPlayer!.onAudioPositionChanged,
                      builder: (context, audio) {
                        // isPlaying = snapshot.data ;
                        if (audio.hasData) {
                          position = audio.data as Duration;
                          durationController.sink
                              .add(Duration(seconds: position.inSeconds));
                          return Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: white,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isPlaying = !isPlaying;
                                  });
                                }
                                    ,
                                child: SleekCircularSlider(
                                    appearance: CircularSliderAppearance(
                                        angleRange: 360,
                                        customColors: CustomSliderColors(
                                            dotColor: Colors.transparent,
                                            progressBarColor: pink),
                                        customWidths: CustomSliderWidths(
                                            progressBarWidth: 5)),
                                    min: 0,
                                    max: totalDuration == null
                                        ? 50
                                        : totalDuration.inSeconds.toDouble(),
                                    initialValue: position == null
                                        ? 0
                                        : (position.inSeconds.toDouble()),
                                    innerWidget: (value) {
                                      return (tapEnable)
                                          ? ((isPlaying)
                                          ? const Icon(Icons.pause,
                                          size: 30, color: pink)
                                          : const Icon(Icons.play_arrow_rounded,
                                          size: 30,
                                          color: pink))
                                          : Text("");
                                    }),
                              ),
                            ),
                          );
                        } else {
                          return Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: white,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    // isPlaying = !isPlaying;
                                    // (isPlaying)
                                    //     ? _playerInstance.player.fixedPlayer!.resume()
                                    //     : _playerInstance.player.fixedPlayer!.stop();
                                    _playerInstance.player.fixedPlayer!.stop();
                                  });

                                },
                                child: SleekCircularSlider(
                                    appearance: CircularSliderAppearance(
                                        angleRange: 360,
                                        customColors: CustomSliderColors(
                                            dotColor: Colors.transparent,
                                            progressBarColor: pink),
                                        customWidths:
                                        CustomSliderWidths(progressBarWidth: 5)),
                                    min: 0,
                                    max: 100,
                                    initialValue: 0,
                                    innerWidget: (value) {
                                      return (tapEnable)
                                          ? ((isPlaying)
                                          ? const Icon(Icons.pause,
                                          size: 30, color: pink)
                                          : const Icon(Icons.play_arrow_rounded,
                                          size: 30, color: pink))
                                          : const Text("");
                                    }),
                              ),
                            ),
                          );
                        }
                      });
                } else {
                  return Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: white,
                      ),
                      child: GestureDetector(
                        onTap:() {
                          setState(() {
                            isPlaying = !isPlaying;
                            (isPlaying)
                                ? _playerInstance.player.fixedPlayer!.resume()
                                : _playerInstance.player.fixedPlayer!.stop();
                          });

                        },
                        child: SleekCircularSlider(
                            appearance: CircularSliderAppearance(
                                angleRange: 360,
                                customColors: CustomSliderColors(
                                    dotColor: Colors.transparent,
                                    progressBarColor: pink),
                                customWidths:
                                CustomSliderWidths(progressBarWidth: 5)),
                            min: 0,
                            max: 100,
                            initialValue: 0,
                            innerWidget: (value) {
                              return (tapEnable)
                                  ? ((isPlaying)
                                  ? const Icon(Icons.pause,
                                  size: 30, color: pink)
                                  : const Icon(Icons.play_arrow_rounded,
                                  size: 30, color:pink))
                                  : const Text("");
                            }),
                      ),
                    ),
                  );
                }
              },
            );
          }),
          const SizedBox(height: 1.5),
          StreamBuilder(
              stream: durationController.stream,
              builder: (context, duration) {
                if (duration.hasData) {
                  return (position != null)
                      ? const Center(
                    child: Text('20',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13)),
                  )
                      : Center(
                    child: Text(duration.data.toString(),
                        style: const TextStyle(
                            color: pink,
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                  );
                } else {
                  return const Text("0.0",
                      style: TextStyle(
                          color: pink,
                          fontWeight: FontWeight.bold,
                          fontSize: 16));
                }
              })
        ]),
      );
  }
}
