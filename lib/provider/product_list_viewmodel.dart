import 'package:flutter/material.dart';
import 'package:product_list_task/base/base_viewmodel.dart';
import 'package:product_list_task/constants/app_const_text.dart';
import 'package:product_list_task/model/product_list_model.dart';
import 'package:product_list_task/services/product_list_service.dart';

class ProductListProvider extends BaseViewModel {
  final _service = ApiCollection();
  bool isLoading = false;
  List<ProductListModel> _listOfProduct = [];
  List<ProductListModel> get listOfProduct => _listOfProduct;
  int cartItemCount = 0;

  Future<void> getProductList() async {
    try {
      setViewState(ViewState.BUSY);
      final response = await _service.dashboardListApi();

      _listOfProduct = response;
    } catch (e) {
      const SnackBar(
        content: Text(
          AppConstString.noProductFound,
        ),
      );
    } finally {
      setViewState(ViewState.IDLE);
    }
  }

  final Map<ProductListModel, int> _items = {};

  Map<ProductListModel, int> get items => _items;

  double get totalPrice => _items.entries
      .fold(0, (total, entry) => total + entry.key.price! * entry.value);

  void add(ProductListModel product) {
    if (_items.containsKey(product)) {
      _items[product] = _items[product]! + 1;
    } else {
      _items[product] = 1;
      cartItemCount++;
    }
    notifyListeners();
  }

  void remove(ProductListModel product) {
    if (_items.containsKey(product) && _items[product]! > 1) {
      _items[product] = _items[product]! - 1;
    } else {
      _items.remove(product);
      cartItemCount--;
    }
    notifyListeners();
  }

  void removeAll(ProductListModel product) {
    _items.remove(product);
    notifyListeners();
  }
}
