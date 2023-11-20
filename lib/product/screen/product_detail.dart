import 'package:flutter/material.dart';
import 'package:product/product/model/products_model.dart';
import 'package:product/product/service/shared_preference_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductDetail extends StatefulWidget {
  final ProductsModel? productsModel;

  const ProductDetail({Key? key, required this.productsModel}) : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  bool isLiked = true;
  int isLikedCount = 0;

  void likedCount() async {
    setState(() {
      isLikedCount = isLiked ? isLikedCount + 1 : isLikedCount - 1;
    });

    await SharedPrefService.setLikedCount(
        widget.productsModel!.id!.toInt(), isLikedCount);
  }


  @override
  void initState() {
    super.initState();
    likedProducts();
  }

  void likedProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool value = await SharedPrefService.getLayout();
    isLiked = value;
    bool liked = prefs.getBool(widget.productsModel!.id.toString()) ?? true;

    isLikedCount =
    await SharedPrefService.getLikedCount(widget.productsModel!.id!.toInt());

    setState(() {
      isLiked = liked;
    });
  }
  void unLikedProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(widget.productsModel!.id.toString(), !isLiked);
    setState(() {
      isLiked = !isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(widget.productsModel!.images!.first.toString()),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(widget.productsModel?.title ?? ''),
                  const Spacer(),
                  Column(
                    children: [
                      Row(
                        children: [
                          Text("$isLikedCount"),
                          const SizedBox(
                            width: 8,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {});
                              likedCount();
                              unLikedProducts();
                              SharedPrefService.setLayout(isLiked);
                              SharedPrefService.updateLikedProducts(
                                  widget.productsModel!, isLiked);
                            },
                            child: Icon(
                              isLiked ? Icons.favorite_border : Icons.favorite,
                              color: isLiked ? Colors.black : Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ), const SizedBox(height: 8),
              Row(
                children: [
                  for (int i = 1; i <= 5; i++)
                    Icon(
                      widget.productsModel!.rating! >= i
                          ? Icons.star
                          : widget.productsModel!.rating! >= i - 0.5
                          ? Icons.star_half
                          : Icons.star_border,
                      color: Colors.yellow,
                    ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(widget.productsModel!.rating.toString())
                ],
              ), const SizedBox(height: 8),
              Text("\$ ${widget.productsModel!.price}"),
              const SizedBox(height: 8),
              Text("Discount ${widget.productsModel!.discountPercentage}%"),
              const SizedBox(height: 8),
              Text("${widget.productsModel!.description}",),
            ],
          ),
        ),
      ),
    );
  }
}
