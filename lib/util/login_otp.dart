import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:sab_sunno/util/register_user.dart';

Future registerUser(String mobile, BuildContext context) async {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  await _auth.verifyPhoneNumber(
    phoneNumber: mobile,
    timeout: const Duration(seconds: 60),
    verificationCompleted: (AuthCredential authCredential) {
      _auth.signInWithCredential(authCredential).then((result) {
        if (kDebugMode) {
          print(result.user);
        }
      }).catchError((e) {
        if (kDebugMode) {
          print(e);
        }
      });
    },
    verificationFailed: (FirebaseAuthException e) {
      if (kDebugMode) {
        print(e);
      }
    },
    codeSent: (String verificationId, int? forceResendingToken) {
      //show dialog to take input from the user
      OtpFieldController otpController = OtpFieldController();
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
                title: const Text("Enter your otp"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        OTPTextField(
                            controller: otpController,
                            length: 6,
                            width: double.infinity,
                            textFieldAlignment: MainAxisAlignment.center,
                            fieldWidth: 35,
                            spaceBetween: 4,
                            fieldStyle: FieldStyle.underline,
                            outlineBorderRadius: 15,
                            style: const TextStyle(fontSize: 17),
                            onChanged: (pin) {
                              print("Changed: " + pin);
                            },
                            onCompleted: (pin) {
                              FirebaseAuth auth = FirebaseAuth.instance;

                              AuthCredential credential =
                                  PhoneAuthProvider.credential(
                                      verificationId: verificationId,
                                      smsCode: pin);
                              auth
                                  .signInWithCredential(credential)
                                  .then((result) async {
                                await registerPhone(result.user?.phoneNumber)
                                    .then((value) => {
                                          print(value),
                                          value['photoURL'] != null &&
                                                  value['username'] != null &&
                                                  value['about'] != null
                                              ? Navigator.popAndPushNamed(
                                                  context, '/users')
                                              : Navigator.pushNamed(
                                                  context, '/username-image')
                                        });
                              });
                            })
                      ],
                    ),
                  ],
                ),
              ));
    },
    codeAutoRetrievalTimeout: (String verificationId) {
      verificationId = verificationId;
      if (kDebugMode) {
        print(verificationId);
        print("Timout");
      }
    },
  );
}
