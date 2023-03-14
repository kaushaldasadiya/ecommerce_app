import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_11/Signup.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class changepassword extends StatefulWidget {
  changepassword({super.key});

  @override
  State<changepassword> createState() => _changepasswordState();
}

class _changepasswordState extends State<changepassword> {
  TextEditingController oldpassword = new TextEditingController();
  TextEditingController newpassword = new TextEditingController();
  TextEditingController conpassword = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: const Text('Change Password'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: oldpassword,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: const InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(),
                        labelText: "Old pasword ",
                        prefixIcon: Icon(Icons.lock)),
                  ),
                ),
                // const SizedBox(
                //   height: 25,
                // ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: newpassword,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: const InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(),
                        labelText: "New pasword ",
                        prefixIcon: Icon(Icons.lock)),
                  ),
                ),
                // const SizedBox(
                //   height: 25,
                // ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: conpassword,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: const InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(),
                      labelText: "Confirm Password",
                      prefixIcon: Icon(Icons.lock),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                    style: TextButton.styleFrom(backgroundColor: Colors.indigo),
                    onPressed: () {
                      _changepassword();
                    },
                    child: Text(
                      "Change Password",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ))
              ],
            ),
          ),
        ));
  }

  void _changepassword() async {
    String counter = "";
    var prefs = await SharedPreferences.getInstance();
    var a = await prefs.getString('user_id').toString();

    var uri = Uri.parse(
        'https://akashsir.in/myapi/ecom1/api/api-change-password.php');
    var requestBody = {
      'user_id': a,
      'opass': oldpassword.text,
      'npass': newpassword.text,
      'cpass': conpassword.text,
    };

    if (newpassword.text == conpassword.text) {
      var response = await http.post(uri, body: requestBody);
      var map = json.decode(response.body);

      print('Password Change Successfully');
      print('Response Status : ${response.statusCode}');
      print('Response body : ${response.body}');
      Fluttertoast.showToast(msg: 'Change Password Successfully');

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => changepassword()));
    }
  }
}
