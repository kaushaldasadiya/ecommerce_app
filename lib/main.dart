import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_11/Cart.dart';
import 'package:flutter_application_11/Homepage.dart';
import 'package:flutter_application_11/screen/Login.dart';
import 'package:flutter_application_11/OrderList.dart';
import 'package:flutter_application_11/Subcategory.dart';
import 'package:flutter_application_11/User.dart';
import 'package:flutter_application_11/constants/splashscreen.dart';
import 'Signup.dart';
import 'Homepage.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.cyan,
    ),
    home: SplashScreen(),
  ));
}
