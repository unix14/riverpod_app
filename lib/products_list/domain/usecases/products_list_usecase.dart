import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/core/providers/products_list_provider.dart';

import '../entities/products_list_entity.dart';
import '../repositories/products_list_repository.dart';

class ProductsListUseCase {
  final ProductsListRepository repository;

  ProductsListUseCase(this.repository);

  Future<ProductsListEntity> execute() {
    return repository.getProductsList();
  }
}

//todo move to providers
final productsListUseCaseProvider = Provider((ref) {
  final repository = ref.watch(productsListRepositoryProvider);
  return ProductsListUseCase(repository);
});
