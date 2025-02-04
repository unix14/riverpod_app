enum ProductViewType { half, full }

enum ProductListType {
    TitleItem,
    SimpleItem,
    SpecialItem,
    SimpleAdItem,
    BannerAdItem,
    PromotionItem,
    CollapsableItem,
    CollapsableAdItem,
    HorizontalListItem,
}

class ProductsListModel {
  final int id;
  final String name;
  final ProductViewType viewType;
  final ProductListType listType;

  int amount = 0;

  ProductsListModel({
    required this.id,
    required this.name,
    required this.viewType,
    required this.listType,
    this.amount = 0,
  });

  factory ProductsListModel.fromJson(Map<String, dynamic> json) {
    return ProductsListModel(
      id: json['id'],
      name: json['name'],
      viewType: json['viewType'],
      listType: json['listType'],
      amount: json['amount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'viewType': viewType,
      'listType': listType,
      'amount': amount,
    };
  }
}