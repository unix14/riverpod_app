import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/products_list_entity.dart';
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
}