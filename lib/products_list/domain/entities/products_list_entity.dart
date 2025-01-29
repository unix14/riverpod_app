import 'package:riverpod_app/products_list/data/models/products_list_model.dart';

class ProductsListEntity {
  final String title;
  final List<ProductsListModel> products;

  ProductsListEntity({required this.title, required this.products});
}
