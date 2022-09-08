import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sab_sunno/Providers/connection.dart';
import 'package:sab_sunno/util/connection_request.dart';
import 'package:sab_sunno/util/register_user.dart';

class OtherProfile extends StatefulWidget {
  const OtherProfile(user, {Key? key, required this.userId}) : super(key: key);

  final String? userId;

  @override
  State<OtherProfile> createState() => _OtherProfileState();
}

class _OtherProfileState extends State<OtherProfile> {
  var user;
  late String status = "notConnected";
  @override
  void initState() {
    super.initState();
    setData(context(), widget.userId);
  }

  void setData(context, userId) async {
    var data = await getUser(context, userId);
    String? statusData = await getConnectionStatus(widget.userId);
    print(statusData);
    if (mounted) {
      setState(() {
        user = data;
        status = statusData!;
        Provider.of<Connection>(context, listen: false).setOtherUser(
            user['_id'],
            user['photoURL'],
            user['firstName'] ?? '',
            user['username']);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: Center(
          child: user != null
              ? Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: user != null && user['photoURL'] != ''
                          ? NetworkImage(user['photoURL'])
                          : null,
                      radius: 80,
                      backgroundColor: Colors.grey,
                    ),
                    Text(user['username'],
                        style: const TextStyle(fontSize: 24)),
                    Text(user['email'] ?? '--',
                        style: const TextStyle(fontSize: 18)),
                    Text(user['phoneNumber'] ?? '--',
                        style:
                            const TextStyle(fontSize: 18, color: Colors.grey)),
                    IconButton(
                      onPressed: () => status == "notConnected"
                          ? sendConnectionRequest(user['_id'])
                          : status == "pending"
                              ? {}
                              : Navigator.pushNamed(context,'/chat'),
                      icon: status == "notConnected"
                          ? const Icon(
                              Icons.add,
                            )
                          : status == "pending"
                              ? const Icon(Icons.pending_sharp)
                              : const Icon(Icons.message),
                      color: Colors.blue,
                    ),
                    Text(status == "notConnected"
                        ? 'Send a connection request'
                        : status == "pending"
                            ? "Connection request pending"
                            : "Send message"),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: ListTile(
                        tileColor: const Color.fromARGB(255, 240, 240, 240),
                        title: const Text('About'),
                        subtitle: Text(user['about'] ?? '--'),
                      ),
                    )
                  ],
                )
              : const CircularProgressIndicator(),
        ),
      ),
    ));
  }
}
