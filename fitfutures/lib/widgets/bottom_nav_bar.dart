import 'package:fitfutures/consts/app_colors.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar(
      {required this.selectedIndex, required this.onItemTapped, super.key});

  final int selectedIndex;
  final Function(int) onItemTapped;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: AppColors.primary1,
      unselectedItemColor: AppColors.secondary2,
      iconSize: 32,
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: 'Map',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.sync_alt),
          label: 'Trading',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: AppColors.secondary1,
      onTap: onItemTapped,
    );
  }
}
