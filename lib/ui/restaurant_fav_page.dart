import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reastaurant_app/provider/database_provider.dart';
import 'package:reastaurant_app/ui/restaurant_detail_page.dart';
import 'package:reastaurant_app/ui/restaurant_search_page.dart';
import 'package:reastaurant_app/ui/widgets/restaurant_card.dart';
import 'package:reastaurant_app/utils/result_state.dart';

class RestaurantFavPage extends StatelessWidget {
  const RestaurantFavPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorit'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.pushNamed(context, RestaurantSearchPage.routeName);
            },
          ),
        ],
      ),
      body: Consumer<DatabaseProvider>(
        builder: (context, provider, child) {
          return switch (provider.state) {
            ResultLoading() => const Center(
              child: CircularProgressIndicator(color: Colors.orange),
            ),

            ResultNoData(message: final msg) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.favorite_border,
                    size: 64,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 16),
                  Text(msg),
                ],
              ),
            ),

            ResultError(message: final msg) => Center(child: Text(msg)),

            ResultSuccess(data: final favorites) => ListView.separated(
              padding: const EdgeInsets.all(10),
              itemCount: favorites.length,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final restaurant = favorites[index];
                return RestaurantCard(
                  restaurant: restaurant,
                  heroTag: restaurant.id,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RestaurantDetailPage.routeName,
                      arguments: restaurant.id,
                    );
                  },
                );
              },
            ),

            _ => const SizedBox(),
          };
        },
      ),
    );
  }
}
