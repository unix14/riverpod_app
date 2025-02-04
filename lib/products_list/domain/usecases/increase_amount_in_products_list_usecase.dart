import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/core/providers/products_list_provider.dart';
import 'package:riverpod_app/products_list/data/models/products_list_model.dart';

import '../entities/products_list_entity.dart';
import '../repositories/products_list_repository.dart';

class IncreaseAmountForProductInProductsListUseCase {
  final ProductsListRepository repository;

  IncreaseAmountForProductInProductsListUseCase(this.repository);

  Future<ProductsListEntity> execute(ProductsListModel product) {
    return repository.increaseAmountForProductInProductsList(product);
  }
}

//todo move to providers
final increaseAmountForProductInProductsListUseCaseProvider = Provider((ref) {
  final repository = ref.watch(productsListRepositoryProvider);
  return IncreaseAmountForProductInProductsListUseCase(repository);
});
