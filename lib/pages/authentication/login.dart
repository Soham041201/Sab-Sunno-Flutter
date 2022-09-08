import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sab_sunno/pages/authentication/mobile_number.dart';
import 'package:sab_sunno/util/register_user.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool isLogin = false;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sab Sunno',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        ),
        body: Container(
          padding: const EdgeInsets.all(32),
          child: Form(
            child: ListView(
              children: <Widget>[
                const Text(
                  "Lets start by entering some basic information",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w800),
                ),
                Row(
                  children: [
                    Text(
                      isLogin
                          ? "Already have a account on Sab Sunno?"
                          : "Dont have a account on Sab Sunno?",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w800),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isLogin = !isLogin;
                        });
                      },
                      child: Text(isLogin ? 'Login' : 'Register'),
                    )
                  ],
                ),
                isLogin
                    ? Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    borderSide:
                                        BorderSide(color: Colors.grey[200]!)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8)),
                                    borderSide:
                                        BorderSide(color: Colors.grey[300]!)),
                                filled: true,
                                fillColor: Colors.grey[100],
                                hintText: "First Name"),
                            controller: _firstNameController,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    borderSide:
                                        BorderSide(color: Colors.grey[200]!)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8)),
                                    borderSide:
                                        BorderSide(color: Colors.grey[300]!)),
                                filled: true,
                                fillColor: Colors.grey[100],
                                hintText: "Last Name"),
                            controller: _lastNameController,
                          ),
                        ],
                      )
                    : const SizedBox(),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.grey[200]!)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Colors.grey[300]!)),
                      filled: true,
                      fillColor: Colors.grey[100],
                      hintText: "Email Address"),
                  controller: _emailController,
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.grey[200]!)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Colors.grey[300]!)),
                      filled: true,
                      fillColor: Colors.grey[100],
                      hintText: "Password"),
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                ),
                const SizedBox(
                  height: 16,
                ),
                CupertinoButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    !isLogin
                        ? await loginUser(
                            _emailController.text.trim(),
                            _passwordController.text.trim(),
                            (value) => {
                                  setState(() => {isLoading = false}),
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MobileNumber()))
                                })
                        : await registerUsers(
                            _firstNameController.text,
                            _lastNameController.text,
                            _emailController.text.trim(),
                            _passwordController.text.trim(),
                            (value) => {
                                  setState(() => {isLoading = false}),
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MobileNumber()))
                                });

                    //code for sign in
                    // final mobile = _phoneController.text.trim();
                    // await registerUser(mobile, context);
                  },
                  color: Colors.orangeAccent,
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  child: !isLoading
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(isLogin ? 'Register' : 'Login'),
                            Icon(Icons.arrow_forward),
                          ],
                        )
                      : const CircularProgressIndicator(color: Colors.orange),
                ),
              ],
            ),
          ),
        ));
  }
}
