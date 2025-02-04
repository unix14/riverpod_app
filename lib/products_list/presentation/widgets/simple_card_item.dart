
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/products_list/data/models/products_list_model.dart';
import 'package:riverpod_app/products_list/presentation/providers/products_list_provider.dart';

class SimpleCardItem extends StatefulWidget {

  final ProductsListModel product;
  final WidgetRef ref;

  const SimpleCardItem({super.key, required this.product, required this.ref});

  @override
  State<SimpleCardItem> createState() => _SimpleCardItemState();
}

class _SimpleCardItemState extends State<SimpleCardItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("SimpleCardItem: ${widget.product.name}");

        var controller = widget.ref.read(productsListControllerProvider.notifier);
        controller.goToProductsScreen();
      },
      child: Card(
        child: ListTile(
          title: Text(widget.product.name),
        ),
      ),
    );
  }
}
