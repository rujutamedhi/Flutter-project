// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'dish_details.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setSystemUIOverlayStyle(
//       const SystemUiOverlayStyle(
//         statusBarColor: Colors.green,
//         statusBarIconBrightness: Brightness.light,
//       ),
//     );
//
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primaryColor: Colors.green,
//         scaffoldBackgroundColor: Colors.white,
//       ),
//       home: const HomePage(),
//     );
//   }
// }
//
// class HomePage extends StatelessWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   final List<Map<String, dynamic>> dishes = const [
//     {
//       "name": "Pav Bhaji",
//       "ingredients": [
//         {"name": "Potatoes", "weight": "500g"},
//         {"name": "Tomatoes", "weight": "250g"},
//         {"name": "Onions", "weight": "150g"},
//         {"name": "Pav Bhaji Masala", "weight": "2 tbsp"},
//         {"name": "Butter", "weight": "50g"},
//         {"name": "Capsicum", "weight": "100g"},
//         {"name": "Garlic", "weight": "10g"},
//         {"name": "Green Peas", "weight": "100g"}
//       ],
//       "image": "https://upload.wikimedia.org/wikipedia/commons/3/3f/Pav_Bhaji.jpg"
//     },
//     {
//       "name": "Pulao",
//       "ingredients": [
//         {"name": "Basmati Rice", "weight": "250g"},
//         {"name": "Carrots", "weight": "100g"},
//         {"name": "Green Peas", "weight": "100g"},
//         {"name": "Beans", "weight": "100g"},
//         {"name": "Onions", "weight": "100g"},
//         {"name": "Cumin Seeds", "weight": "1 tsp"},
//         {"name": "Ghee", "weight": "2 tbsp"},
//         {"name": "Bay Leaf", "weight": "1 leaf"}
//       ],
//       "image": "https://upload.wikimedia.org/wikipedia/commons/5/5b/Vegetable_pulao.jpg"
//     },
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Dishes List'),
//         backgroundColor: Colors.green,
//       ),
//       body: ListView.builder(
//         itemCount: dishes.length,
//         itemBuilder: (context, index) {
//           final dish = dishes[index];
//
//           return GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => DishDetails(dish: dish),
//                 ),
//               );
//             },
//             child: Card(
//               margin: const EdgeInsets.all(10),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   ClipRRect(
//                     borderRadius:
//                     const BorderRadius.vertical(top: Radius.circular(10)),
//                     child: Image.network(
//                       dish['image'] ?? '',
//                       width: double.infinity,
//                       height: 180,
//                       fit: BoxFit.cover,
//                       errorBuilder: (context, error, stackTrace) => Container(
//                         height: 180,
//                         color: Colors.grey[300],
//                         child: const Center(child: Icon(Icons.broken_image)),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(10),
//                     child: Text(
//                       dish['name'] ?? 'Unknown Dish',
//                       style: const TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'dishes.dart';
import 'icecreamprod.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Color(0xFF1E8040),
        elevation: 0,

        title: Column(
          mainAxisSize: MainAxisSize.min,  // Prevents Column from expanding beyond AppBar
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            // Flexible(  // Prevents overflow
            //   // child: Image.network(
            //   //   'https://hebbkx1anhila5yf.public.blob.vercel-storage.com/WhatsApp%20Image%202025-02-03%20at%207.18.38%20PM%20(1)-5NeEZVgjFEJKRwg1Bk7oHBqBwMGcdv.jpeg',
            //   //   height: 40,
            //   //   fit: BoxFit.contain,  // Ensures image does not expand unexpectedly
            //   // ),
            // ),
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.white, size: 20),
                Expanded( // Ensures text doesn't overflow
                  child: Text(
                    'Deliver to Selected Location',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(Icons.keyboard_arrow_down, color: Colors.white),
              ],
            ),
            Text(
              'Mahadeo Wadi, Mumbai - 400071',
              style: TextStyle(fontSize: 12, color: Colors.white70),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),

        actions: [
          Container(
            padding: EdgeInsets.all(6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,

              children: [
                Text(
                  'Delivers in',
                  style: TextStyle(fontSize: 12, color: Colors.white70),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.flash_on, size: 16, color: Colors.black),
                      Text(
                        '6 mins',
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.person_outline),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: EdgeInsets.all(16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search 20000+ products',
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: Icon(Icons.mic),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),

            // Sale Banner
            Container(
              padding: EdgeInsets.all(16),
              color: Color(0xFFFF6B4A),
              child: Column(
                children: [
                  Text(
                    'BIG INDIAN',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'GROCERY SALE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '1st to 9th Feb',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),

            // Categories Grid
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              padding: EdgeInsets.all(16),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                _buildCategoryCard(
                  'Icecream',
                  'assets/sunday.jpg',
                  context, // Pass context
                ),
                _buildCategoryCard(
                  'Cleaning &\nhousehold',
                  'assets/household.png',
                  context,
                ),
                _buildCategoryCard(
                  'Lays',
                  'assets/lays.jpg',
                  context,
                ),
                _buildCategoryCard(
                  'Beauty &\nhygiene',
                  'assets/cosmetics.png',
                  context,
                ),
                _buildCategoryCard(
                  'Kitchen, garden\n& pets',
                  'assets/pet.png',
                  context,
                ),
                _buildCategoryCard(
                  'Electronic &\napparel',
                  'assets/electronics.png',
                  context,
                ),
              ],
            ),


            // Bottom Navigation Bar
            Container(
              padding: EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey.shade300)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(Icons.home, 'Home', true, context),
                  _buildNavItem(Icons.grid_view, 'Dishes', false, context),
                  _buildNavItem(Icons.refresh, 'Re-Order', false, context),
                ],
              ),

            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(String title, String imageAsset, BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (title == 'Icecream') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => IceCreamShop()),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFFFF3E0),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imageAsset, height: 80),
            SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildNavItem(IconData icon, String label, bool isSelected, BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (label == 'Dishes') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: isSelected ? Colors.green[800] : Colors.grey),
          Text(label, style: TextStyle(color: isSelected ? Colors.green[800] : Colors.grey)),
        ],
      ),
    );
  }

}