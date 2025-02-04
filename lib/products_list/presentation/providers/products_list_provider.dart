import 'dart:async';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/products_list/data/models/products_list_model.dart';
import 'package:riverpod_app/products_list/domain/usecases/increase_amount_in_products_list_usecase.dart';

import '../../../core/router/navigation_manager.dart';
import '../../domain/entities/products_list_entity.dart';
import '../../domain/usecases/decrease_amount_for_product_in_products_list_usecase.dart';
import '../../domain/usecases/products_list_usecase.dart';

enum ProductsListState { initial, loading, loaded, error }


final productsListControllerProvider = AutoDisposeAsyncNotifierProvider<ProductsListController, ProductsListState>(
      () => ProductsListController(),
);

class ProductsListController extends AutoDisposeAsyncNotifier<ProductsListState> {

  late ProductsListEntity productsListEntity;


  @override
  FutureOr<ProductsListState> build() async {
    state = AsyncValue.data(ProductsListState.loading);
    try {
      final logoutUseCase = ref.read(productsListUseCaseProvider);
      final productsList = await logoutUseCase.execute();

      productsListEntity = productsList;

      state = AsyncValue.data(ProductsListState.loaded);
      return ProductsListState.loaded;
    } catch (e) {
      state = AsyncValue.data(ProductsListState.error);
      return ProductsListState.error;
    }
    return ProductsListState.initial;
  }

  Future<void> increaseAmount(ProductsListModel product) async {
    state = AsyncValue.data(ProductsListState.loading);
    try {
      final increaseUseCase = ref.read(increaseAmountForProductInProductsListUseCaseProvider);
      final productsList = await increaseUseCase.execute(product);

      productsListEntity = productsList;

      state = AsyncValue.data(ProductsListState.loaded);
    } catch (e) {
      state = AsyncValue.data(ProductsListState.error);
    }
  }

  Future<void> decreaseAmount(ProductsListModel product) async {
    state = AsyncValue.data(ProductsListState.loading);

    try {
      final decreaseUseCase = ref.read(decreaseAmountForProductInProductsListUseCaseProvider);
      final productsList = await decreaseUseCase.execute(product);

      productsListEntity = productsList;

      state = AsyncValue.data(ProductsListState.loaded);
    } catch (e) {
      state = AsyncValue.data(ProductsListState.error);
    }
  }


  goToProductsScreen() async {
    ref.read(navigationManagerProvider).goToProductsScreen();
  }
}