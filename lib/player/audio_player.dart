import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:satya_sai/player/tcp_client.dart';
import 'package:satya_sai/provider/audio_player_provider.dart';

class Player {
  late AudioCache player;
  static final Player _instance = Player._internal();

  Player._internal() {
    player = AudioCache(fixedPlayer: AudioPlayer(playerId: 'my_player'));
  }

  static Player get playerInstance {
    return _instance;
  }

  playFile(String file, String ip,BuildContext context) {
    TcpClient.timeController.first.then((time) {
      print('time $time');
      player.fixedPlayer!.stop().then((value) => {
            player.play(file).then((value) {
              player.fixedPlayer!.seek(getTime(time));
            })
          });
    });

    player.fixedPlayer!.onPlayerCompletion.first.then((value){
      print('finished');
      Provider.of<AudioPlayerProvider>(context,listen:false).setSelectedIndex(-1);
    });
  }

  Duration getTime(String time) {
    int second;
    int microsecond;

    if (time.contains(".")) {
      second = int.parse(time.split(".")[0]);
      microsecond = int.parse(time.split(".")[1]);
    } else {
      second = int.parse(time);
      microsecond = 0;
    }
    return Duration(seconds: second, microseconds: microsecond);
  }
}
