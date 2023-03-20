import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'main.dart';
import 'ViewProduct.dart';
import 'Product.dart';
import 'PlaceOrder.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  List<dynamic> mydata = [];
  String totalprice = "", totalQuantity = "";
  int count = 1;

  var c_id = '';
  @override
  void initState() {
    _apicall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text('Cart',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
      ),
      body: ListView.builder(
          itemCount: mydata.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                  trailing: IconButton(
                    onPressed: () {
                      c_id = mydata[index]["cart_id"];
                      removecart();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Cart(),
                          ));
                    },
                    icon: const Icon(
                      Icons.remove_circle_outline_outlined,
                      color: Colors.red,
                    ),
                  ),
                  leading: Image.network(mydata[index]['product_image'],
                      height: 100, width: 50),
                  subtitle: Text(
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                      'Price  :  ${mydata[index]['product_price']}'
                      "\nProduct_Qty : ${mydata[index]['product_qty']}"),
                  title: Text(
                    'Product name : ${mydata[index]['product_name']}',
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  )),
            );
          }),
      bottomNavigationBar: Visibility(
        child: Container(
          height: 70,
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 5),
                      child: Text(
                        'Quantity :- ',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 5),
                      child: Text(
                        totalQuantity,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(18.0, 0, 0, 5),
                      child: Text(
                        'Total Price :-',
                        style: TextStyle(fontSize: 20),
                        maxLines: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 5),
                      child: Text(
                        "$totalprice/-",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: InkWell(
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.indigo,
                    child: Text(
                      "Place Order",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.white),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PlaceOrder()));
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _apicall() async {
    try {
      SharedPreferences srf = await SharedPreferences.getInstance();
      var a = await srf.getString('user_id');

      var url = Uri.https('akashsir.in', 'myapi/ecom1/api/api-cart-list.php');

      var response = await http.post(url, body: {
        'user_id': a,
        'product_qty': '${count}',
      });
      print('Response status:${response.statusCode}');
      print('Response  status: ${response.body}');

      var map = json.decode(response.body);
      var value = map['flag'];

      setState(() {
        mydata = map['cart_list'];
        totalprice = map['grand_total'];
        totalQuantity = map['total_qty'];
      });
    } catch (error) {
      print("Error in Api Calling");
      rethrow;
    }
  }

  void removecart() async {
    try {
      var url = Uri.parse(
          'https://akashsir.in/myapi/ecom1/api/api-cart-remove-product.php');
      var response = await http.post(url, body: {'cart_id': c_id});
      print('Response status:${response.statusCode}');
      print('Response body : ${response.body}');
      print("cart_id : $c_id");
      Fluttertoast.showToast(
          msg: 'Product Remove from Cart Successfully', textColor: Colors.red);

      var map = jsonDecode(response.body);

      setState(() {
        mydata = map['cart_list'];
      });
    } catch (error) {}
  }
}
