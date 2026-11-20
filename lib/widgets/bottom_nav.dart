
import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  const BottomNav({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    const orange = Color(0xFFF47721);

    final items = [
      (Icons.home_rounded, 'Home'),
      (Icons.grid_view_rounded, 'Categories'),
      (Icons.search_rounded, 'Search'),
      (Icons.storefront_outlined, 'Stores'),
      (Icons.account_circle_outlined, 'Account'),
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: NavigationBar(
        backgroundColor: Colors.white,
        elevation: 0,
        height: 65,
        selectedIndex: selectedIndex,
        indicatorColor: Colors.transparent,
        onDestinationSelected: onItemSelected,
        destinations: items.map((item) {
          final index = items.indexOf(item);
          final selected = selectedIndex == index;

          return NavigationDestination(
            icon: Icon(
              item.$1,
              color: selected ? orange : Colors.grey,
              size: 23,
            ),
            label: item.$2,
          );
        }).toList(),
      ),
    );
  }
}
