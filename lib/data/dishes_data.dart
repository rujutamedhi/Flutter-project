import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Define JSON data directly in home.dart
  final Map<String, dynamic> dishesData = {
    "dishes": [
      {
        "title": "Pav Bhaji",
        "ingredients": [
          { "name": "Potatoes", "weight": "500g" },
          { "name": "Tomatoes", "weight": "250g" },
          { "name": "Onions", "weight": "150g" },
          { "name": "Pav Bhaji Masala", "weight": "2 tbsp" },
          { "name": "Butter", "weight": "50g" },
          { "name": "Capsicum", "weight": "100g" },
          { "name": "Garlic", "weight": "10g" },
          { "name": "Green Peas", "weight": "100g" }
        ]
      },
      {
        "title": "Chinese Noodles",
        "ingredients": [
          { "name": "Noodles", "weight": "200g" },
          { "name": "Capsicum", "weight": "100g" },
          { "name": "Carrots", "weight": "100g" },
          { "name": "Spring Onions", "weight": "50g" },
          { "name": "Soy Sauce", "weight": "2 tbsp" },
          { "name": "Vinegar", "weight": "1 tbsp" },
          { "name": "Garlic", "weight": "10g" },
          { "name": "Oil", "weight": "2 tbsp" }
        ]
      },
      {
        "title": "Pulao",
        "ingredients": [
          { "name": "Basmati Rice", "weight": "250g" },
          { "name": "Carrots", "weight": "100g" },
          { "name": "Green Peas", "weight": "100g" },
          { "name": "Beans", "weight": "100g" },
          { "name": "Onions", "weight": "100g" },
          { "name": "Cumin Seeds", "weight": "1 tsp" },
          { "name": "Ghee", "weight": "2 tbsp" },
          { "name": "Bay Leaf", "weight": "1 leaf" }
        ]
      }
    ]
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(),
                  ),
                ),
              ),
            ),

            // Dishes Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Featured Dishes',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: dishesData['dishes']!.length,
                      itemBuilder: (context, index) {
                        final dish = dishesData['dishes']![index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Column(
                            children: [
                              Image.network(
                                'https://example.com/${dish['name'].toString().toLowerCase().replaceAll(' ', '_')}.jpg',
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                dish['name'].toString(),
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Sale Banner
            const SizedBox(
              height: 100,
              child: Center(
                child: Text('Sale Banner'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
