import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reastaurant_app/provider/restaurant_provider.dart';
import 'package:reastaurant_app/ui/restaurant_detail_page.dart';
import 'package:reastaurant_app/ui/restaurant_search_page.dart';
import 'package:reastaurant_app/ui/widgets/restaurant_card.dart';
import 'package:reastaurant_app/utils/result_state.dart';

class RestaurantListPage extends StatelessWidget {
  const RestaurantListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.pushNamed(context, RestaurantSearchPage.routeName);
            },
          ),
        ],
      ),
      body: Consumer<RestaurantProvider>(
        builder: (context, provider, _) {
          return switch (provider.state) {
            InitialState() => const SizedBox.shrink(),
            ResultLoading() => const Center(
              child: CircularProgressIndicator(color: Colors.orange),
            ),
            ResultSuccess(data: final restaurants) => _buildList(
              context,
              restaurants,
            ),
            ResultNoData(message: final msg) => Center(child: Text(msg)),
            ResultError(message: final msg) => Center(child: Text(msg)),
          };
        },
      ),
    );
  }

  Widget _buildList(BuildContext context, List<dynamic> restaurants) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemCount: restaurants.length,
        itemBuilder: (context, index) => RestaurantCard(
          restaurant: restaurants[index],
          heroTag: restaurants[index].id,
          onTap: () => Navigator.pushNamed(
            context,
            RestaurantDetailPage.routeName,
            arguments: restaurants[index].id,
          ),
        ),
      ),
    );
  }
}
