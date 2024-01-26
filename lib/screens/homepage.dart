import 'dart:convert';
import 'package:assignment_1/screens/brand_items.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> data = [];
  List<dynamic> distinct = [];

  var isLoading = true;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(
        Uri.parse('https://makeup-api.herokuapp.com/api/v1/products.json'));

    if (response.statusCode == 200) {
      data = json.decode(response.body);
      setState(() {
        isLoading = false;
        distinct = data.map((product) => product['brand']).toSet().toList();
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    Color getColorForIndex(int index) {
      return Color.fromARGB(255 + index * 40, 92 + index * 30, 144 + index * 40,
          233 + index * 20);
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 89, 171, 238),
          title: const Text('Shop Your Brand'),
        ),
        body: ModalProgressHUD(
          inAsyncCall: isLoading,
          progressIndicator: const CircularProgressIndicator(),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: distinct.length,
            itemBuilder: (context, index) {
              Color itemColor = getColorForIndex(index);
              if (distinct[index] != null) {
                return GridTile(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              BrandItemsList(brand: distinct[index])));
                    },
                    child: Card(
                      color: itemColor,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Center(
                          child: Text(
                            distinct[index].toString().toUpperCase(),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
              return null;
            },
          ),
        ));
  }
}
