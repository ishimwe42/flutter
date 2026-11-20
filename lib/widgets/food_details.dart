import 'package:flutter/material.dart';
import '../models/food.dart';

void openFoodDetails(BuildContext context, Food food, VoidCallback onAdd) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
    builder: (context) => Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Text(food.emoji, style: const TextStyle(fontSize: 100))),
          const SizedBox(height: 12),
          Text(food.name, style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
          Text(food.restaurant, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 12),
          Text(food.description),
          const SizedBox(height: 12),
          Text('${food.price} RWF', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Color(0xFFE87524))),
          const SizedBox(height: 16),
          SizedBox(width: double.infinity, child: FilledButton(onPressed: () { Navigator.pop(context); onAdd(); }, child: const Text('Add to cart'))),
          const SizedBox(height: 12),
        ],
      ),
    ),
  );
}
