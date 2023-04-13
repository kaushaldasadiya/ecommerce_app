import 'package:flutter/material.dart';
import 'package:flutter_application_11/Homepage.dart';
import 'package:flutter_application_11/OrderList.dart';
import 'package:flutter_application_11/screen/home_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class OrderDetails extends StatefulWidget {
  String orderid = "";
  OrderDetails({super.key, required this.orderid});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  bool isload = false;
  List<dynamic> myData = [];
  final TextEditingController cancelreason = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _apicall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          title: const Text('Order Details'),
        ),
        body: Form(
          key: _formKey,
          child: isload == true
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: myData.length - 1,
                  itemBuilder: (context, index) {
                    index = index + 1;
                    return Column(
                      children: [
                        Card(
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: ListTile(
                              leading: Image.network(
                                myData[index]['product_image'],
                              ),
                              title: Text(
                                myData[index]['product_name'],
                              ),
                              subtitle: Padding(
                                  padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: Text(
                                    'Price : ${myData[index]['product_price']}'
                                    '\nProduct Qty : ${myData[index]['product_qty']}',
                                  )),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 5.0),
                            child: TextFormField(
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                hintText: 'Cancel Order Reason',
                              ),
                              controller: cancelreason,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'This field is required';
                                }
                              },
                            )),
                        ElevatedButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.cyan),
                          onPressed: () {
                            if ((!_formKey.currentState!.validate())) {
                              return;
                            }

                            removeorder();
                          },
                          child: const Text(
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.white,
                            ),
                            "Cancel Order",
                          ),
                        ),
                      ],
                    );
                  },
                ),
        ));
  }

  _apicall() async {
    setState(() {
      isload = true;
    });
    SharedPreferences srf = await SharedPreferences.getInstance();
    var a = await srf.getString('user_id');

    var url =
        Uri.parse('https://akashsir.in/myapi/ecom1/api/api-order-list.php');
    var response =
        await http.post(url, body: {'user_id': a, 'order_id': widget.orderid});
    var mymap = jsonDecode(response.body);

    setState(() {
      myData = mymap['order_list'][0]['order_details'];
      print('Data : $myData');
      isload = false;
    });
  }

  removeorder() async {
    SharedPreferences srf = await SharedPreferences.getInstance();

    var a = await srf.getString('user_id');

    var url =
        Uri.parse('https://akashsir.in/myapi/ecom1/api/api-order-remove.php');
    var response = await http.post(url, body: {
      'user_id': a,
      'order_id': widget.orderid,
      'cancel_reason': cancelreason.text,
    });
    print('Response status:${response.statusCode}');
    print('Response body: ${response.body}');
    print('cancel_reason :${cancelreason.text}');
    print("user_id : $a");

    Fluttertoast.showToast(msg: 'Your Order Cancel Successfully');

    var mymap = jsonDecode(response.body);

    setState(() {
      if (cancelreason == cancelreason) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Homepage(),
            ));
      } else {
        print('Cancel Order');
      }
    });
  }
}
