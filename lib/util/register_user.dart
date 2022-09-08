import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:sab_sunno/Providers/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future registerPhone(String? phone) async {
  // obtain shared preferences
  final prefs = await SharedPreferences.getInstance();
  final _id = prefs.getString('_id');
  final response = await http.post(
      Uri.parse('https://sab-sunno-backend.herokuapp.com/field/$_id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'field': 'phoneNumber', 'value': phone}));
  if (response.statusCode == 200 || response.statusCode == 400) {
    var data = jsonDecode(response.body);
    return data['user'];
  } else {
    throw Exception('Failed to load data');
  }
}

Future getUser(BuildContext context, [String? id]) async {
  if (id != null) {
    var response = await http
        .get(Uri.parse('https://sab-sunno-backend.herokuapp.com/user/$id'))
        .catchError((error) => print(error));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data['user'];
    }
  }

  final prefs = await SharedPreferences.getInstance();
  final _id = prefs.getString('_id');
  if (_id != null) {
    var response = await http
        .get(Uri.parse('https://sab-sunno-backend.herokuapp.com/user/$_id'))
        .catchError((error) => print(error));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data['user']);
      // ignore: use_build_context_synchronously
      Provider.of<User>(context, listen: false).setUser(
          data['user']['phoneNumber'] ?? '',
          data['user']['username'],
          data['user']['photoURL'],
          data['user']['about']);
    }
  }
}

Future loginUser(String email, String password, Function onSuccess) async {
  print('Login');
  final prefs = await SharedPreferences.getInstance();
  final response = await http.post(
      Uri.parse('https://sab-sunno-backend.herokuapp.com/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'email': email, 'password': password}));
  if (response.statusCode == 200) {
    var _id = jsonDecode(response.body)['user']['_id'];
    await prefs.clear();
    await prefs.remove('_id');
    await prefs.setString('_id', _id.toString());
    onSuccess(jsonDecode(response.body)['user']);
  } else {
    onSuccess(Error);
  }
}

Future registerUsers(String firstName, String lastName, String email,
    String password, Function onSuccess) async {
  print('Register');
  final prefs = await SharedPreferences.getInstance();
  final response = await http.post(
      Uri.parse('https://sab-sunno-backend.herokuapp.com/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
        'firstName': firstName,
        'lastName': lastName,
        'phoneNumber': ''
      }));
  if (response.statusCode == 200) {
    var _id = jsonDecode(response.body)['user']['_id'];
    await prefs.clear();
    await prefs.remove('_id');
    await prefs.setString('_id', _id.toString());
    return onSuccess(jsonDecode(response.body)['user']);
  } else {
    return onSuccess(Error);
  }
}
