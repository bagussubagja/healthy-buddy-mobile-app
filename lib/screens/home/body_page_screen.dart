import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/screens/home/favorites/favorite_screen.dart';
import 'package:healthy_buddy_mobile_app/screens/home/home_page.dart';
import 'package:healthy_buddy_mobile_app/screens/home/settings/setting_screen.dart';
import 'package:healthy_buddy_mobile_app/screens/home/whislist_item/wishslist_screen.dart';
import 'package:healthy_buddy_mobile_app/shared/theme.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class BodyPageScreen extends StatefulWidget {
  BodyPageScreen({super.key});

  @override
  State<BodyPageScreen> createState() => _BodyPageScreenState();
}

class _BodyPageScreenState extends State<BodyPageScreen> {
  final List<Widget> _bodyScreenList = [
    HomePage(),
    FavoriteScreen(),
    WishlistScreen(),
    SettingScreen()
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [
          SalomonBottomBarItem(
              icon: _currentIndex == 0
                  ? const Icon(Icons.home)
                  : const Icon(Icons.home_outlined),
              title: const Text("Home"),
              selectedColor: greenColor,
              unselectedColor: blackColor),
          SalomonBottomBarItem(
              icon: _currentIndex == 1
                  ? const Icon(Icons.favorite)
                  : const Icon(Icons.favorite_border),
              title: const Text("Favorites"),
              selectedColor: greenColor,
              unselectedColor: blackColor),
          SalomonBottomBarItem(
              icon: _currentIndex == 2
                  ? const Icon(Icons.shopping_cart)
                  : const Icon(Icons.shopping_cart_outlined),
              title: const Text("Wishlist"),
              selectedColor: greenColor,
              unselectedColor: blackColor),
          SalomonBottomBarItem(
              icon: _currentIndex == 3
                  ? const Icon(Icons.settings)
                  : const Icon(Icons.settings_outlined),
              title: const Text("Settings"),
              selectedColor: greenColor,
              unselectedColor: blackColor),
        ],
      ),
      body: _bodyScreenList[_currentIndex],
    );
  }
}
