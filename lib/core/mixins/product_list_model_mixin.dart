
import 'package:flutter/material.dart';
import 'package:riverpod_app/products_list/data/models/products_list_model.dart';
import 'package:riverpod_app/products_list/presentation/widgets/simple_card_item.dart';
import 'package:riverpod_app/products_list/presentation/widgets/special_card_item.dart';
import 'package:riverpod_app/products_list/presentation/widgets/title_card_item.dart';

extension ProductListModelMixin on ProductsListModel {

  int getProductHeightExtent() {
    // return viewType == ProductViewType.full ? 40 : 120;
    switch (viewType) {
      case ProductViewType.full:
        return 40;
      case ProductViewType.half:
        return 120;
    }
  }

  Widget getProductWidget() {
    switch (listType) {
      case ProductListType.TitleItem:
        return TitleCardItem(product: this);
      case ProductListType.SimpleItem:
        return SimpleCardItem(product: this);
      case ProductListType.SpecialItem:
        return SpecialCardItem(product: this);
      case ProductListType.SimpleAdItem:
      // TODO: Handle this case.
        throw UnimplementedError();
      case ProductListType.BannerAdItem:
      // TODO: Handle this case.
        throw UnimplementedError();
      case ProductListType.PromotionItem:
      // TODO: Handle this case.
        throw UnimplementedError();
      case ProductListType.CollapsableItem:
      // TODO: Handle this case.
        throw UnimplementedError();
      case ProductListType.CollapsableAdItem:
      // TODO: Handle this case.
        throw UnimplementedError();
      case ProductListType.HorizontalListItem:
      // TODO: Handle this case.
        throw UnimplementedError();
    }
  }

}