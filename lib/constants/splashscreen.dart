import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_11/main.dart';
import 'package:flutter_application_11/screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const home_screen(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.indigo,
          body: Center(
              child: Container(
            height: 500,
            width: 500,
            child: Image.network(
                "https://pbs.twimg.com/media/Eu7e3mQVgAImK2o?format=png&name=large"),
          )),
        ));
  }
}
