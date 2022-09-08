import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketState extends ChangeNotifier {
  Socket? io;
  void setSocket(Socket? socket) {
    io = socket;
    notifyListeners();
  }
}
