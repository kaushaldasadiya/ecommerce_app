import 'package:flutter/material.dart';
import 'package:flutter_application_11/Homepage.dart';
import 'package:flutter_application_11/OrderList.dart';
import 'package:flutter_application_11/Signup.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';
import 'Product.dart';
import 'Cart.dart';

class PlaceOrder extends StatefulWidget {
  const PlaceOrder({super.key});

  @override
  State<PlaceOrder> createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder> {
  TextEditingController text1 = TextEditingController();
  TextEditingController text2 = TextEditingController();
  TextEditingController text3 = TextEditingController();
  TextEditingController text4 = TextEditingController();

  String? gender;
  List<dynamic> mydata = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          title: const Text('Place Order',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        ),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: text1,
                  decoration: const InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(),
                      labelText: 'Enter Your name'),
                ),
              ),
              // const SizedBox(height: 50, width: 50),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: text2,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(),
                      labelText: 'Enter Mobile Number'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: text3,
                  decoration: const InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(),
                      labelText: 'Enter Your Address'),
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  '💳Please Select Payment Method',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Column(
                  children: [
                    RadioListTile(
                        title: const Text("Cash"),
                        value: "Cash",
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value.toString();
                          });
                        }),
                    RadioListTile(
                        title: const Text("Upi"),
                        value: "Upi",
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value.toString();
                          });
                        }),
                    RadioListTile(
                        title: const Text("Debit/Credit Card"),
                        value: "Debit/Credit Card",
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value.toString();
                          });
                        }),
                    RadioListTile(
                        title: const Text("Net Banking"),
                        value: "Net Banking",
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value.toString();
                          });
                        }),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                  child: Container(
                      height: 50,
                      width: 150,
                      child: ElevatedButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.cyan),
                          onPressed: () {
                            _orderplace();
                          },
                          child: const Text(
                            'Order Place',
                            style: TextStyle(fontSize: 17),
                          ))))
            ])));
  }

  _orderplace() async {
    String shipping_name = text1.text;
    String shipping_mobile = text2.text;
    String shipping_address = text3.text;
    String payment_method = text4.text;

    SharedPreferences srf = await SharedPreferences.getInstance();
    var a = await srf.getString('user_id');

    var url = Uri.https('akashsir.in', 'myapi/ecom1/api/api-add-order.php');

    var response = await http.post(url, body: {
      'user_id': a,
      'shipping_name': shipping_name,
      'shipping_mobile': shipping_mobile,
      'shipping_address': shipping_address,
      'payment_method': gender,
    });

    print('shipping_name :  $shipping_name');
    print('shipping_mobile : $shipping_mobile');
    print('shipping_address : $shipping_address');
    print('payment_method : $gender');

    print('Response status:${response.statusCode}');
    print('Response  status: ${response.body}');

    var map = json.decode(response.body);
    var value = map['flag'];

    int flag = int.parse(value);
    print('flag ${flag}');
    print('User id = ${a}');

    // ignore: use_build_context_synchronously
    return showDialog(
      context: context,
      builder: (context) {
        return Container(
          child: AlertDialog(
            title: const Text('"CONGRATULATIONS!!!" Your Order is Placed'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Homepage(),
                        ));
                  },
                  child: const Text('Back To Home'))
            ],
          ),
        );
      },
    );
  }
}
