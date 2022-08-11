import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sab_sunno/util/login_otp.dart';
import 'package:sab_sunno/util/register_user.dart';

import '../Providers/user.dart';

class LoginScreen extends StatelessWidget {
  final _phoneController = TextEditingController();

  LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.all(32),
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Login",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 36,
                  fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 32),
            TextFormField(
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
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
            const SizedBox(
              height: 16,
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
                children: const [
                  Text('Get Started'),
                  Icon(Icons.arrow_forward),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
