import 'dart:math';

import 'package:riverpod_app/products_list/data/datasource/products_list_data_source.dart';
import 'package:riverpod_app/products_list/data/models/products_list_model.dart';

import '../../domain/entities/products_list_entity.dart';
import '../../domain/repositories/products_list_repository.dart';

class ProductsListRepositoryImpl implements ProductsListRepository {
  final ProductsListDataSource productsListDataSource;

  ProductsListRepositoryImpl(this.productsListDataSource);

  @override
  Future<ProductsListEntity> getProductsList() async {
    print("getProductsList");
    return productsListDataSource.fetchData().then((value) {
      return ProductsListEntity(title: "כל המוצרים", products: value);
    });
  }

  @override
  Future<ProductsListEntity> increaseAmountForProductInProductsList(
      ProductsListModel product) {
    return productsListDataSource.allProductsList.then((value) {
      for (int i = 0; i < value.length; i++) {
        if (value[i].id == product.id) {
          var newProduct = ProductsListModel(
            id: product.id,
            name: product.name,
            viewType: product.viewType,
            listType: product.listType,
            amount: product.amount + 1,
          );
          value[i] = newProduct;
        }
      }
      return ProductsListEntity(title: "כל המוצרים", products: value);
    });
  }

  @override
  Future<ProductsListEntity> decreaseAmountForProductInProductsList(
      ProductsListModel product) {
    return productsListDataSource.allProductsList.then((value) {
      for (int i = 0; i < value.length; i++) {
        if (value[i].id == product.id) {
          var newProduct = ProductsListModel(
            id: product.id,
            name: product.name,
            viewType: product.viewType,
            listType: product.listType,
            amount: max(0, product.amount - 1),
          );
          value[i] = newProduct;
        }
      }
      return ProductsListEntity(title: "כל המוצרים", products: value);
    });
  }
}