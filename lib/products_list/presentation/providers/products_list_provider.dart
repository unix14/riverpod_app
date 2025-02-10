import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/products_list/data/models/products_list_model.dart';
import 'package:riverpod_app/products_list/domain/usecases/increase_amount_in_products_list_usecase.dart';

import '../../../core/router/navigation_manager.dart';
import '../../domain/entities/products_list_entity.dart';
import '../../domain/usecases/decrease_amount_for_product_in_products_list_usecase.dart';
import '../../domain/usecases/products_list_usecase.dart';


final productsListControllerProvider = AutoDisposeAsyncNotifierProvider<ProductsListController, ProductsListEntity>(
      () => ProductsListController(),
);

class ProductsListController extends AutoDisposeAsyncNotifier<ProductsListEntity> {

  ProductsListEntity productsListEntity = ProductsListEntity(products: [], title: '');

  @override
  FutureOr<ProductsListEntity> build() async {
    state = AsyncValue.loading();
    try {
      final logoutUseCase = ref.read(productsListUseCaseProvider);
      final productsList = await logoutUseCase.execute();
      productsListEntity = productsList;

      state = AsyncValue.data(productsList);
    } catch (e) {
      state = AsyncValue.error(0, StackTrace.current);
    }
    return productsListEntity;
  }

  Future<void> increaseAmount(ProductsListModel product) async {
    state = AsyncValue.loading();
    try {
      final increaseUseCase = ref.read(increaseAmountForProductInProductsListUseCaseProvider);
      final productsList = await increaseUseCase.execute(product);

      productsListEntity = productsList;

      state = AsyncValue.data(productsList);
    } catch (e) {
      state = AsyncValue.error(0, StackTrace.current);
    }
  }

  Future<void> decreaseAmount(ProductsListModel product) async {
    state = AsyncValue.loading();

    try {
      final decreaseUseCase = ref.read(decreaseAmountForProductInProductsListUseCaseProvider);
      final productsList = await decreaseUseCase.execute(product);

      productsListEntity = productsList;

      state = AsyncValue.data(productsList);
    } catch (e) {
      state = AsyncValue.error(0, StackTrace.current);
    }
  }

  goToProductsScreen() async {
    ref.read(navigationManagerProvider).goToProductsScreen();
  }
}