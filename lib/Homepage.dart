import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_11/OrderList.dart';
import 'package:flutter_application_11/Signup.dart';
import 'package:flutter_application_11/screen/home_screen.dart';
import 'package:http/http.dart' as http;
import 'Subcategory.dart';
import 'Product.dart';
import 'Cart.dart';
import 'screen/Login.dart';
import 'User.dart';
import 'main.dart';

void main() {
  runApp(const Homepage());
}

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Category',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
            ],
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => home_screen(),
                    ));
              },
              icon: Icon(Icons.arrow_back)),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => User()));
                },
                icon: Icon(Icons.account_circle)),
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => OrderList()));
                },
                icon: Icon(Icons.shopping_bag)),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Cart()));
                },
                icon: Icon(Icons.shopping_cart)),
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => home_screen()));
                },
                icon: Icon(Icons.logout_outlined)),
          ],
        ),
        body: mystate(),
      ),
    );
  }
}

class mystate extends StatefulWidget {
  const mystate({super.key});

  @override
  State<mystate> createState() => _mystateState();
}

class _mystateState extends State<mystate> {
  var mydata = [];

  @override
  void initState() {
    _apiCall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
      itemCount: mydata.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading: Image.network(
              mydata[index]['category_image'],
              width: 80,
            ),
            title: Text(mydata[index]["category_name"].toString()),
            onTap: (() {
              var st_id = mydata[index]['category_id'];
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Subcategory(st_A: st_id),
                  ));
            }),
          ),
        );
      },
    ));
  }

  _apiCall() async {
    try {
      var url =
          Uri.https('akashsir.in', 'myapi/ecom1/api/api-view-category.php');
      var response = await http.get(url);
      print('Response status: ${response.statusCode}');
      print('Response status: ${response.body}');

      Map<String, dynamic> mymap = json.decode(response.body);
      mydata = mymap['category_list'];
      setState(() {
        mydata;
      });
    } catch (error) {
      print("Error in Api Calling");
      rethrow;
    }
  }
}
