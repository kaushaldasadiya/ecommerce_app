import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_11/Homepage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_11/Cart.dart';
import 'package:http/http.dart' as http;
import 'Product.dart';

class wishlistpage extends StatefulWidget {
  const wishlistpage({super.key});

  @override
  State<wishlistpage> createState() => _wishlistpageState();
}

class _wishlistpageState extends State<wishlistpage> {
  List<dynamic> mydata = [];
  String wishlistid = "";
  @override
  void initState() {
    _wishlistadd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: Text('WishList Page'),
          leading: IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Homepage()));
              },
              icon: Icon(Icons.arrow_back)),
        ),
        body: ListView.builder(
          itemCount: mydata.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                  leading: Image.network(
                    mydata[index]['product_image'],
                    width: 50,
                    height: 100,
                  ),
                  title: Text(mydata[index]["product_name"],
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  // subtitle: Text(
                  //   mydata[index]["product_price"],
                  //   style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  // ),
                  subtitle: Text(
                    'Price : ${mydata[index]['product_price']}',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  trailing: IconButton(
                      onPressed: () {
                        _wishlistremove(mydata[index]['wishlist_id']);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => wishlistpage(),
                            ));
                      },
                      icon: const Icon(Icons.remove_circle_outline_outlined,
                          color: Colors.red))),
            );
          },
        ),
      ),
    );
  }

  _wishlistadd() async {
    SharedPreferences srf = await SharedPreferences.getInstance();
    var a = await srf.getString('user_id');

    var url =
        Uri.parse('https://akashsir.in/myapi/ecom1/api/api-wishlist-view.php');
    var response = await http.post(url, body: {
      'user_id': a,
    });
    print('Response body : ${response.body}');
    print("user id : $a");

    var mymap = json.decode(response.body);

    setState(() {
      mydata = mymap["wishlist"];
    });
  }

  _wishlistremove(wishlistid) async {
    var url = Uri.parse(
        'https://akashsir.in/myapi/ecom1/api/api-wishlist-remove.php');
    var response = await http.post(url, body: {
      'wishlist_id': wishlistid,
    });
    print('Response body: ${response.body}');
    print('wishlist id : $wishlistid');

    Fluttertoast.showToast(
      msg: "Product removed from wishtList",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
