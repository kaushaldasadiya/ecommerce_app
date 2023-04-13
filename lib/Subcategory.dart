import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'main.dart';
import 'ViewProduct.dart';

class Subcategory extends StatefulWidget {
  const Subcategory({super.key, required this.st_A});
  final st_A;

  @override
  State<Subcategory> createState() => _SubcategoryState();
}

class _SubcategoryState extends State<Subcategory> {
  @override
  void initState() {
    _apicall();
    super.initState();
  }

  var data = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.cyan,
          title: const Text(
            'Subcategory',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          )),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Image.network(
                data[index]["sub_category_image"],
                width: 80,
              ),
              title: Text(data[index]['sub_category_name'].toString()),
              subtitle: Text(data[index]['category_name'].toString()),
              onTap: () {
                var st_A = data[index]['sub_category_id'];
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewProduct(st_B: st_A),
                    ));
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
          Uri.https('akashsir.in', 'myapi/ecom1/api/api-subcategory-list.php');

      var response = await http.post(url, body: {'category_id': widget.st_A});
      print('Response status: ${response.statusCode}');
      print('Response status: ${response.body}');

      Map<String, dynamic> mymap = json.decode(response.body);
      data = mymap['sub_category_list'];
      setState(() {
        data;
      });
    } catch (error) {
      print("Error in Api Calling");
      rethrow;
    }
  }
}
