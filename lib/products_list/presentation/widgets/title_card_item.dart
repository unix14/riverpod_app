
import 'package:flutter/material.dart';
import 'package:riverpod_app/products_list/data/models/products_list_model.dart';

class TitleCardItem extends StatefulWidget {

  final ProductsListModel product;

  const TitleCardItem({super.key, required this.product});

  @override
  State<TitleCardItem> createState() => _TitleCardItemState();
}

class _TitleCardItemState extends State<TitleCardItem> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.product.name);
  }
}
