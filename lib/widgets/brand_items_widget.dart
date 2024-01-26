import 'package:flutter/material.dart';
import 'dart:convert';
import "package:http/http.dart" as http;

class BrandItemWidget extends StatefulWidget {
  const BrandItemWidget({super.key, required this.brand});
  final String brand;

  @override
  State<BrandItemWidget> createState() => _BrandItemWidgetState();
}

class _BrandItemWidgetState extends State<BrandItemWidget> {
  List<dynamic> brandData = [];
  List<dynamic> data = [];

  var dropdownMenuEntries = [];
  String dropdownvalue = '';
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchProductType() async {
    print(dropdownvalue);
    if (dropdownvalue.isNotEmpty) {
      final response = await http.get(Uri.parse(
          'https://makeup-api.herokuapp.com/api/v1/products.json?product_type=$dropdownvalue&brand=${widget.brand}'));
      if (response.statusCode == 200) {
        data = json.decode(response.body);
      }
    }
  }

  Future<void> fetchData() async {
    if (widget.brand.isNotEmpty) {
      final response = await http.get(Uri.parse(
          'https://makeup-api.herokuapp.com/api/v1/products.json?brand=${widget.brand}'));
      if (response.statusCode == 200) {
        brandData = json.decode(response.body);

        setState(() {
          dropdownMenuEntries = brandData
              .map((product) => product['product_type'])
              .toSet()
              .toList();
          print('we are entered brand page');
          print(dropdownMenuEntries);
        });
      } else {
        throw Exception('Failed to load data');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          leadingWidth: MediaQuery.of(context).size.width * 0.40,
          leading: DropdownButton<String>(
            value: dropdownMenuEntries[0]!,
            onChanged: (newValue) {
              setState(() {
                dropdownvalue = newValue!;
              });
            },
            items: dropdownMenuEntries.map((item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
            focusColor: Colors.white,
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    fetchProductType();
                    setState(() {
                      productsView();
                    });
                  },
                  child: const Text('Submit'),
                ),
              ],
            )
          ]),
      body: productsView(),
    );
  }

  GridView productsView() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      itemCount: data.length,
      itemBuilder: (context, index) {
        return GridTile(
          child: Card(
            child: InkWell(
              onTap: () {},
              child: Column(children: [
                ClipRRect(
                  child: Image.network(
                    data[index]['image_link'],
                    errorBuilder: ((context, error, stackTrace) {
                      return Image.asset('assets/noimage.png');
                    }),
                    width: MediaQuery.of(context).size.width * 0.40,
                    height: MediaQuery.of(context).size.height * 0.19,
                    fit: BoxFit.fill,
                  ),
                ),
                Text(data[index]['name']),
                Text('Price \$${data[index]['price']}'),
              ]),
            ),
          ),
        );
      },
    );
  }
}
