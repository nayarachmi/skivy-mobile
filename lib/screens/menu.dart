import 'package:flutter/material.dart';
import 'package:skivy_mobile/widgets/left_drawer.dart';
import 'package:skivy_mobile/widgets/product_card.dart';

class MyHomePage extends StatelessWidget {
  final String npm = '2306230685';
  final String name = 'Naya Kusuma';
  final String className = 'PBP B';
  MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Skivy',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      drawer: const LeftDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InfoCard(title: 'NPM', content: npm),
                InfoCard(title: 'Name', content: name),
                InfoCard(title: 'Class', content: className),
              ],
            ),
            const SizedBox(height: 16.0),
            Center(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Text(
                      'Welcome to Skivy',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  GridView.count(
                    primary: true,
                    padding: const EdgeInsets.all(20),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    children: List.generate(items.length, (index) {
                      return ItemCard(items[index], colorIndex: index);
                    }),
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

final List<ItemHomepage> items = [
  ItemHomepage(number: 1, name:"Lihat Product", icon: Icons.shopping_bag),   // Updated icon
  ItemHomepage(number: 2, name:"Tambah Product", icon: Icons.add_circle),    // Updated icon
  ItemHomepage(number: 3, name:"Logout", icon: Icons.exit_to_app),           // Updated icon
];


class InfoCard extends StatelessWidget {
  final String title;
  final String content;

  const InfoCard({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: Container(
        width: MediaQuery.of(context).size.width / 3.5,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(content),
          ],
        ),
      ),
    );
  }
}
<<<<<<< HEAD:lib/menu.dart

class ItemHomepage {
  final int number;
  final String name;
  final IconData icon;

  ItemHomepage({required this.number, required this.name, required this.icon});
}

class ItemCard extends StatelessWidget {
  final ItemHomepage item;
  final int colorIndex;

  ItemCard(this.item, {super.key, required this.colorIndex});

  // Define a list of colors for each button
  final List<Color> buttonColors = [
    Colors.pinkAccent,
    Colors.orangeAccent,
    Colors.blueAccent,
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      color: buttonColors[colorIndex % buttonColors.length],
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text("Kamu telah menekan tombol ${item.name}!"))
            );
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item.number.toString(),
                ),
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
=======
>>>>>>> 0fe97608e9c74101804a2ec9886ead3579cf0110:lib/screens/menu.dart
