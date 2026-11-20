import 'package:flutter/material.dart';
import '../data/food_data.dart';
import '../models/food.dart';
import '../theme/app_theme.dart';
import '../widgets/food_grid.dart';
import '../widgets/food_details.dart';

class HomePage extends StatelessWidget {
  final String address;
  final int cartCount;
  final Set<int> favorites;
  final VoidCallback onAddress;
  final VoidCallback onCart;
  final ValueChanged<String> onCategory;
  final ValueChanged<Food> onAdd;
  final ValueChanged<Food> onFavorite;

  const HomePage({
    super.key,
    required this.address,
    required this.cartCount,
    required this.favorites,
    required this.onAddress,
    required this.onCart,
    required this.onCategory,
    required this.onAdd,
    required this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 10),
            child: Row(
              children: [
                const Icon(Icons.location_on, color: AppTheme.orange),
                const SizedBox(width: 8),
                Expanded(
                  child: InkWell(
                    onTap: onAddress,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Deliver to', style: TextStyle(fontSize: 11, color: Colors.grey)),
                        Text(address, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
                IconButton(onPressed: onCart, icon: Badge(isLabelVisible: cartCount > 0, label: Text('$cartCount'), child: const Icon(Icons.shopping_bag_outlined))),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              height: 215,
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: const LinearGradient(
                  colors: [Color(0xFF342B27), Color(0xFF9C4D26), Color(0xFFEF7929)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('LOCALBITES  •  TASTE THE TRADITION', style: TextStyle(color: Colors.white70, fontSize: 10, letterSpacing: 1)),
                        const SizedBox(height: 12),
                        const Text('Good food.\\nGood mood.', style: TextStyle(color: Colors.white, fontSize: 29, height: 1.1, fontWeight: FontWeight.w900)),
                        const SizedBox(height: 8),
                        const Text('Local favorites delivered to your door.', style: TextStyle(color: Colors.white, fontSize: 12)),
                        const SizedBox(height: 14),
                        FilledButton(
                          onPressed: () => onCategory('All'),
                          style: FilledButton.styleFrom(backgroundColor: Colors.white, foregroundColor: AppTheme.orange),
                          child: const Text('Explore food'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text('🍔\\n🍟\\n🍗', textAlign: TextAlign.center, style: TextStyle(fontSize: 43, height: 1.25)),
                ],
              ),
            ),
          ),
          _heading('Shop by category', 'View all', () => onCategory('All')),
          SizedBox(
            height: 116,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              children: const [
                _Category(name: 'Burgers', emoji: '🍔'),
                _Category(name: 'Pizza', emoji: '🍕'),
                _Category(name: 'Chicken', emoji: '🍗'),
                _Category(name: 'Local Meals', emoji: '🍛'),
                _Category(name: 'Drinks', emoji: '🥤'),
                _Category(name: 'Desserts', emoji: '🍰'),
              ],
            ),
          ),
          _heading('Popular near you', 'See all', () => onCategory('All')),
          FoodGrid(
            foods: FoodData.items.take(4).toList(),
            favorites: favorites,
            onAdd: onAdd,
            onFavorite: onFavorite,
            onTap: (food) => openFoodDetails(context, food, () => onAdd(food)),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(color: const Color(0xFFFFEBDD), borderRadius: BorderRadius.circular(18)),
              child: const Row(
                children: [
                  Icon(Icons.delivery_dining, color: AppTheme.orange, size: 34),
                  SizedBox(width: 12),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('Fresh food, delivered with care', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Choose a meal and place a demo order.', style: TextStyle(fontSize: 12, color: Colors.black54)),
                  ])),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _heading(String title, String action, VoidCallback onTap) => Padding(
    padding: const EdgeInsets.fromLTRB(20, 22, 16, 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
        TextButton(onPressed: onTap, child: Text(action)),
      ],
    ),
  );
}

class _Category extends StatelessWidget {
  final String name;
  final String emoji;
  const _Category({required this.name, required this.emoji});

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 88,
    child: Column(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: const BoxDecoration(color: Color(0xFFFFEBDD), shape: BoxShape.circle),
          child: Center(child: Text(emoji, style: const TextStyle(fontSize: 34))),
        ),
        const SizedBox(height: 7),
        Text(name, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
      ],
    ),
  );
}
