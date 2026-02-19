import 'package:flutter/material.dart';
import 'package:reastaurant_app/provider/bottom_nav_provider.dart';
import 'package:reastaurant_app/provider/theme_provider.dart';
import 'package:reastaurant_app/ui/home_page.dart';
import 'package:reastaurant_app/ui/restaurant_detail_page.dart';
import 'package:reastaurant_app/ui/restaurant_search_page.dart';
import 'common/styles.dart';
import 'package:provider/provider.dart';

import 'data/api/api_service.dart';
import 'provider/restaurant_provider.dart';
import 'provider/search_provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BottomNavProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(
          create: (_) => RestaurantProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(
          create: (_) => SearchProvider(apiService: ApiService()),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            theme: themeProvider.isDarkMode ? darkTheme : lightTheme,
            home: HomePage(),
            routes: {
              HomePage.routeName: (context) => const HomePage(),
              RestaurantSearchPage.routeName: (context) =>
                  const RestaurantSearchPage(),
              RestaurantDetailPage.routeName: (context) {
                final id = ModalRoute.of(context)?.settings.arguments as String;

                return RestaurantDetailPage(id: id);
              },
            },
          );
        },
      ),
    );
  }
}
