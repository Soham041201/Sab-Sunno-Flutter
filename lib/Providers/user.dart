import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class User extends ChangeNotifier {
  String id = '';
  String phoneNumber = "";
  String photoURL = "";
  String username = "";
  String about = "";

  void signIn(String phone) async {
    phoneNumber = phone;
    await http
        .post(Uri.parse('http://10.0.2.2:8000/user'),
            headers: {'Content-Type': 'application/json; charset=UTF-8'},
            body: jsonEncode({
              'phoneNumber': phoneNumber,
            }))
        .then((res) => {
              print(jsonDecode(res.body)['user']),
              id = jsonDecode(res.body)['user']['_id'] ?? '',
              username = jsonDecode(res.body)['user']['username'] ?? '',
              photoURL = jsonDecode(res.body)['user']['photoURL'] ?? '',
              about = jsonDecode(res.body)['user']['about'] ?? '',
              notifyListeners()
            });
  }

  void updateImage(String image) async {
    if (!identical(image, photoURL)) {
      photoURL = image;
      var response =
          await http.put(Uri.parse('http://10.0.2.2:8000/user-field/$id'),
              headers: {'Content-Type': 'application/json'},
              body: jsonEncode({
                'field': 'photoURL',
                'value': photoURL,
              }));
    }
    photoURL = image;
    notifyListeners();
  }

  void updateAbout(String aboutBio) async {
    if (about != aboutBio) {
      await http
          .put(Uri.parse('http://10.0.2.2:8000/user-field/$id'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode(<String, String>{
                'field': 'about',
                'value': about,
              }))
          .then((res) => {notifyListeners()});
    }
    notifyListeners();
  }

  void updateUsername(String uUsername) async {
    print("Updating username");
    username = uUsername;
    await http
        .put(Uri.parse('http://10.0.2.2:8000/user-field/$id'),
            headers: {'Content-Type': 'application/json; charset=UTF-8'},
            body: jsonEncode({
              'field': 'username',
              'value': uUsername,
            }))
        .then((res) => {notifyListeners()})
        .catchError((error) => print(error));
  }

  void setUser(String phone, String user, String photo, String bio) {
    phoneNumber = phone;
    username = user;
    photoURL = photo;
    about = bio;
    notifyListeners();
  }

  void updateId(String id) {
    this.id = id;
    notifyListeners();
  }
}
