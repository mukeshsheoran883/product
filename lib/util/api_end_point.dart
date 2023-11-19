class ApiEndPoint{
  static const String baseURL = "https://dummyjson.com/";
  static const String product = "${baseURL}products";
  static String getProductUrl(String id) {
    return '${baseURL}products/$id';
  }
}