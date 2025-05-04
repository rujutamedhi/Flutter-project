import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dish_details.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.green,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.green,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> dishes = const [
    {
      "name": "Pav Bhaji",
      "ingredients": [
        { "name": "Potatoes", "weight": "500g", "price": 25 },
        { "name": "Tomatoes", "weight": "250g", "price": 15 },
        { "name": "Onions", "weight": "150g", "price": 10 },
        { "name": "Pav Bhaji Masala", "weight": "20g", "price": 15 },
        { "name": "Butter", "weight": "50g", "price": 20 },
        { "name": "Capsicum", "weight": "100g", "price": 15 },
        { "name": "Garlic", "weight": "10g", "price": 5 },
        { "name": "Green Peas", "weight": "100g", "price": 15 }
      ],
      "image": "assets/pavbhaji.png"
    },
    {
      "name": "Chinese Noodles",
      "ingredients": [
        { "name": "Noodles", "weight": "200g", "price": 25 },
        { "name": "Capsicum", "weight": "100g", "price": 15 },
        { "name": "Carrots", "weight": "100g", "price": 12 },
        { "name": "Spring Onions", "weight": "50g", "price": 10 },
        { "name": "Soy Sauce", "weight": "20g", "price": 8 },
        { "name": "Vinegar", "weight": "20ml", "price": 6 },
        { "name": "Garlic", "weight": "10g", "price": 5 },
        { "name": "Oil", "weight": "20ml", "price": 10 }
      ],
      "image": "assets/noodles.png"
    },
    {
      "name": "Pulao",
      "ingredients": [
        { "name": "Basmati Rice", "weight": "250g", "price": 30 },
        { "name": "Carrots", "weight": "100g", "price": 12 },
        { "name": "Green Peas", "weight": "100g", "price": 15 },
        { "name": "Beans", "weight": "100g", "price": 15 },
        { "name": "Onions", "weight": "100g", "price": 8 },
        { "name": "Cumin Seeds", "weight": "10g", "price": 10 },
        { "name": "Ghee", "weight": "20g", "price": 20 },
        { "name": "Bay Leaf", "weight": "20g", "price": 5 }
      ],
      "image": "assets/poolao.png"
    }
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dishes List'),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: dishes.length,
        itemBuilder: (context, index) {
          final dish = dishes[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DishDetails(dish: dish),
                ),
              );
            },
            child: Card(
              margin: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(10)),
                    child: Image.network(
                      dish['image'] ?? '',
                      width: double.infinity,
                      height: 180,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: 180,
                        color: Colors.grey[300],
                        child: const Center(child: Icon(Icons.broken_image)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      dish['name'] ?? 'Unknown Dish',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}