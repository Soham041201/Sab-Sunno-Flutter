// ignore_for_file: avoid_print

import 'package:socket_io_client/socket_io_client.dart';

// https://sab-sunno-backend.herokuapp.com
Socket socketInit() {
  return io('http://10.0.2.2:8000', <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': true,
    'reconnection': true,
    'forceNew': true,
  });
}

initChat(Socket? socket) {
  print('=============Socket client initialized===========');
  socket?.onConnect((data) {
    print('Connected to server');
  });
  socket?.onConnectError((data) {
    print('Connected error' + data);
  });
  socket?.onConnectTimeout((data) {
    print('Connected timeout' + data);
  });
  socket?.onDisconnect(
      (data) => print('============Disconnected from server========'));
}
