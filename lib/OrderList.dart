import 'package:flutter/material.dart';
import 'package:flutter_application_11/OrderDetails.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class OrderList extends StatefulWidget {
  const OrderList({super.key});

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  List<dynamic> mydata = [];
  var order_id = '';
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
          title: const Text(
            'OrderList',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          )),
      body: ListView.builder(
        itemCount: mydata.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Icon(Icons.shopping_cart_checkout_sharp),
              trailing: const Icon(
                Icons.send,
                color: Colors.black,
              ),
              title: Text('Order No : ${mydata[index]['order_id']}'),
              subtitle: Column(
                children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text('Amount : ${mydata[index]['total_amount']}/-'
                          '\nDate : ${mydata[index]['order_date']}')),
                  Padding(
                    padding: (EdgeInsets.fromLTRB(0, 0, 60, 0)),
                    child: Text(
                      'Order Status : ${mydata[index]['order_status']}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  )
                ],
              ),
              onTap: () {
                print("your Product : ${mydata[index]['order_id']}");
                var st_id = (index + 1).toString();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            OrderDetails(orderid: mydata[index]['order_id'])));
              },

              // onTap: () {
              //   var order_id = data[index]['order_id'];
              //   // Navigator.push(
              //   //     context,
              //   //     MaterialPageRoute(
              //   //       builder: (context) => ViewProduct(st_B: st_A),
              //   //     ));
              // },
            ),
          );
        },
      ),
    );
  }

  _apicall() async {
    try {
      SharedPreferences srf = await SharedPreferences.getInstance();
      var a = await srf.getString('user_id');
      var url =
          Uri.parse('https://akashsir.in/myapi/ecom1/api/api-order-list.php');

      var response = await http.post(url, body: {'user_id': a});
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      print("user_id : $a");

      var map = json.decode(response.body);

      // Map<String, dynamic> mymap = json.decode(response.body);
      // data = mymap['order_list'];
      setState(() {
        mydata = map['order_list'];
      });
    } catch (error) {
      print("Error in Api Calling");
      rethrow;
    }
  }
}
