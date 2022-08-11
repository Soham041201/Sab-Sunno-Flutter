import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List users = [];

  Future getUsers() async {
    await http.get(Uri.parse('http://10.0.2.2:8000/users')).then((response) {
      List userList = jsonDecode(response.body)['users'];
      setState(() {
        users = userList;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      body: Center(
        child: StreamBuilder(builder: (context, snapshot) {
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
                      ? Text(users[index]['phoneNumber'])
                      : Text(users[index]['firstName']),
                  onTap: () {
                    print('User $index');
                  },
                );
              });
        }),
      ),
    );
  }
}
