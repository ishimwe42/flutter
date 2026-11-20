import 'package:flutter/material.dart';
import '../data/food_data.dart';
import '../models/food.dart';
import '../widgets/food_grid.dart';
import '../widgets/food_details.dart';

class CategoriesPage extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onSelected;
  final Set<int> favorites;
  final ValueChanged<Food> onAdd;
  final ValueChanged<Food> onFavorite;

  const CategoriesPage({
    super.key,
    required this.selected,
    required this.onSelected,
    required this.favorites,
    required this.onAdd,
    required this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final foods = FoodData.items.where((f) => selected == 'All' || f.category == selected).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(padding: EdgeInsets.fromLTRB(20, 20, 20, 12), child: Text('Explore food', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
        SizedBox(
          height: 52,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: FoodData.categories.map((value) => Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ChoiceChip(label: Text(value), selected: selected == value, onSelected: (_) => onSelected(value)),
            )).toList(),
          ),
        ),
        Expanded(child: SingleChildScrollView(child: FoodGrid(
          foods: foods,
          favorites: favorites,
          onAdd: onAdd,
          onFavorite: onFavorite,
          onTap: (food) => openFoodDetails(context, food, () => onAdd(food)),
        ))),
      ],
    );
  }
}
