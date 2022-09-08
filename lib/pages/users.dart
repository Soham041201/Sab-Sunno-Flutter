import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sab_sunno/pages/dashboard/profile_other.dart';
import 'package:sab_sunno/util/register_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List users = [];
  bool isLoading = true;

  Future getUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final _id = prefs.getString('_id');
    await http
        .get(Uri.parse('https://sab-sunno-backend.herokuapp.com/users/$_id'))
        .then((response) {
      List userList = jsonDecode(response.body)['users'];
      setState(() {
        users = userList;
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sab Sunno',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
              onPressed: () => Navigator.pushNamed(context, '/notification'),
              icon: const Icon(Icons.notifications)),
          IconButton(
            icon: const Icon(
              Icons.account_circle,
              color: Colors.white,
              size: 36,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
        ],
      ),
      body: Center(
        child: !isLoading
            ? StreamBuilder(builder: (context, snapshot) {
                return ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: users[index]['photoURL'] != null
                              ? NetworkImage(users[index]['photoURL'])
                              : null,
                        ),
                        title: users[index]['phoneNumber'] != null
                            ? Text(users[index]['username'])
                            : Text(users[index]['firstName']),
                        onTap: () async {
                          // var data = await getUser(context, users[index]['_id']);
                          // print(data);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OtherProfile(context,
                                    userId: users[index]['_id'])),
                          );
                        },
                      );
                    });
              })
            : const CircularProgressIndicator(),
      ),
    );
  }
}
