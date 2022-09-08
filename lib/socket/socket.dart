// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sab_sunno/Providers/socket.dart';
import 'package:socket_io_client/socket_io_client.dart';

// https://sab-sunno-backend.herokuapp.com
Socket socketInit() {
  return io('https://sab-sunno-backend.herokuapp.com', <String, dynamic>{
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
  socket?.onDisconnect((data) => {
        // Provider.of<Online>(context, listen: false).setOtherUser(data),
        print('============Disconnected from server========')
      });
}
