import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavigator extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const BottomNavigator({
    super.key,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_rounded),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_rounded),
          ),
        ],
        currentIndex: navigationShell.currentIndex,
        onTap: (value) => navigationShell.goBranch(value),
      ),
    );
  }
}
