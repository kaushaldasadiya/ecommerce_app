import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Homepage.dart';

void main() {
  runApp(const MaterialApp(
    home: Login(),
  ));
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    //_Savedata();
    super.initState();
  }

  var data = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: const Text('Login'),
        ),
        body: Form(
            key: _formKey,
            child: ListView(children: <Widget>[
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Sign in',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(),
                      labelText: 'Username'),
                  controller: namecontroller,
                  validator: ((value) {
                    if (value!.isEmpty) {
                      return 'Name Field is required';
                    }
                  }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(),
                      labelText: 'Password'),
                  controller: passwordcontroller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Password field is required';
                    }
                  },
                ),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 150, vertical: 10),
                  child: AnimatedButton(
                    height: 70,
                    width: 200,
                    text: 'Login',
                    isReverse: true,
                    selectedTextColor: Colors.white,
                    transitionType: TransitionType.RIGHT_TO_LEFT,
                    backgroundColor: Colors.indigo,
                    borderColor: Colors.white,
                    borderRadius: 10,
                    borderWidth: 2,
                    onPress: () {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      print(namecontroller.text);
                      print(passwordcontroller.text);
                      _Savedata();
                    },
                  )),
            ])));
  }

  void _Savedata() async {
    var url = Uri.http('akashsir.in', '/myapi/ecom1/api/api-login.php');
    var response = await http.post(url, body: {
      'user_email': namecontroller.text,
      'user_password': passwordcontroller.text
    });

    var data = json.decode(response.body);
    var value = data['flag'];
    int flag = int.parse(value);

    var u_id = data['user_id'];
    var name = data['user_name'];
    var email = data['user_email'];
    var mobile = data['user_mobile'];
    print('response code : ${response.statusCode}');
    print('response body : ${response.body}');
    print('user id = ${u_id}');

    SharedPreferences srf = await SharedPreferences.getInstance();
    await srf.setString('user_id', u_id);

    setState(() {
      if (flag == 1) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Homepage(),
            ));
      } else {
        print('something went wrong');
      }
    });
  }
}
