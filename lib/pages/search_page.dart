import 'package:flutter/material.dart';
import '../data/food_data.dart';
import '../models/food.dart';
import '../widgets/food_grid.dart';
import '../widgets/food_details.dart';

class SearchPage extends StatefulWidget {
  final Set<int> favorites;
  final ValueChanged<Food> onAdd;
  final ValueChanged<Food> onFavorite;
  const SearchPage({super.key, required this.favorites, required this.onAdd, required this.onFavorite});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    final results = FoodData.items.where((food) {
      final q = query.toLowerCase();
      return food.name.toLowerCase().contains(q) ||
          food.category.toLowerCase().contains(q) ||
          food.restaurant.toLowerCase().contains(q);
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(padding: EdgeInsets.fromLTRB(20, 20, 20, 12), child: Text('Find your favorite food', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            onChanged: (value) => setState(() => query = value),
            decoration: InputDecoration(
              hintText: 'Search meals, categories or restaurants',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(onPressed: () => setState(() => query = ''), icon: const Icon(Icons.close)),
            ),
          ),
        ),
        Expanded(child: SingleChildScrollView(child: FoodGrid(
          foods: results,
          favorites: widget.favorites,
          onAdd: widget.onAdd,
          onFavorite: widget.onFavorite,
          onTap: (food) => openFoodDetails(context, food, () => widget.onAdd(food)),
        ))),
      ],
    );
  }
}
