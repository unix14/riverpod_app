
import 'package:flutter/material.dart';
import 'package:riverpod_app/products_list/data/models/products_list_model.dart';

class SimpleCardItem extends StatefulWidget {

  final ProductsListModel product;

  const SimpleCardItem({super.key, required this.product});

  @override
  State<SimpleCardItem> createState() => _SimpleCardItemState();
}

class _SimpleCardItemState extends State<SimpleCardItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(widget.product.name),
      ),
    );
  }
}
