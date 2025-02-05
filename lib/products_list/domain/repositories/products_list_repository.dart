import 'package:riverpod_app/products_list/data/datasource/products_list_data_source.dart';
import 'package:riverpod_app/products_list/data/models/products_list_model.dart';

import '../entities/products_list_entity.dart';

abstract class ProductsListRepository {


  final ProductsListDataSource productsListDataSource;

  ProductsListRepository({required this.productsListDataSource});

  Future<ProductsListEntity> getProductsList();

  Future<ProductsListEntity> increaseAmountForProductInProductsList(ProductsListModel product);

  Future<ProductsListEntity> decreaseAmountForProductInProductsList(ProductsListModel product);
}