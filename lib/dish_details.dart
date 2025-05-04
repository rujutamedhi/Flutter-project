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

  double calculateTotal() {
    final ingredients = widget.dish['ingredients'] as List<dynamic>;
    double total = 0;
    for (var ingredient in ingredients) {
      final name = ingredient['name'];
      final quantity = ingredientQuantities[name]!;
      final price = (ingredient['price'] as num).toDouble();
      total += price * quantity;
    }
    return total;
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
                      final double price = (ingredient['price'] as num).toDouble();
                      final int quantity = ingredientQuantities[name]!;

                      final num weightVal = num.tryParse(weight.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0;
                      final String unit = weight.replaceAll(RegExp(r'[0-9.]'), '').trim();

                      return ListTile(
                        title: Text(name),
                        subtitle: Text("₹${price.toStringAsFixed(2)} x $quantity = ₹${(price * quantity).toStringAsFixed(2)}"),
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
                            Text("${(weightVal * quantity)} $unit"),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Total: ₹${calculateTotal().toStringAsFixed(2)}",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
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
