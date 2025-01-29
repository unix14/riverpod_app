
import 'package:flutter/material.dart';
import 'package:riverpod_app/products_list/data/models/products_list_model.dart';

class SpecialCardItem extends StatefulWidget {

  final ProductsListModel product;

  const SpecialCardItem({super.key, required this.product});

  @override
  State<SpecialCardItem> createState() => _SpecialCardItemState();
}

class _SpecialCardItemState extends State<SpecialCardItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue,
      child: ListTile(
        title: Text(widget.product.name),
      ),
    );
  }
}
