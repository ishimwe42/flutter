import '../models/food.dart';

class FoodData {
  static const categories = ['All', 'Burgers', 'Pizza', 'Chicken', 'Local Meals', 'Fast Food', 'Drinks', 'Desserts'];

  static const items = <Food>[
    Food(id: 1, name: 'Classic Beef Burger', category: 'Burgers', restaurant: 'Foso Foods', emoji: '🍔', price: 3500, rating: 4.8, description: 'Juicy beef patty, fresh lettuce, tomato and house sauce in a toasted bun.'),
    Food(id: 2, name: 'Chicken Pizza', category: 'Pizza', restaurant: 'Kigali Pizza House', emoji: '🍕', price: 6500, rating: 4.9, description: 'Oven-baked pizza with chicken, mozzarella and fresh herbs.'),
    Food(id: 3, name: 'Crispy Fried Chicken', category: 'Chicken', restaurant: 'KFC', emoji: '🍗', price: 4500, rating: 4.7, description: 'Golden crispy chicken, seasoned and served hot.'),
    Food(id: 4, name: 'French Fries', category: 'Fast Food', restaurant: 'Golden City', emoji: '🍟', price: 2000, rating: 4.5, description: 'Crispy golden fries with a pinch of seasoning.'),
    Food(id: 5, name: 'Fresh Fruit Juice', category: 'Drinks', restaurant: 'Jays Restaurant', emoji: '🥤', price: 1500, rating: 4.6, description: 'A refreshing chilled fruit juice.'),
    Food(id: 6, name: 'Chocolate Cake', category: 'Desserts', restaurant: 'Foso Foods', emoji: '🍰', price: 2500, rating: 4.8, description: 'Soft chocolate cake for a sweet treat.'),
    Food(id: 7, name: 'Cheese Burger', category: 'Burgers', restaurant: 'Golden City', emoji: '🍔', price: 4000, rating: 4.7, description: 'A grilled beef burger with melted cheese.'),
    Food(id: 8, name: 'Traditional Meal', category: 'Local Meals', restaurant: 'Jays Restaurant', emoji: '🍛', price: 5000, rating: 4.9, description: 'A hearty local meal prepared fresh.'),
  ];
}
