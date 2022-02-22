import 'dart:convert';
import 'dart:io';

class TcpServer {
  TcpServer() {
    // static replyToClient() {
    ServerSocket.bind('127.0.0.1',2626, shared: true).then((serverSocket) {
      serverSocket.listen((socket) {
        socket.listen((s) {
          switch (utf8.decode(s)) {
            case 'timestamp':
              socket.write("0 23.2025 run");
              break;
            case 'authenticate 1 \r getStatus \r':
              socket.write("Ready 6.5 Watchout Windows true Reply Show 4 false false true 12346 123456 12346 12346");
              break;
          }
        });
      });
    });
    // }
  }
}
