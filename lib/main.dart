import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sab_sunno/pages/chat.dart';
import 'package:sab_sunno/pages/home.dart';
import 'package:sab_sunno/pages/login.dart';
import 'package:sab_sunno/socket/socket.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
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
                socket : socket,
              ),
          '/login': (context) => LoginScreen(),
        });
  }
}
