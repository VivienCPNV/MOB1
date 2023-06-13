import 'package:flutter/material.dart';
import 'package:cloudy/screens/home/home.dart';
import 'package:cloudy/screens/search/search.dart';

void main() {
  runApp(const CloudyApp());
}

class CloudyApp extends StatelessWidget {
  const CloudyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, widget) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.grey.shade900,
            body: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 25.0),
              child: widget,
            ),
          ),
        );
      },
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/search': (context) => SearchPage(),
      },
    );
  }
}
