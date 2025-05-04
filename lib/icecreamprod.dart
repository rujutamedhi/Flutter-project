import 'package:flutter/material.dart';
import "prod_details.dart";
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ice Cream Shop',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const IceCreamShop(),
    );
  }
}

class IceCreamShop extends StatelessWidget {
  const IceCreamShop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Ice cream'),
        actions: const [
          IconButton(
            icon: Icon(Icons.mic),
            onPressed: null,
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.45,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductCard(product: products[index]);
        },
      ),
    );
  }
}



class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(),
          ),
        );
      },
      child: Card(
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 200, // Adjust this value as needed
              width: double.infinity, // Ensure full width
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(product.imageUrl), // Use AssetImage for local assets
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.star, size: 16, color: Colors.amber),
                      Text(' ${product.rating}'),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '₹${product.price}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {},
                      child: const Text('Add'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class Product {
  final String name;
  final double price;
  final double rating;
  final String imageUrl;

  Product({
    required this.name,
    required this.price,
    required this.rating,
    required this.imageUrl,
  });
}

final List<Product> products = [
  Product(
    name: 'Choco-Mint Oreo Brownie Fudge',
    price: 255.20,
    rating: 4.5,
    imageUrl: 'assets/chocolate.jpg',
  ),
  Product(
    name: 'Mocha Brownie Fudge',
    price: 280.00,
    rating: 4.8,
    imageUrl: 'assets/caramel.webp',
  ),
  Product(
    name: 'Ice Cream 1L',
    price: 199.00,
    rating: 4.6,
    imageUrl: 'assets/cornato.jpg',
  ),
  Product(
    name: 'Ice Cream Cone',
    price: 150.00,
    rating: 4.7,
    imageUrl: 'assets/sunday.jpg',
  ),
];