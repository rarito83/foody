import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:foody/data/source.dart';
import 'package:foody/model/product_model.dart';
import 'package:foody/common/request_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProductProvider extends ChangeNotifier {
  final ApiService apiService;
  ProductProvider({required this.apiService}) {
    fetchAllProducts();
  }

  RefreshController controller = RefreshController();

  var _listProduct = <ProductModel>[];
  List<ProductModel> get allProduct => _listProduct;

  RequestState _requestState = RequestState.noData;
  RequestState get requestState => _requestState;

  String _message = "";
  String get message => _message;

  // mengambil data product
  Future fetchAllProducts() async {
    try {
      _requestState = RequestState.loading;
      notifyListeners();

      final result = await ApiService().getAllProducts();

      if (result.isEmpty) {
        _requestState = RequestState.noData;
        notifyListeners();
        return _message = 'Failed to load data...';
      } else {
        _requestState = RequestState.hasData;
        notifyListeners();
        return _listProduct = result;
      }
    } catch (e) {
      _requestState = RequestState.error;
      notifyListeners();
      return _message = 'Something Wrong.. $e';
    }
  }

  // refresh data
  void pullRefresh() async {
    try {
      await Future.delayed(Duration(seconds: 2));
      _listProduct.clear();
      fetchAllProducts();
      notifyListeners();
      controller.refreshCompleted();
    } catch (e) {
      controller.refreshFailed();
    }
  }
}
