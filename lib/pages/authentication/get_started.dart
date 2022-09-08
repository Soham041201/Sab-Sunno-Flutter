import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CupertinoButton(
              color: Colors.orangeAccent,
              borderRadius: const BorderRadius.all(Radius.circular(30)),
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text('Get Started'),
                  Icon(Icons.arrow_forward),
                ],
              )),
        ],
      )),
    ));
  }
}
