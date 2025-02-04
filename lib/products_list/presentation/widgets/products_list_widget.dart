import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:riverpod_app/core/mixins/product_list_model_mixin.dart';
import 'package:riverpod_app/products_list/data/models/products_list_model.dart';
import 'package:riverpod_app/products_list/domain/entities/products_list_entity.dart';

class ProductsListWidget extends ConsumerWidget {
  final ProductsListEntity productsListEntity;

  const ProductsListWidget(this.productsListEntity, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: StaggeredGrid.count(
              crossAxisCount: 2, // We have 4 columns in total
              mainAxisSpacing: 0, // Vertical space between items
              crossAxisSpacing: 0, // Horizontal space between items
              children: productsListEntity.products.map((product) {
                return StaggeredGridTile.extent(
                  crossAxisCellCount:
                      product.viewType == ProductViewType.full ? 2 : 1,
                  mainAxisExtent: product.viewType == ProductViewType.full ? 40 : 120,
                  child: product.getProductWidget(ref),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
