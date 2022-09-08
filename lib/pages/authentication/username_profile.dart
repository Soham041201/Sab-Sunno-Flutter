import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../Providers/user.dart';
import '../../util/upload_image.dart';

class UsernameProfile extends StatefulWidget {
  const UsernameProfile({Key? key}) : super(key: key);

  @override
  State<UsernameProfile> createState() => _UsernameProfileState();
}

class _UsernameProfileState extends State<UsernameProfile> {
  final ImagePicker _picker = ImagePicker();
  String username = "";
  String about = "";

  @override
  Widget build(BuildContext context) {
    return Consumer<User>(builder: (context, user, child) {
      return Scaffold(
          appBar: AppBar(
            title: const Text('Profile'),
          ),
          body: Container(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Column(
                children: [
                  const Text(
                    "We are almost there...",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w800),
                    textAlign: TextAlign.left,
                  ),
                  Container(
                    margin: const EdgeInsets.all(16),
                    child: CircleAvatar(
                        backgroundImage: user.photoURL != ''
                            ? NetworkImage(user.photoURL)
                            : null,
                        radius: 80,
                        backgroundColor: Colors.grey,
                        child: IconButton(
                            onPressed: () async {
                              String? image = await uploadFile();
                              user.updateImage(image);
                            },
                            icon: const Icon(
                              Icons.add_a_photo,
                              color: Colors.white,
                              size: 32,
                            ))),
                  ),
                  Text('Choose a profile picture'),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('Enter your username',
                        style: TextStyle(fontSize: 16)),
                    subtitle: Text(user.username),
                    trailing: IconButton(
                        onPressed: () {
                          showModalBottomSheet<void>(
                            context: context,
                            enableDrag: true,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(16),
                              ),
                            ),
                            builder: (BuildContext context) {
                              return SingleChildScrollView(
                                child: Container(
                                  padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom,
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        children: <Widget>[
                                          const Text('Enter your username',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20)),
                                          TextField(
                                            autofocus: true,
                                            onChanged: (value) {
                                              username = value;
                                            },
                                            decoration: const InputDecoration(
                                              hintText: 'Name',
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              TextButton(
                                                onPressed: () {
                                                  user.updateUsername(username);
                                                  Navigator.pop(context);
                                                },
                                                child: Text('Save'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text('Cancel'),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.edit)),
                  ),
                  ListTile(
                    leading: const Icon(Icons.info_outline),
                    title: const Text('About', style: TextStyle(fontSize: 16)),
                    subtitle: Text(user.about),
                    trailing: IconButton(
                        onPressed: () {
                          showModalBottomSheet<void>(
                            context: context,
                            enableDrag: true,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(16),
                              ),
                            ),
                            builder: (BuildContext context) {
                              return SingleChildScrollView(
                                child: Container(
                                  padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom,
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        children: <Widget>[
                                          const Text('Edit your bio',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20)),
                                          TextField(
                                            autofocus: true,
                                            onChanged: (value) {
                                              about = value;
                                            },
                                            decoration: const InputDecoration(
                                              hintText: 'Name',
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              TextButton(
                                                onPressed: () {
                                                  user.updateAbout(about);
                                                  Navigator.pop(context);
                                                },
                                                child: Text('Save'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text('Cancel'),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.edit)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CupertinoButton(
                      color: Colors.orangeAccent,
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      onPressed: () {
                        Navigator.pushNamed(context, '/users');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text("Let's Go"),
                          Icon(Icons.arrow_forward),
                        ],
                      )),
                ],
              ),
            ),
          ));
    });
  }
}
