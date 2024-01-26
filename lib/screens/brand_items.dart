import 'package:assignment_1/widgets/brand_items_widget.dart';
import 'package:flutter/material.dart';

class BrandItemsList extends StatefulWidget {
  const BrandItemsList({super.key, required this.brand});
  final String brand;

  @override
  State<BrandItemsList> createState() {
    return _BrandItemsListState();
  }
}

class _BrandItemsListState extends State<BrandItemsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.brand.toUpperCase()),
        ),
        body: BrandItemWidget(brand: widget.brand));
  }
}
