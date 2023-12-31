import 'package:fitfutures/screens/trade_screen.dart';
import 'package:fitfutures/treasure.dart';
import 'package:fitfutures/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final _screens = const <Widget>[
    TreasureMap(),
    TradeScreen(),
    Column(
      children: [Text("Test")],
    )
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavBar(
            selectedIndex: _selectedIndex, onItemTapped: _onItemTapped),
        body: IndexedStack(
          index: _selectedIndex,
          children: _screens,
        ));
  }
}
