import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sab_sunno/util/connection_request.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dashboard/profile_other.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  List notifications = [];

  @override
  Future getNotification() async {
    final prefs = await SharedPreferences.getInstance();
    final _id = prefs.getString('_id');

    print("User id" + _id!);
    final response = await http.post(
        Uri.parse('https://sab-sunno-backend.herokuapp.com/notifications'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'otherUserId': _id}));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['notifications'];
      print(data);
      setState(() {
        notifications = data;
      });
    }
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    getNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: Center(
        child: StreamBuilder(builder: (context, snapshot) {
          return notifications.isNotEmpty
              ? ListView.builder(
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    String firstName =
                        notifications[index]['userId']['firstName'] ?? '';
                    String lastName =
                        notifications[index]['userId']['lastName'] ?? '';
                    String username =
                        notifications[index]['userId']['username'] ?? '';
                    String about =
                        notifications[index]['userId']['about'] ?? '';

                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            notifications[index]['userId']['photoURL'] != null
                                ? NetworkImage(
                                    notifications[index]['userId']['photoURL'])
                                : null,
                      ),
                      title: username != ''
                          ? Text(firstName != ''
                              ? firstName
                              : "$username"
                                  "$lastName")
                          : Text(firstName),
                      subtitle: Text(about),
                      trailing: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () => {
                                      updateStatus(
                                          notifications[index]['userId']['_id'],
                                          "rejected"),
                                    },
                                icon: const Icon(Icons.cancel)),
                            IconButton(
                                onPressed: () => updateStatus(
                                    notifications[index]['userId']['_id'],
                                    "accepted"),
                                icon: Icon(Icons.add))
                          ]),
                      onTap: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OtherProfile(context,
                                  userId: notifications[index]['userId']
                                      ['_id'])),
                        );
                      },
                    );
                  })
              : Text('No new notifications');
        }),
      ),
    );
  }
}
