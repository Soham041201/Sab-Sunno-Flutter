import 'package:flutter/cupertino.dart';

class Connection extends ChangeNotifier {
  String otherUserId = '';
  String photoURL = '';
  String name = '';
  String username = '';

  void setOtherUser(String id, String url, String fname, String uname) {
    otherUserId = id;
    photoURL = url;
    name = fname;
    username = uname;
    notifyListeners();
  }
}
