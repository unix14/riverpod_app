
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/products_list/data/datasource/products_list_data_source.dart';
import 'package:riverpod_app/products_list/data/repositories/products_list_repository_impl.dart';
import 'package:riverpod_app/products_list/domain/repositories/products_list_repository.dart';

//***** products list provider *****//

final productsDataSourceProvider = Provider<ProductsListDataSource>((ref) {
  return ProductsListDataSource();
});

final productsListRepositoryProvider = Provider<ProductsListRepository>((ref) {
  ProductsListDataSource prodDataSource = ref.read(productsDataSourceProvider);
  return ProductsListRepositoryImpl(prodDataSource);
});
