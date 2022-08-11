import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../components/chat_message.dart';

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
  final TextEditingController _textController = TextEditingController();

  chatClient(Socket? socket) {
    print("=============Chat client initialized===========");
    print(socket?.id);
    socket?.emit('chat-join', "========Chat connected=========");
    socket?.on(
        'chat-connected',
        (data) => {
              print('Chat connected'),
              setState(() {
                reciever = jsonDecode(data)['connectedUser'];
              }),
            });

    socket?.on(
        'recieve-message',
        (data) => {
              print('Recieve'),
              print(data.toString()),
              streamSocket.addResponse(jsonDecode(data)['message']),
              setState(() {
                messages.add(Message(
                    message: jsonDecode(data)['message'], isSender: false));
              })
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
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            widget.socket?.emit('leave-chat');
            Navigator.pop(context);
          },
        ),
        title: const Text('Sab Sunno'),
      ),
      body: Column(
        children: [
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
                          messages
                              .add(Message(isSender: true, message: message));
                        });
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
