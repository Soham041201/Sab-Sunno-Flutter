import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<String?> sendConnectionRequest(String otherUserId) async {
  final prefs = await SharedPreferences.getInstance();
  final _id = prefs.getString('_id');

  final response = await http.post(
      Uri.parse('https://sab-sunno-backend.herokuapp.com/user/connection'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'userId': _id, 'otherUserId': otherUserId}));
  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    print(data);
    return data['user'];
  } else {
    print(response.body);
    throw Exception('Failed to load data');
  }
}

getConnectionStatus(String? otherUserId) async {
  final prefs = await SharedPreferences.getInstance();
  final _id = prefs.getString('_id');
  print("User id" + _id!);
  print("Other id" + otherUserId!);
  final response = await http.post(
      Uri.parse('https://sab-sunno-backend.herokuapp.com/connection/status'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'userId': _id, 'otherUserId': otherUserId}));
  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    print(data);
    return data['connection'];
  } else {
    return "notConnected";
  }
}

Future updateStatus(String userId, String status) async {
  final prefs = await SharedPreferences.getInstance();
  final _id = prefs.getString('_id');
  print("User id" + _id!);
  final response = await http.put(
      Uri.parse('https://sab-sunno-backend.herokuapp.com/connection/status'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body:
          jsonEncode({'userId': userId, 'otherUserId': _id, 'status': status}));
  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    print(data);
    return data['data']['status'];
  } else {
    return "notConnected";
  }
}
