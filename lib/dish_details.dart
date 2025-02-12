import 'package:flutter/material.dart';
import 'order_form.dart';
class DishDetails extends StatefulWidget {
  final Map<String, dynamic> dish;

  const DishDetails({Key? key, required this.dish}) : super(key: key);

  @override
  _DishDetailsState createState() => _DishDetailsState();
}

class _DishDetailsState extends State<DishDetails> {
  late Map<String, int> ingredientQuantities;

  @override
  void initState() {
    super.initState();
    // Initialize each ingredient with quantity 1
    ingredientQuantities = {
      for (var ingredient in widget.dish['ingredients']) ingredient['name']: 1
    };
  }

  void increaseQuantity(String ingredient) {
    setState(() {
      ingredientQuantities[ingredient] = (ingredientQuantities[ingredient] ?? 1) + 1;
    });
  }

  void decreaseQuantity(String ingredient) {
    if (ingredientQuantities[ingredient]! > 1) {
      setState(() {
        ingredientQuantities[ingredient] = ingredientQuantities[ingredient]! - 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final ingredients = widget.dish['ingredients'] as List<dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.dish['name']),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              widget.dish['image'],
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const Text(
                    "Ingredients",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    children: ingredients.map((ingredient) {
                      final String name = ingredient['name'];
                      final String weight = ingredient['weight'];

                      final num initialValue = num.tryParse(weight.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0;
                      final String unit = weight.replaceAll(RegExp(r'[0-9.]'), '').trim();
                      final int quantity = ingredientQuantities[name]!;

                      return ListTile(
                        title: Text(name),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () => decreaseQuantity(name),
                              icon: const Icon(Icons.remove_circle, color: Colors.red),
                            ),
                            Text(quantity.toString(), style: const TextStyle(fontSize: 16)),
                            IconButton(
                              onPressed: () => increaseQuantity(name),
                              icon: const Icon(Icons.add_circle, color: Colors.green),
                            ),
                            const SizedBox(width: 10),
                            Text("${(initialValue * quantity)} $unit"),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            padding: const EdgeInsets.symmetric(vertical: 15),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OrderForm()),
            );
          },
          child: const Text(
            "Place Order",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
