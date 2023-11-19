
import 'package:product/model/products_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static String layoutKey = 'layout_key';
  static const String _likedCountKeyPrefix = 'likedCount_';


  static Future<void> setLikedCount(int productId, int likedCount) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('$_likedCountKeyPrefix$productId', likedCount);
  }

  static Future<int> getLikedCount(int productId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('$_likedCountKeyPrefix$productId') ?? 0;
  }


  static Future setLayout(bool isList) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    sf.setBool(layoutKey, isList);
  }

  static Future<bool> getLayout() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    bool value = sf.getBool(layoutKey) ?? true;
    return value;
  }
  static Future<void> updateLikedProducts(ProductsModel product, bool isLiked) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> likedProducts = prefs.getStringList('likedProducts') ?? [];
    String productDetails = "${product.title},"
        "${product.price},"
        "${product.discountPercentage},"
        "${product.description},"
        "${product.images!.first}";

    if (isLiked && !likedProducts.contains(productDetails)) {
      likedProducts.add(productDetails);
    } else if (!isLiked) {
      likedProducts.remove(productDetails);
    }

    prefs.setStringList('likedProducts', likedProducts);
  }

  static Future<List<String>> getLikedProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('likedProducts') ?? [];
  }

}
