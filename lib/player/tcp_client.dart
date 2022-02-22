import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';

class TcpClient {
  static late Socket socket;
  static final StreamController<String> _timeController =
      StreamController.broadcast();

  static Stream<String> get timeController => _timeController.stream;

  static getTime(String ip) async {
    socket = await Socket.connect(ip, 2626);
    socket.write('timestamp');
    print('requesting time');
    socket.listen((event) {
      print('listening');
      if(event.isNotEmpty) {
        var time = utf8.decode(event);
        List timeArray = time.split(" ");
        _timeController.sink.add(timeArray[1]);
      }
    },onError:(error){
      print('error');
      socket.write('timestamp');
    });
  }
}
