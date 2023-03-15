import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_11/Cart.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'Homepage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'changepassword.dart';
import 'package:toast/toast.dart';

class User extends StatefulWidget {
  const User({super.key});

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  TextEditingController namecontroller = new TextEditingController();
  TextEditingController emailcontroller = new TextEditingController();
  TextEditingController gendercontroller = new TextEditingController();
  TextEditingController mobilecontroller = new TextEditingController();
  TextEditingController addresscontroller = new TextEditingController();
  // String? gender;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: const Text('Profile Page'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: SingleChildScrollView(
                child: Center(
                    child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: const Text(
                    'Profile Update Details',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Icon(Icons.face_outlined, size: 150),
                        )
                        // CircleAvatar(
                        //   radius: 100,
                        //   backgroundColor: Colors.grey,
                        //   backgroundImage: AssetImage("assets/dk.png"),
                        // ),
                        // Positioned(
                        //   bottom: 20.0,
                        //   right: 20.0,
                        //   child: Icon(
                        //     Icons.camera_alt,
                        //     color: Colors.teal,
                        //     size: 30.0,
                        //   ),
                        // )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: namecontroller,
                    decoration: InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(),
                        labelText: 'Name'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: emailcontroller,
                    decoration: const InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(),
                        labelText: 'Email'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: gendercontroller,
                    decoration: const InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(),
                        labelText: 'Gender'),
                  ),
                ),
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: mobilecontroller,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          filled: true,
                          border: OutlineInputBorder(),
                          labelText: 'Mobile No'),
                    ),
                  ),
                ),
                Container(
                  child: SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: addresscontroller,
                        decoration: const InputDecoration(
                            filled: true,
                            border: OutlineInputBorder(),
                            labelText: 'Address'),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.indigo),
                        onPressed: () {
                          updateProfile();
                        },
                        child: const Text("Update Profile",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ))),
                    ElevatedButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.indigo),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => changepassword()));
                        },
                        child: const Text(
                          "Change Password",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ))
                  ],
                ),
              ],
            ))),
          ),
        ));
  }

  void updateProfile() async {
    String a = "";
    var prefs = await SharedPreferences.getInstance();
    var counter = await prefs.getString('user_id');
    print(counter);

    var url =
        Uri.parse("https://akashsir.in/myapi/ecom1/api/api-user-update.php");
    var requestBody = {
      'user_id': counter,
      'user_name': namecontroller.text,
      'user_email': emailcontroller.text,
      'user_gender': gendercontroller.text,
      'user_address': addresscontroller.text,
      'user_mobile': mobilecontroller.text,
    };

    var response = await http.post(url, body: requestBody);

    print('Profile Updated Successfully');
    print('Response Status : ${response.statusCode}');
    print('Response body : ${response.body}');
    Fluttertoast.showToast(msg: 'Profile Updated');

    // ignore: use_build_context_synchronously
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => User(),
        ));
  }
}
