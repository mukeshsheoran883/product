

import 'package:product/product/model/products_model.dart';

class ProductResponseList {
  List<ProductsModel> products;

  ProductResponseList({required this.products});

  factory ProductResponseList.fromJson(Map<String, dynamic> json) {
    var productsJson = json['products'] as List;
    List<ProductsModel> productList = productsJson.map((product) => ProductsModel.fromJson(product)).toList();

    return ProductResponseList(products: productList);
  }
}