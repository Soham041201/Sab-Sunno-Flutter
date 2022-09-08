import 'package:flutter/material.dart';

import '../pages/chat.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage({
    Key? key,
    required this.messages,
    required this.index,
  }) : super(key: key);

  final List<Message> messages;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: messages[index].isSender
          ? Alignment.centerRight
          : Alignment.centerLeft,
      children: [
        Container(
          margin: const EdgeInsets.all(3),
          constraints: const BoxConstraints(minWidth: 80, maxWidth: 250),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(15),
                topRight: const Radius.circular(15),
                bottomRight: messages[index].isSender
                    ? const Radius.circular(0)
                    : const Radius.circular(15),
                bottomLeft: messages[index].isSender
                    ? const Radius.circular(15)
                    : const Radius.circular(0)),
            color: Colors.orange,
          ),
          padding: const EdgeInsets.all(10),
          child: Text(
            messages[index].message,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
