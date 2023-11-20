import 'package:flutter/material.dart';
import 'package:product/product/service/shared_preference_service.dart';
class LikedProductsScreen extends StatelessWidget {
  const LikedProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liked Products'),
      ),
      body: FutureBuilder<List<String>>(
        // Retrieve liked products from SharedPreferences
        future: SharedPrefService.getLikedProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No liked products yet.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                List<String> details = snapshot.data![index].split(",");
                String title = details[0];
                String price = details[1];
                String discount = details[2];
                String description = details[3];
                String image = details[4];

                return ListTile(
                  leading: Image.network(image),
                  title: Text(title),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Price: \$ $price"),
                      Text("Discount: $discount%"),
                      Text(description),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}