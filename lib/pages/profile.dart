import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sab_sunno/Providers/user.dart';
import 'package:sab_sunno/util/upload_image.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ImagePicker _picker = ImagePicker();
  String username = "";
  String about = "";

  @override
  Widget build(BuildContext context) {
    return Consumer<User>(builder: (context, user, child) {
      print(user.about);
      return Scaffold(
          appBar: AppBar(
            title: const Text('Profile'),
          ),
          body: Center(
            child: Column(
              children: [
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
                ListTile(
                  leading: const Icon(Icons.phone),
                  title: const Text('Phone Number',
                      style: TextStyle(fontSize: 12)),
                  subtitle: Text(user.phoneNumber,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20)),
                ),
                ListTile(
                  title: Text('Id'),
                  subtitle: Text(user.id),
                ),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Name', style: TextStyle(fontSize: 16)),
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
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom,
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      children: <Widget>[
                                        const Text('Edit your name',
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
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom,
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      children: <Widget>[
                                        const Text('Edit your name',
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
              ],
            ),
          ));
    });
  }
}
