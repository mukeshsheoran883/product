import 'package:flutter/material.dart';
import 'package:product/screen/product_screen.dart';
import 'package:product/service/provider_product.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MultiProvider(providers: [
        ChangeNotifierProvider(create: (context) {
          return ProviderProduct();
        },)
      ],
      child: const MyHomePage()),
    );
  }
}


