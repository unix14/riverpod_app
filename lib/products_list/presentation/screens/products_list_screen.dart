import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/products_list/domain/entities/products_list_entity.dart';
import '../providers/products_list_provider.dart';
import '../widgets/products_list_widget.dart';

class ProductsListScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsListState = ref.watch(productsListControllerProvider);
    final productsListController = ref.watch(productsListControllerProvider.notifier);
    ProductsListEntity? listEntity = productsListController.productsListEntity;

    return Center(
      // todo add top bar categories
      child: productsListState.when(
          data: (data) => ProductsListWidget(listEntity),
          error: (error, _) => Container(),
          loading: () => CircularProgressIndicator()
      ),
    );
  }
}
