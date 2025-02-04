import 'package:riverpod_app/products_list/data/models/products_list_model.dart';

class ProductsListDataSource {
  // Fetch data from remote or local source

  final List<ProductsListModel> _allProductsList = [];

  Future<List<ProductsListModel>> fetchData() async {
    _allProductsList.clear();
    _allProductsList.add(ProductsListModel(id: 1, name: 'Title 1', viewType: ProductViewType.full, listType: ProductListType.TitleItem));
    _allProductsList.add(ProductsListModel(id: 2, name: 'Sample 1', viewType: ProductViewType.half, listType: ProductListType.SimpleItem));
    _allProductsList.add(ProductsListModel(id: 3, name: 'Sample 2', viewType: ProductViewType.half, listType: ProductListType.SimpleItem));
    _allProductsList.add(ProductsListModel(id: 4, name: 'Sample 3', viewType: ProductViewType.half, listType: ProductListType.SpecialItem));
    _allProductsList.add(ProductsListModel(id: 5, name: 'Title 2', viewType: ProductViewType.full, listType: ProductListType.TitleItem));
    _allProductsList.add(ProductsListModel(id: 6, name: 'Sample 1', viewType: ProductViewType.half, listType: ProductListType.SimpleItem));
    _allProductsList.add(ProductsListModel(id: 7, name: 'Sample 2', viewType: ProductViewType.half, listType: ProductListType.SimpleItem));
    _allProductsList.add(ProductsListModel(id: 8, name: 'Sample 3', viewType: ProductViewType.half, listType: ProductListType.SpecialItem));


    return _allProductsList;
  }

  Future<List<ProductsListModel>> get allProductsList async {
    return _allProductsList;
  }
}
