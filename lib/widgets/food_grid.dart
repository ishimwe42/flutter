import 'package:flutter/material.dart';
import '../models/food.dart';
import 'food_card.dart';

class FoodGrid extends StatelessWidget {
  final List<Food> foods;
  final Set<int> favorites;
  final ValueChanged<Food> onAdd;
  final ValueChanged<Food> onFavorite;
  final ValueChanged<Food> onTap;

  const FoodGrid({
    super.key,
    required this.foods,
    required this.favorites,
    required this.onAdd,
    required this.onFavorite,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (foods.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(35),
        child: Center(child: Text('No food found. Try another search.')),
      );
    }
    final width = MediaQuery.sizeOf(context).width;
    final columns = width >= 1050 ? 4 : width >= 650 ? 3 : 2;
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 20),
      itemCount: foods.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        childAspectRatio: width >= 650 ? 0.78 : 0.68,
      ),
      itemBuilder: (context, index) {
        final food = foods[index];
        return FoodCard(
          food: food,
          favorite: favorites.contains(food.id),
          onAdd: () => onAdd(food),
          onFavorite: () => onFavorite(food),
          onTap: () => onTap(food),
        );
      },
    );
  }
}
