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
        {"name": "Potatoes", "weight": "500g"},
        {"name": "Tomatoes", "weight": "250g"},
        {"name": "Onions", "weight": "150g"},
        {"name": "Pav Bhaji Masala", "weight": "2 tbsp"},
        {"name": "Butter", "weight": "50g"},
        {"name": "Capsicum", "weight": "100g"},
        {"name": "Garlic", "weight": "10g"},
        {"name": "Green Peas", "weight": "100g"}
      ],
      "image": "assets/pavbhaji.png"
    },
    {
      "name": "Chinese Noodles",
      "ingredients": [
        { "name": "Noodles", "weight": "200g" },
        { "name": "Capsicum", "weight": "100g" },
        { "name": "Carrots", "weight": "100g" },
        { "name": "Spring Onions", "weight": "50g" },
        { "name": "Soy Sauce", "weight": "2 tbsp" },
        { "name": "Vinegar", "weight": "1 tbsp" },
        { "name": "Garlic", "weight": "10g" },
        { "name": "Oil", "weight": "2 tbsp" }
      ],
  "image":"assets/noodles.png"
    },
    {
      "name": "Pulao",
      "ingredients": [
        {"name": "Basmati Rice", "weight": "250g"},
        {"name": "Carrots", "weight": "100g"},
        {"name": "Green Peas", "weight": "100g"},
        {"name": "Beans", "weight": "100g"},
        {"name": "Onions", "weight": "100g"},
        {"name": "Cumin Seeds", "weight": "1 tsp"},
        {"name": "Ghee", "weight": "2 tbsp"},
        {"name": "Bay Leaf", "weight": "1 leaf"}
      ],
      "image": "assets/poolao.png"
    },
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