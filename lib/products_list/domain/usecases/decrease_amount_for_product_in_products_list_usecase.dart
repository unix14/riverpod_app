import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/core/providers/products_list_provider.dart';
import 'package:riverpod_app/products_list/domain/entities/products_list_entity.dart';

import '../../data/models/products_list_model.dart';
import '../repositories/products_list_repository.dart';

class DecreaseAmountForProductInProductsListUseCase {
  final ProductsListRepository repository;

  DecreaseAmountForProductInProductsListUseCase(this.repository);

  Future<ProductsListEntity> execute(ProductsListModel product) {
    return repository.decreaseAmountForProductInProductsList(product);
  }
}

//todo move to providers
final decreaseAmountForProductInProductsListUseCaseProvider = Provider((ref) {
  final repository = ref.watch(productsListRepositoryProvider);
  return DecreaseAmountForProductInProductsListUseCase(repository);
});
