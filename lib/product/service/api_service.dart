import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:product/product/model/products_model.dart';
import 'package:product/product/model/products_response_list.dart';
import 'package:product/util/api_end_point.dart';


class ProductApiService {
  static Future<List<ProductsModel>> getProductInfo() async {
    String url = ApiEndPoint.product;
    http.Response response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      String body = response.body;
      final data = jsonDecode(body);

      ProductResponseList productResponseList =
      ProductResponseList.fromJson(data);
      return productResponseList.products;
    } else {
      throw 'Something went wrong';
    }
  }
}
