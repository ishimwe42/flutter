import 'package:flutter/material.dart';
import '../models/food.dart';
import '../theme/app_theme.dart';

class FoodCard extends StatelessWidget {
  final Food food;
  final bool favorite;
  final VoidCallback onAdd;
  final VoidCallback onFavorite;
  final VoidCallback onTap;

  const FoodCard({
    super.key,
    required this.food,
    required this.favorite,
    required this.onAdd,
    required this.onFavorite,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFFFF2E8), Color(0xFFFFE2CD)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Center(child: Text(food.emoji, style: const TextStyle(fontSize: 65))),
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Material(
                      color: Colors.white,
                      shape: const CircleBorder(),
                      child: IconButton(
                        visualDensity: VisualDensity.compact,
                        onPressed: onFavorite,
                        icon: Icon(favorite ? Icons.favorite : Icons.favorite_border, color: favorite ? Colors.red : Colors.black54),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(food.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 3),
                  Text(food.restaurant, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      Text(' ${food.rating}', style: const TextStyle(fontSize: 12)),
                      const Spacer(),
                      Flexible(child: Text('${food.price} RWF', overflow: TextOverflow.ellipsis, style: const TextStyle(color: AppTheme.orange, fontWeight: FontWeight.bold))),
                    ],
                  ),
                  const SizedBox(height: 9),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: onAdd,
                      style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 10)),
                      child: const Text('Add to cart'),
                    ),
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
