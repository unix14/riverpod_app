import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/products_list/domain/entities/products_list_entity.dart';
import '../providers/products_list_provider.dart';
import '../widgets/products_list_widget.dart';

class ProductsListScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsListEntity = ref.watch(productsListControllerProvider);
    ProductsListEntity listEntity = ref.read(productsListControllerProvider.notifier).productsListEntity;
    return Center(
      // todo add top bar categories
      child: productsListEntity.when(
          data: (data) => ProductsListWidget(listEntity),
          error: (error, _) => Container(),
          loading: () => CircularProgressIndicator()
      ),
    );
  }
}
