import 'package:flutter/material.dart';
import 'package:product/product/model/products_model.dart';
import 'package:product/product/service/api_service.dart';


class ProviderProduct extends ChangeNotifier{
  late ProductApiService productApiService;
  List<ProductsModel> productModel = [];
  Future<void> loadProducts() async {


    productModel = await ProductApiService.getProductInfo();
    notifyListeners();
  }

}