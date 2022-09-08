import 'package:flutter/cupertino.dart';

class Connection extends ChangeNotifier {
  String otherUserId = '';
  String photoURL = '';
  String name = '';
  String username = '';
  String connectionId = '';

  void setOtherUser(String id, String url, String fname, String uname,String connectId) {
    otherUserId = id;
    photoURL = url;
    name = fname;
    username = uname;
    connectionId = connectId;
    notifyListeners();
  }
}
