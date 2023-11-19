import 'package:flutter/material.dart';
import 'package:product/model/products_model.dart';

class ProductDetail extends StatefulWidget {
  final ProductsModel? productsModel;

  const ProductDetail({super.key, required this.productsModel});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
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
                ],
              ),
              const SizedBox(height: 8),
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
              ),
              const SizedBox(height: 8),
              Text("\$ ${widget.productsModel!.price}"),
              const SizedBox(height: 8),
              Text("Discount ${widget.productsModel!.discountPercentage}%"),
              const SizedBox(height: 8),
              Text(
                "${widget.productsModel!.description}",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
