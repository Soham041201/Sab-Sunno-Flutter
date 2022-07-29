import 'dart:convert';

import 'package:http/http.dart' as http;

Future<String?> register(String? phone) async {
  final response = await http.post(Uri.parse('http://10.0.2.2:8000/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'phoneNumber': phone}));
  if (response.statusCode == 200) {
    print(response.body);
    return response.body;
  } else {
    throw Exception('Failed to load data');
  }
}
