import 'package:flutter/material.dart';
import 'package:flutter_application_11/User.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';
import 'ViewProduct.dart';
import 'Cart.dart';
import 'wishlistpage.dart';

class Product extends StatefulWidget {
  String prodductid = "";
  Product({super.key, required this.prodductid});

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  List<dynamic> mydata = [];
  bool isload = true;
  int count = 1;

  void _incrementCount() {
    setState(() {
      count = count + 1;
    });
  }

  void _decreseCount() {
    setState(() {
      if (count > 1) {
        count = count - 1;
      } else {
        count = 1;
      }
    });
  }

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
        title: const Text('Product',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Cart()));
              },
              icon: const Icon(Icons.shopping_cart)),
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => wishlistpage()));
              },
              icon: const Icon(Icons.favorite_border))
        ],
      ),
      body: isload == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 10.0,
                  ),
                  Center(
                      child: Text(
                    '${mydata[0]['product_name']}',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  )),
                  SizedBox(height: 10.0),
                  Image.network(
                    mydata[0]['product_image'],
                    height: 400,
                    width: MediaQuery.of(context).size.width,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: IconButton(
                        onPressed: () {
                          addtowishlist();
                        },
                        icon: Icon(Icons.favorite_border, color: Colors.red),
                        iconSize: 40),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(140, 0, 0, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Row(
                                children: [
                                  Text(
                                    'Quantity:-',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      _decreseCount();
                                    },
                                    icon: const Icon(Icons.remove),
                                  ),
                                  Text('$count'),
                                  IconButton(
                                    onPressed: () {
                                      _incrementCount();
                                    },
                                    icon: const Icon(Icons.add),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 5, 240, 0),
                    child: Text(
                      'Product Price : ${mydata[0]['product_price']}',
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                              'Product Category : ${mydata[0]['sub_category_name']}',
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold))),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 5, 180, 0),
                    child: Text(
                        'Product Details:- ${mydata[0]['product_details']}',
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
            style: TextButton.styleFrom(backgroundColor: Colors.cyan),
            onPressed: () {
              addproducttocart();
            },
            child: Text(
              "Add To Cart",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            )),
      ),
    );
  }

  _apicall() async {
    try {
      setState(() {
        isload = true;
      });
      SharedPreferences srf = await SharedPreferences.getInstance();
      var a = await srf.getString('user_id');
      var url = Uri.parse(
          'https://akashsir.in/myapi/ecom1/api/api-view-product.php?product_id=${widget.prodductid}');
      var response = await http.post(url);

      var mymap = json.decode(response.body);

      setState(() {
        mydata = mymap['product_list'];
      });

      print('Response status: ${response.statusCode}');
      print('Response status: ${response.body}');

      setState(() {
        isload = false;
      });
    } catch (error) {
      print("Error in Api Calling");
      rethrow;
    }
  }

  void addproducttocart() async {
    SharedPreferences srf = await SharedPreferences.getInstance();
    var a = await srf.getString('user_id');

    var url =
        Uri.parse('https://akashsir.in/myapi/ecom1/api/api-cart-insert.php');
    var response = await http.post(url, body: {
      'user_id': a,
      'product_id': widget.prodductid,
      'product_qty': '${count}',
    });

    print('Response body : ${response.body}');

    print("USer id : $a");
    print('product id : ${widget.prodductid}');
    Fluttertoast.showToast(msg: 'Item Added to Cart', textColor: Colors.blue);

    // ignore: use_build_context_synchronously
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Cart()));
  }

  void addtowishlist() async {
    SharedPreferences srf = await SharedPreferences.getInstance();
    var a = await srf.getString('user_id');

    var url =
        Uri.parse('https://akashsir.in/myapi/ecom1/api/api-wishlist-add.php');
    var response = await http.post(url, body: {
      'user_id': a,
      'product_id': widget.prodductid,
    });

    print('response body : ${response.body}');
    print("User id : $a");
    print('product id : ${widget.prodductid}');

    Fluttertoast.showToast(
      msg: "Product Added to wishtList",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
