import 'package:flutter/material.dart';
import 'package:flutter_application_11/Homepage.dart';
import 'package:flutter_application_11/screen/Login.dart';
import 'package:flutter_application_11/Signup.dart';

class home_screen extends StatefulWidget {
  const home_screen({super.key});

  @override
  State<home_screen> createState() => _MyAppState();
}

class _MyAppState extends State<home_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Ecommerce Shopping'),
          backgroundColor: Colors.cyan,
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Signup()));
                        },
                        child: Text(
                          'Signup ',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.cyan),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: Text(
                        'Login In',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.cyan),
                    ),
                  ),
                  TextButton(
                    child: Text('Skip Login',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Homepage()));
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Created by Kaushal Dasadiya',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal),
                  ),
                  Container(
                    height: 500,
                    width: 500,
                    child: Image.network(
                        "https://blog.logrocket.com/wp-content/uploads/2022/09/32-free-flutter-templates-great-mobile-apps.png"),
                  )
                ]),
              )
            ],
          ),
        ));
  }
}
