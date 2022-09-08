import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../util/login_otp.dart';

class MobileNumber extends StatefulWidget {
  const MobileNumber({Key? key}) : super(key: key);

  @override
  State<MobileNumber> createState() => _MobileNumberState();
}

class _MobileNumberState extends State<MobileNumber> {
  final _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      body: Container(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text(
              "Lets verify our phone number for communication",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w800),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.grey[200]!)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: Colors.grey[300]!)),
                  filled: true,
                  fillColor: Colors.grey[100],
                  hintText: "Phone Number"),
              controller: _phoneController,
              keyboardType: TextInputType.phone,
            ),
            SizedBox(
              height: 10,
            ),
            CupertinoButton(
              onPressed: () async {
                //code for sign in
                final mobile = _phoneController.text.trim();
                await registerUser(mobile, context);
              },
              color: Colors.orangeAccent,
              borderRadius: const BorderRadius.all(Radius.circular(30)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Login'),
                  Icon(Icons.arrow_forward),
                ],
              ),
            ),
          ]),
        ),
      ),
    ));
  }
}
