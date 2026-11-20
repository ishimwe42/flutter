import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  final String address;
  final int favoritesCount;
  final VoidCallback onAddress;
  const AccountPage({super.key, required this.address, required this.favoritesCount, required this.onAddress});

  @override
  Widget build(BuildContext context) => ListView(
    children: [
      const Padding(padding: EdgeInsets.all(20), child: Text('My account', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
      const SizedBox(height: 12),
      const CircleAvatar(radius: 43, backgroundColor: Color(0xFFFFEBDD), child: Icon(Icons.person, size: 48, color: Color(0xFFE87524))),
      const SizedBox(height: 12),
      const Center(child: Text('Welcome to LocalBites', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold))),
      const Center(child: Text('Your food, your way', style: TextStyle(color: Colors.grey))),
      const SizedBox(height: 24),
      ListTile(leading: const Icon(Icons.location_on_outlined), title: const Text('Delivery address'), subtitle: Text(address), trailing: const Icon(Icons.chevron_right), onTap: onAddress),
      ListTile(leading: const Icon(Icons.favorite_border), title: const Text('Favorites'), trailing: Text('$favoritesCount')),
      const ListTile(leading: Icon(Icons.receipt_long_outlined), title: Text('Order history'), subtitle: Text('Your placed orders will appear here')),
      const ListTile(leading: Icon(Icons.help_outline), title: Text('Help and support')),
      const ListTile(leading: Icon(Icons.info_outline), title: Text('About LocalBites'), subtitle: Text('Food ordering demo')),
    ],
  );
}
