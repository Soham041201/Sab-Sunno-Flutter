import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class User extends ChangeNotifier {
  late String id;
  String phoneNumber = '';
  String photoURL = '';
  String username = '';
  String about = '';

  void signIn(String phone) async {
    phoneNumber = phone;
    await http
        .post(Uri.parse('https://sab-sunno-backend.herokuapp.com/user'),
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
      final prefs = await SharedPreferences.getInstance();
      final _id = prefs.getString('_id');
      var response = await http.post(
          Uri.parse('https://sab-sunno-backend.herokuapp.com/field/$_id'),
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
    about = aboutBio;
    final prefs = await SharedPreferences.getInstance();
    final _id = prefs.getString('_id');
    print("Update about");
    var response = await http
        .post(Uri.parse('https://sab-sunno-backend.herokuapp.com/field/$_id'),
            headers: {'Content-Type': 'application/json; charset=UTF-8'},
            body: jsonEncode(<String, String>{
              'field': 'about',
              'value': aboutBio,
            }))
        .then((res) => {print(res.body), notifyListeners()})
        .onError((error, stackTrace) => {print(error)});
    notifyListeners();
  }

  void updateUsername(String uUsername) async {
    final prefs = await SharedPreferences.getInstance();
    final _id = prefs.getString('_id');
    print("Updating username");
    username = uUsername;
    print("Updated username " + uUsername);
    var respose = await http
        .post(Uri.parse('https://sab-sunno-backend.herokuapp.com/field/$_id'),
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
