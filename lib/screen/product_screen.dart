import 'package:flutter/material.dart';
import 'package:product/model/products_model.dart';
import 'package:product/screen/like_screen.dart';
import 'package:product/screen/product_detail.dart';
import 'package:product/service/provider_product.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    ProviderProduct providerProduct =
        Provider.of<ProviderProduct>(context, listen: false);
    super.initState();
    providerProduct.loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Product'),
          actions: [
            IconButton(
              icon: const Icon(Icons.favorite),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LikedProductsScreen(),
                  ),
                );
              },
            ),
          ],
        ),
        body: Consumer<ProviderProduct>(
          builder: (BuildContext context, ProviderProduct providerProduct,
              Widget? child) {
            return ListView.builder(
              itemCount: providerProduct.productModel.length,
              itemBuilder: (context, index) {
                ProductsModel productsModel =
                    providerProduct.productModel[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return ProductDetail( productsModel: productsModel,);
                    },),);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Image.network(productsModel.images!.first.toString()),
                        ListTile(
                          title: Text('Name : ${productsModel.title}'),
                          subtitle: Text(
                              "Price : \$${productsModel.price.toString()}"),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ));
  }
}
