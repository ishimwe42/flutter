import 'package:flutter/material.dart';
import '../data/food_data.dart';
import '../models/food.dart';

class CartPage extends StatelessWidget {
  final Map<int, int> cart;
  final int subtotal;
  final void Function(Food, int) onQuantity;
  final VoidCallback onCheckout;
  final VoidCallback onBrowse;

  const CartPage({
    super.key,
    required this.cart,
    required this.subtotal,
    required this.onQuantity,
    required this.onCheckout,
    required this.onBrowse,
  });

  @override
  Widget build(BuildContext context) {
    final items = FoodData.items.where((food) => cart.containsKey(food.id)).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(padding: EdgeInsets.all(20), child: Text('Your cart', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
        Expanded(
          child: items.isEmpty
              ? Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Icon(Icons.shopping_bag_outlined, size: 76, color: Colors.black26),
                  const SizedBox(height: 12),
                  const Text('Your cart is empty', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  FilledButton(onPressed: onBrowse, child: const Text('Explore food')),
                ]))
              : ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    ...items.map((food) => Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(children: [
                          Container(width: 62, height: 62, decoration: BoxDecoration(color: const Color(0xFFFFEBDD), borderRadius: BorderRadius.circular(14)), child: Center(child: Text(food.emoji, style: const TextStyle(fontSize: 32)))),
                          const SizedBox(width: 12),
                          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text(food.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                            Text('${food.price} RWF', style: const TextStyle(color: Color(0xFFE87524))),
                          ])),
                          IconButton(onPressed: () => onQuantity(food, -1), icon: const Icon(Icons.remove_circle_outline)),
                          Text('${cart[food.id]}'),
                          IconButton(onPressed: () => onQuantity(food, 1), icon: const Icon(Icons.add_circle_outline)),
                        ]),
                      ),
                    )),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: Column(children: [
                          _row('Subtotal', subtotal),
                          const SizedBox(height: 8),
                          _row('Delivery fee', 1000),
                          const Divider(height: 24),
                          _row('Total', subtotal + 1000, bold: true),
                          const SizedBox(height: 14),
                          SizedBox(width: double.infinity, child: FilledButton(onPressed: onCheckout, child: const Text('Continue to checkout'))),
                        ]),
                      ),
                    ),
                  ],
                ),
        ),
      ],
    );
  }

  Widget _row(String label, int value, {bool bold = false}) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(label, style: TextStyle(fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
      Text('$value RWF', style: TextStyle(fontWeight: FontWeight.bold, color: bold ? const Color(0xFFE87524) : null)),
    ],
  );
}
