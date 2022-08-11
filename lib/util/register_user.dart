import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:sab_sunno/Providers/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String?> register(String? phone) async {
  // obtain shared preferences
  final prefs = await SharedPreferences.getInstance();

  final response = await http.post(Uri.parse('http://10.0.2.2:8000/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'phoneNumber': phone}));
  if (response.statusCode == 200 || response.statusCode == 400) {
    var _id = jsonDecode(response.body)['user']['_id'];
    await prefs.clear();
    await prefs.remove('_id');
    await prefs.setString('_id', _id.toString());
    return _id.toString();
  } else {
    throw Exception('Failed to load data');
  }
}

Future getUser(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  final _id = prefs.getString('_id');
  print(_id.toString());
  if (_id != null) {
    var response = await http
        .get(Uri.parse('http://10.0.2.2:8000/user/$_id'))
        .catchError((error) => print(error));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data['user']);
      // ignore: use_build_context_synchronously
      Provider.of<User>(context, listen: false).setUser(
          data['user']['phoneNumber'],
          data['user']['username'],
          data['user']['photoURL'],
          data['user']['about']);
    }
    // user.updateAbout(jsonDecode(response.body)['user']['about']);
    // user.updateUsername(jsonDecode(response.body)['user']['username']);
  }
}
