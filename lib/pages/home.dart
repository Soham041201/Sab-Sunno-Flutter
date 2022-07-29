import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<String> data;

  @override
  void initState() {
    super.initState();
    data = testData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sab Sunno',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FutureBuilder<String>(
              future: data,
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data!,
                      style: Theme.of(context).textTheme.headline4);
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return const CircularProgressIndicator();
              },
            ),
            CupertinoButton(
                color: Colors.orangeAccent,
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                onPressed: () {
                  Navigator.pushNamed(context, '/chat');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text('Get Started'),
                    Icon(Icons.arrow_forward),
                  ],
                )),
            CupertinoButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: const Text('send sms'))
          ],
        ),
      ),
    );
  }

  Future<String> testData() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8000/'));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
