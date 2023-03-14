import 'package:flutter/material.dart';
import 'package:flutter_application_11/Product.dart';
import 'package:flutter_application_11/wishlistpage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'main.dart';
import 'Subcategory.dart';

class ViewProduct extends StatefulWidget {
  const ViewProduct({super.key, required this.st_B});
  final st_B;

  @override
  State<ViewProduct> createState() => _ViewProductState();
}

class _ViewProductState extends State<ViewProduct> {
  String st_c = "";
  var user_id;
  var product_qty;
  var product_id;
  var product_detail;
  var product_price;

  @override
  void initState() {
    _apicall();
    super.initState();
  }

  var data = [];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => wishlistpage()));
              },
              icon: const Icon(Icons.favorite_border))
        ],
        backgroundColor: Colors.indigo,
        title: const Text(
          'ViewProduct',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Image.network(data[index]["product_image"], width: 80),
              title: Text(data[index]['product_name'].toString()),
              onTap: () {
                print('Product id : ${data[index]['product_id']}');
                st_c = data[index]['product_id'];

                print('$st_c');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Product(
                              prodductid: st_c,
                            )));
              },
            ),
          );
        },
      ),
    );
  }

  _apicall() async {
    try {
      var url =
          Uri.https('akashsir.in', 'myapi/ecom1/api/api-view-product.php');
      var response =
          await http.post(url, body: {'sub_category_id': widget.st_B});
      print('Response status: ${response.statusCode}');
      print('Response status: ${response.body}');

      Map<String, dynamic> mymap = json.decode(response.body);
      data = mymap['product_list'];
      setState(() {
        data;
      });

      print('$st_c');
    } catch (error) {
      print("Error in Api Calling");
      rethrow;
    }
  }
}
