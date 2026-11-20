import 'package:flutter/material.dart';
import 'data/food_data.dart';
import 'models/food.dart';
import 'pages/account_page.dart';
import 'pages/cart_page.dart';
import 'pages/categories_page.dart';
import 'pages/home_page.dart';
import 'pages/search_page.dart';
import 'theme/app_theme.dart';

void main() => runApp(const LocalBitesApp());

class LocalBitesApp extends StatelessWidget {
  const LocalBitesApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'food APP',
    debugShowCheckedModeBanner: false,
    theme: AppTheme.light,
    home: const AppShell(),
  );
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int tab = 0;
  String category = 'All';
  String address = 'Choose delivery location';
  final Map<int, int> cart = {};
  final Set<int> favorites = {};

  int get cartCount => cart.values.fold(0, (a, b) => a + b);
  int get subtotal => FoodData.items.fold(
    0, (sum, food) => sum + food.price * (cart[food.id] ?? 0),
  );

  void add(Food food) {
    setState(() => cart[food.id] = (cart[food.id] ?? 0) + 1);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${food.name} added to cart'), duration: const Duration(seconds: 1)),
    );
  }

  void quantity(Food food, int delta) {
    setState(() {
      final next = (cart[food.id] ?? 0) + delta;
      if (next <= 0) {
        cart.remove(food.id);
      } else {
        cart[food.id] = next;
      }
    });
  }

  void favorite(Food food) {
    setState(() {
      if (!favorites.add(food.id)) favorites.remove(food.id);
    });
  }

  void setAddress() {
    final controller = TextEditingController(
      text: address == 'Choose delivery location' ? '' : address,
    );
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delivery location'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Street, neighborhood or area',
            prefixIcon: Icon(Icons.location_on_outlined),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('Cancel')),
          FilledButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                setState(() => address = controller.text.trim());
              }
              Navigator.pop(dialogContext);
            },
            child: const Text('Save address'),
          ),
        ],
      ),
    );
  }

  void checkout() {
    if (cart.isEmpty) return;
    if (address == 'Choose delivery location') {
      setAddress();
      return;
    }
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Review your order'),
        content: Text(
          'Delivery to: $address\n'
          'Subtotal: $subtotal RWF\n'
          'Delivery: 1,000 RWF\n'
          'Total: ${subtotal + 1000} RWF\n\n'
          'This is a demo checkout. No payment will be collected.',
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('Cancel')),
          FilledButton(
            onPressed: () {
              setState(() => cart.clear());
              Navigator.pop(dialogContext);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Demo order placed successfully')),
              );
            },
            child: const Text('Place demo order'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(
        address: address,
        cartCount: cartCount,
        favorites: favorites,
        onAddress: setAddress,
        onCart: () => setState(() => tab = 3),
        onCategory: (value) => setState(() { category = value; tab = 1; }),
        onAdd: add,
        onFavorite: favorite,
      ),
      CategoriesPage(
        selected: category,
        onSelected: (value) => setState(() => category = value),
        favorites: favorites,
        onAdd: add,
        onFavorite: favorite,
      ),
      SearchPage(favorites: favorites, onAdd: add, onFavorite: favorite),
      CartPage(
        cart: cart,
        subtotal: subtotal,
        onQuantity: quantity,
        onCheckout: checkout,
        onBrowse: () => setState(() => tab = 1),
      ),
      AccountPage(address: address, favoritesCount: favorites.length, onAddress: setAddress),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final desktop = constraints.maxWidth >= 850;
        return Scaffold(
          body: SafeArea(
            child: Row(
              children: [
                if (desktop)
                  NavigationRail(
                    selectedIndex: tab,
                    onDestinationSelected: (value) => setState(() => tab = value),
                    labelType: NavigationRailLabelType.all,
                    backgroundColor: Colors.white,
                    destinations: const [
                      NavigationRailDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: Text('Home')),
                      NavigationRailDestination(icon: Icon(Icons.grid_view_outlined), selectedIcon: Icon(Icons.grid_view), label: Text('Categories')),
                      NavigationRailDestination(icon: Icon(Icons.search), label: Text('Search')),
                      NavigationRailDestination(icon: Icon(Icons.shopping_bag_outlined), selectedIcon: Icon(Icons.shopping_bag), label: Text('Cart')),
                      NavigationRailDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: Text('Account')),
                    ],
                  ),
                Expanded(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1180),
                      child: IndexedStack(index: tab, children: pages),
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: desktop ? null : NavigationBar(
            selectedIndex: tab,
            onDestinationSelected: (value) => setState(() => tab = value),
            destinations: [
              const NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
              const NavigationDestination(icon: Icon(Icons.grid_view_outlined), selectedIcon: Icon(Icons.grid_view), label: 'Categories'),
              const NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
              NavigationDestination(
                icon: Badge(isLabelVisible: cartCount > 0, label: Text('$cartCount'), child: const Icon(Icons.shopping_bag_outlined)),
                selectedIcon: const Icon(Icons.shopping_bag),
                label: 'Cart',
              ),
              const NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Account'),
            ],
          ),
        );
      },
    );
  }
}
