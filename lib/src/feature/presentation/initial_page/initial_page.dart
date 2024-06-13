import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InitialPage extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const InitialPage({
    super.key,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_rounded),
            label: '달력',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_rounded),
            label: '메뉴',
          ),
        ],
        currentIndex: navigationShell.currentIndex,
        onTap: (value) => navigationShell.goBranch(value),
      ),
    );
  }
}
