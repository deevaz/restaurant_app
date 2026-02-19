import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reastaurant_app/provider/bottom_nav_provider.dart';
import 'package:reastaurant_app/ui/restaurant_list_page.dart';
import 'package:reastaurant_app/ui/setting_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> _listWidget = [
    const RestaurantListPage(),
    const SettingPage(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          body: _listWidget[provider.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Theme.of(context).colorScheme.secondary,
            currentIndex: provider.currentIndex,
            onTap: (index) => provider.currentIndex = index,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.restaurant),
                label: 'Restoran',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Pengaturan',
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
