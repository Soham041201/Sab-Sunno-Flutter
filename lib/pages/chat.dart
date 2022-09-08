import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sab_sunno/Providers/connection.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../components/chat_message.dart';
import 'dashboard/profile_other.dart';

class ChatList extends StatefulWidget {
  ChatList({Key? key, required Socket this.socket}) : super(key: key);

  final Socket? socket;

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  StreamSocket streamSocket = StreamSocket();

  List<Message> messages = [];
  String reciever = '';
  bool isUserOnline = false;
  final TextEditingController _textController = TextEditingController();

  chatClient(Socket? socket) {
    print("=============Chat client initialized===========");
    String? connectionId =
        Provider.of<Connection>(context(), listen: false).connectionId;
    print("Connection id $connectionId");
    socket?.emit('chat-join',connectionId);

    socket?.on(
        'chat-connected',
        (data) => {
              print('=======Chat connected=========='),
              print(data),
              if (mounted)
                {
                  setState(() {
                    reciever = jsonDecode(data)['connectedUser'];
                  })
                }
            });

    socket?.on(
        'recieve-message',
        (data) => {
              print('Recieve'),
              print(data.toString()),
              streamSocket.addResponse(jsonDecode(data)['message']),
              if (mounted)
                {
                  setState(() {
                    messages.add(Message(
                        message: jsonDecode(data)['message'], isSender: false));
                  })
                }
            });

    socket?.emit('is_online');

    socket?.on(
        'last_seen',
        (data) => {
              print(data),
              if (mounted)
                {
                  setState(() => {isUserOnline = data})
                }
            });
  }

  @override
  void initState() {
    super.initState();
    chatClient(widget.socket);
  }

  @override
  Widget build(BuildContext context) {
    var message = '';
    return Scaffold(
      appBar: AppBar(leading: BackButton(
        onPressed: () {
          widget.socket?.emit('leave-chat');
          setState(() {
            reciever = '';
          });
          Navigator.pop(context);
          widget.socket?.emit('is_online');
        },
      ), title: Consumer<Connection>(
        builder: (context, user, child) {
          return ListTile(
              onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            OtherProfile(context, userId: user.otherUserId)),
                  ),
              leading: CircleAvatar(
                backgroundColor: isUserOnline ? Colors.green : Colors.grey,
                radius: 22,
                child: CircleAvatar(
                  backgroundImage:
                      user.photoURL != '' ? NetworkImage(user.photoURL) : null,
                  backgroundColor: Colors.grey,
                ),
              ),
              title: Text(
                user.name,
                textAlign: TextAlign.left,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
              subtitle: const Text(
                "Online",
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.white, fontSize: 12),
              ));
        },
      )),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(
              'The chat only works on invisible mode',
              style: TextStyle(color: Colors.blue),
            ),
            Expanded(
              child: StreamBuilder(
                stream: streamSocket.getResponse,
                builder: (context, snapshot) {
                  return ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      return ChatMessage(messages: messages, index: index);
                    },
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: 'Type your message here',
                      ),
                      style: const TextStyle(fontSize: 18),
                      onChanged: (value) {
                        message = value;
                      },
                      controller: _textController,
                    ),
                  ),
                  CupertinoButton(
                      minSize: 0,
                      child: const Icon(Icons.send_sharp),
                      onPressed: () {
                        _textController.clear();
                        if (message != '') {
                          setState(() {
                            messages.add(Message(
                                isSender: true, message: message.trim()));
                          });
                          widget.socket?.emit(
                              'is_online',
                              Provider.of<Connection>(context, listen: false)
                                  .otherUserId);
                          widget.socket?.emit(
                              'send-message',
                              jsonEncode(
                                  {"message": message, "reciever": reciever}));
                        }
                      })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StreamSocket {
  final _socketResponse = StreamController<String>();

  void Function(String) get addResponse => _socketResponse.sink.add;

  Stream<String> get getResponse => _socketResponse.stream;

  void dispose() {
    _socketResponse.close();
  }
}

class Message extends Object {
  String message = '';
  bool isSender = true;

  Message({required this.message, required this.isSender});

  getMessage() {
    return message;
  }

  getIsSender() {
    return isSender;
  }
}
