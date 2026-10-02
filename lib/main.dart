// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Activity',
//       home: const ActivityPage(),
//     );
//   }
// }

// class ActivityPage extends StatelessWidget {
//   const ActivityPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // AppBar
//       appBar: AppBar(
//         title: const Text('Flutter Activity - Set B'),
//         centerTitle: true,
//         backgroundColor: Colors.blue,
//         foregroundColor: Colors.white,
//       ),

//       // Body
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               // Title
//               const Text(
//                 'My Favorite Place',
//                 style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
//               ),

//               const SizedBox(height: 15),

//               // Network Image
//               Image.network(
//                 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e',
//                 height: 200,
//                 width: double.infinity,
//                 fit: BoxFit.cover,
//               ),

//               const SizedBox(height: 15),

//               // Paragraph
//               const Text(
//                 'My favorite place is the beach because it is peaceful, '
//                 'relaxing, and beautiful. I enjoy listening to the sound '
//                 'of the waves, feeling the fresh breeze, and spending '
//                 'time with family and friends.',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontSize: 16, height: 1.5),
//               ),

//               const SizedBox(height: 25),

//               // Row with five icons and labels
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: const [
//                   // Icon 1
//                   Column(
//                     children: [
//                       Icon(Icons.beach_access, size: 30, color: Colors.blue),
//                       SizedBox(height: 5),
//                       Text('Beach'),
//                     ],
//                   ),

//                   // Icon 2
//                   Column(
//                     children: [
//                       Icon(Icons.wb_sunny, size: 30, color: Colors.orange),
//                       SizedBox(height: 5),
//                       Text('Sunny'),
//                     ],
//                   ),

//                   // Icon 3
//                   Column(
//                     children: [
//                       Icon(Icons.water, size: 30, color: Colors.lightBlue),
//                       SizedBox(height: 5),
//                       Text('Water'),
//                     ],
//                   ),

//                   // Icon 4
//                   Column(
//                     children: [
//                       Icon(Icons.photo_camera, size: 30, color: Colors.purple),
//                       SizedBox(height: 5),
//                       Text('Photo'),
//                     ],
//                   ),

//                   // Icon 5
//                   Column(
//                     children: [
//                       Icon(Icons.favorite, size: 30, color: Colors.red),
//                       SizedBox(height: 5),
//                       Text('Love'),
//                     ],
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 25),

//               // Divider
//               const Divider(thickness: 2, color: Colors.grey),

//               const SizedBox(height: 25),

//               // Asset Image
//               Image.asset(
//                 'assets/beach.jpg',
//                 height: 200,
//                 width: double.infinity,
//                 fit: BoxFit.cover,
//               ),

//               const SizedBox(height: 15),

//               const Text(
//                 'Beautiful Beach',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gadget Catalog',
      home: const CatalogPage(),
    );
  }
}

class Gadget {
  final String name;
  final String category;
  final double price;
  final String image;
  final String spec;

  const Gadget({
    required this.name,
    required this.category,
    required this.price,
    required this.image,
    required this.spec,
  });

  factory Gadget.fromJson(Map<String, dynamic> json) {
    return Gadget(
      name: json['title'] as String,
      category: json['category'] as String,
      price: (json['price'] as num).toDouble(),
      image: json['thumbnail'] as String,
      spec: json['description'] as String,
    );
  }
}

Future<List<Gadget>> fetchGadgets() async {
  final response = await http.get(
    Uri.parse('https://dummyjson.com/products?limit=20'),
    headers: {'Accept': 'application/json'},
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to load gadgets (${response.statusCode})');
  }

  final json = jsonDecode(response.body) as Map<String, dynamic>;
  final products = json['products'] as List<dynamic>;
  return products
      .map((product) => Gadget.fromJson(product as Map<String, dynamic>))
      .toList();
}

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  final Set<String> favorites = {};
  late Future<List<Gadget>> gadgets;

  @override
  void initState() {
    super.initState();
    gadgets = fetchGadgets();
  }

  void _reloadGadgets() {
    setState(() {
      gadgets = fetchGadgets();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tech Gadget Catalog'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: const [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Student Tech Catalog',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text('Simple gadgets for everyday use'),
                      ],
                    ),
                  ),
                  Icon(Icons.devices, size: 40, color: Colors.blue),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: const [
                Expanded(child: StaticButton(text: 'Featured')),
                SizedBox(width: 12),
                Expanded(child: StaticButton(text: 'View Details')),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: FutureBuilder<List<Gadget>>(
                future: gadgets,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('Could not load gadgets.'),
                          const SizedBox(height: 8),
                          ElevatedButton.icon(
                            onPressed: _reloadGadgets,
                            icon: const Icon(Icons.refresh),
                            label: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }

                  final items = snapshot.data ?? [];
                  if (items.isEmpty) {
                    return const Center(child: Text('No gadgets found.'));
                  }

                  return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      final isFav = favorites.contains(item.name);
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  item.image,
                                  width: 110,
                                  height: 110,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Container(
                                        width: 110,
                                        height: 110,
                                        color: Colors.blueGrey.shade100,
                                        child: const Icon(Icons.devices),
                                      ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            item.name,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if (isFav) {
                                                favorites.remove(item.name);
                                              } else {
                                                favorites.add(item.name);
                                              }
                                            });
                                          },
                                          child: Icon(
                                            isFav
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color: isFav
                                                ? Colors.red
                                                : Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      item.category,
                                      style: TextStyle(
                                        color: Colors.grey.shade700,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(item.spec),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            '₱${item.price.toStringAsFixed(0)}',
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 6,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.blue.shade100,
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                          child: const Text('View Details'),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StaticButton extends StatelessWidget {
  final String text;
  const StaticButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
