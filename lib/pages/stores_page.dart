
import 'package:flutter/material.dart';

class StoresPage extends StatelessWidget {
  const StoresPage({super.key});

  @override
  Widget build(BuildContext context) {
    final stores = [
      ('🍗', 'Foso Foods', 'Local food and delicious meals'),
      ('🍽️', 'Golden City Palace', 'Restaurant and dining'),
      ('❤️', 'Jays Restaurant', 'Fresh and tasty food'),
      ('🍗', 'KFC', 'Chicken and fast food'),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Restaurants & Stores')),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: stores.length,
        itemBuilder: (context, index) {
          final store = stores[index];

          return Card(
            color: Colors.white,
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: CircleAvatar(
                radius: 27,
                backgroundColor: const Color(0xFFFFEEE4),
                child: Text(
                  store.$1,
                  style: const TextStyle(fontSize: 25),
                ),
              ),
              title: Text(
                store.$2,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(store.$3),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Color(0xFFF47721),
              ),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('You selected ${store.$2}')),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
