import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:skivy_mobile/models/product_entry.dart';
import 'package:skivy_mobile/screens/list_productentry.dart';
import 'package:skivy_mobile/screens/login.dart';
import 'package:skivy_mobile/screens/productentry_form.dart';

class ItemHomepage {
  final String name;
  final IconData icon;

  ItemHomepage(this.name, this.icon);
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
    final request = context.watch<CookieRequest>();
    return Material(
      color: buttonColors[colorIndex % buttonColors.length],
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () async {
          // Show SnackBar when the item is pressed
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text("Kamu telah menekan tombol ${item.name}!"))
            );


          // Add logic to navigate to a new page if the item name is "Lihat Produk" or "Tambah Produk"
          if (item.name == "Lihat Product") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProductEntryPage(), // Sesuaikan dengan nama halaman
              ),
            );
          } else if (item.name == "Tambah Product") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProductEntryFormPage(), // Sesuaikan dengan nama halaman
              ),
            );
          } else if (item.name == "Logout") {
            final response = await request.logout(
                "http://127.0.0.1:8000/auth/logout/"); // Ganti dengan URL server
            String message = response["message"];
            if (context.mounted) {
              if (response['status']) {
                String uname = response["username"];
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("$message Sampai jumpa, $uname."),
                ));
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                  ),
                );
              }
            }
          }
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
