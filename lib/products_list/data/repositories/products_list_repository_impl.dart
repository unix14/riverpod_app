import 'package:riverpod_app/products_list/data/datasource/products_list_data_source.dart';

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
}