import 'package:flutter/material.dart';
import 'package:flutter_application_11/Homepage.dart';
import 'package:flutter_application_11/screen/home_screen.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'Homepage.dart';
import 'main.dart';
import 'screen/Login.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => home_screen(),
                      ));
                },
                icon: Icon(Icons.arrow_back)),
            backgroundColor: Colors.indigo,
            title: const Text('Sign Up'),
          ),
          body: Siggup(),
        ));
  }
}

class Siggup extends StatefulWidget {
  const Siggup({Key? key}) : super(key: key);

  @override
  State<Siggup> createState() => _SiggupState();
}

class _SiggupState extends State<Siggup> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  //TextEditingController gendercontroller = TextEditingController();
  TextEditingController mobilecontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();
  String? gender;

  final _formKey = GlobalKey<FormState>();

  var data = [];
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(children: [
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(10),
          child: const Text(
            'Register Here',
            style: TextStyle(fontSize: 20),
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            decoration: InputDecoration(
                filled: true,
                border: OutlineInputBorder(),
                labelText: 'Username'),
            controller: namecontroller,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Name Field is required';
              }
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            obscureText: true,
            decoration: InputDecoration(
                filled: true,
                border: OutlineInputBorder(),
                labelText: 'Password'),
            controller: passwordcontroller,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Password  field is required';
              }
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            decoration: const InputDecoration(
                filled: true, border: OutlineInputBorder(), labelText: 'Email'),
            controller: emailcontroller,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Email field is required';
              }
            },
          ),
        ),
        Row(
          children: [
            Expanded(
              child: RadioListTile(
                  title: const Text('Male'),
                  value: 'Male',
                  groupValue: gender,
                  onChanged: ((value) {
                    setState(() {
                      gender = value.toString();
                    });
                  })),
            ),
            Expanded(
              child: RadioListTile(
                  title: const Text('Female'),
                  value: 'Female',
                  groupValue: gender,
                  onChanged: ((value) {
                    setState(() {
                      gender = value.toString();
                    });
                  })),
            ),
          ],
        ),
        SizedBox(
          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              decoration: const InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(),
                  labelText: 'Mobile No'),
              controller: mobilecontroller,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Mobile field is required';
                }
              },
            ),
          ),
        ),
        Container(
          child: SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(),
                    labelText: 'Address'),
                controller: addresscontroller,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Address field is required';
                  }
                },
              ),
            ),
          ),
        ),
        // Padding(
        //     padding: EdgeInsets.symmetric(horizontal: 140, vertical: 10),
        //     child: ElevatedButton(
        //       style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
        //       onPressed: () {
        //         if (!_formKey.currentState!.validate()) {
        //           return;
        //         }
        //         _SaveData();
        //         print('Saved');
        //       },
        //       child: const Text(
        //         'Sign Up',
        //         style: TextStyle(fontSize: 20),
        //       ),
        //     ))
        SizedBox(height: 10),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 150, vertical: 10),
            child: AnimatedButton(
              height: 70,
              width: 200,
              text: 'Sign Up',
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
                _SaveData();
              },
              // child: const Text(
              //   'Login',
              //   style: TextStyle(fontSize: 20),
              // ),
            )),
      ]),
    );
    // ElevatedButton(
    //     style: TextButton.styleFrom(backgroundColor: Colors.indigo),
    //     onPressed: () {
    //       Navigator.push(
    //           context,
    //           MaterialPageRoute(
    //             builder: (context) => const Login(),
    //           ));
    //     },
    //     child: const Text(
    //       "Login ",
    //       style: TextStyle(fontSize: 20),
    //     )),
    // Container(
    //   child: TextButton(
    //     onPressed: () {
    //       Navigator.push(
    //           context,
    //           MaterialPageRoute(
    //             builder: (context) => Homepage(),
    //           ));
    //     },
    //     child: const Text('Skip login',
    //         style: TextStyle(fontWeight: FontWeight.bold)),
    //   ),
    // ),
  }

  Future _SaveData() async {
    String name = namecontroller.text;
    String email = emailcontroller.text;
    String password = passwordcontroller.text;
    //String gender = gendercontroller.text;
    String mobile = mobilecontroller.text;
    String address = addresscontroller.text;

    var url = Uri.http('akashsir.in', '/myapi/ecom1/api/api-signup.php');
    var response = await http.post(url, body: {
      'user_name': '$name',
      'user_email': '$email',
      'user_password': '$password',
      'user_gender': "$gender",
      'user_mobile': '$mobile',
      'user_address': '$address',
    });
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    var data = json.decode(response.body);

    var value = data['flag'];
    var value1 = data['user_id'];
    int flag = int.parse(value);

    print('flag = ${flag}');
    print('user_id = ${value1}');

    setState(() {
      if (flag == 1) {
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Login(),
          ),
        );
      } else {
        print('something went wrong');
      }
    });
  }
}
