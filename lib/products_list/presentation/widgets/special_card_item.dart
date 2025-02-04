
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/products_list/data/models/products_list_model.dart';
import 'package:riverpod_app/products_list/presentation/providers/products_list_provider.dart';

class  SpecialCardItem extends ConsumerWidget {

  final ProductsListModel product;

  const SpecialCardItem({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    var controller = ref.read(productsListControllerProvider.notifier);//.updateProduct(widget.product);
    return Card(
      color: Colors.blue,
      child: ListTile(
        title: Column(
          children: [
            Text(product.name),
            Container(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(onPressed: () {
                  controller.decreaseAmount(product);
                }, child: Text("-")),

                Text(product.amount.toString()),

                TextButton(onPressed: () {
                  controller.increaseAmount(product);
                }, child: Text("+")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
