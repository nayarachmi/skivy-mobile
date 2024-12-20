import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:skivy_mobile/screens/list_productentry.dart';
import 'package:skivy_mobile/screens/menu.dart';
import 'package:skivy_mobile/screens/productentry_form.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: const Column(
              children: [
                Text(
                  'Skivy',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Padding(padding: EdgeInsets.all(8)),
                Text(
                  "Your Beauty One Stop Solution",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                ),

              ],
            ),
          ),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text('Halaman Utama'),
              // Bagian redirection ke MyHomePage
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyHomePage(),
                    ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.shop),
              title: const Text('Tambah Product'),
              // Bagian redirection ke ProductEntryFormPage
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductEntryFormPage(),
                    ));
              },
            ),
            // Kode ListTile Menu
            ListTile(
                leading: const Icon(Icons.shop_2),
                title: const Text('Daftar Produk'),
                onTap: () {
                    // Route menu ke halaman produk
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ProductEntryPage()),
                    );
                },
            ),

        ],
      ),
    );
  }
}