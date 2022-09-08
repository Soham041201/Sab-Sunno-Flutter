import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sab_sunno/Providers/connection.dart';
import 'package:sab_sunno/Providers/socket.dart';
import 'package:sab_sunno/pages/chat.dart';
import 'package:sab_sunno/pages/authentication/get_started.dart';
import 'package:sab_sunno/pages/home.dart';
import 'package:sab_sunno/pages/authentication/login.dart';
import 'package:sab_sunno/pages/dashboard/profile_self.dart';
import 'package:sab_sunno/pages/authentication/username_profile.dart';
import 'package:sab_sunno/pages/notifications.dart';
import 'package:sab_sunno/pages/users.dart';
import 'package:sab_sunno/socket/socket.dart';
import 'package:sab_sunno/util/register_user.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'Providers/user.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => User(), lazy: false),
      ChangeNotifierProvider(create: (context) => Connection(), lazy: false),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Socket socket = socketInit();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initChat(socket);
    getUser(context());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.deepOrange,
            textTheme: GoogleFonts.ralewayTextTheme(
              Theme.of(context).textTheme,
            )),
        initialRoute: '/',
        routes: {
          '/': (context) => const HomePage(),
          '/chat': (context) => ChatList(
                socket: socket,
              ),
          '/login': (context) => LoginScreen(),
          '/users': (context) => const UserList(),
          '/profile': (context) => const ProfilePage(),
          '/get-started': (context) => const GetStarted(),
          '/username-image': (context) => const UsernameProfile(),
          '/notification': (context) => const Notifications()
        });
  }
}
