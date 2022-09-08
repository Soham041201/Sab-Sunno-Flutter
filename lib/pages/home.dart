import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sab_sunno/Providers/user.dart';
import 'package:sab_sunno/pages/authentication/get_started.dart';
import 'package:sab_sunno/pages/users.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<String> data;
  bool user = false;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    // data = testData();
    isUser();
  }

  Future isUser() async {
    final prefs = await SharedPreferences.getInstance();
    final _id = prefs.getString('_id');
    print(_id);
    setState(() {
      user = _id != null;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return !isLoading
        ? user
            ? const UserList()
            : const GetStarted()
        : const CircularProgressIndicator();
  }
}
