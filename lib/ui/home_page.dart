import 'package:flutter/material.dart';

import 'package:resto_app_new/common/styles.dart';
import 'package:resto_app_new/ui/convertion_page.dart';
import 'package:resto_app_new/ui/profile_page.dart';
import 'package:resto_app_new/ui/resto/restaurant_list_page.dart';
import 'package:resto_app_new/ui/time_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottonNavIndex = 0;

  final List<BottomNavigationBarItem> _bottomNavBarItems = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.restaurant),
      label: 'Restoran',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Profile',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.access_time),
      label: 'Waktu',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.swap_horiz_outlined),
      label: 'Pertukaran',
    ),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottonNavIndex = index;
    });
  }

  final List<Widget> _listWidget = [
    const RestaurantListPage(),
    const ProfilePage(),
    const TimeConversionPage(),
    const CurrencyConversionPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottonNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: secondaryColor,
        currentIndex: _bottonNavIndex,
        items: _bottomNavBarItems,
        onTap: _onBottomNavTapped,
      ),
    );
  }
}
