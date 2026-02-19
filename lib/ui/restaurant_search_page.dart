import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reastaurant_app/provider/search_provider.dart';
import 'package:reastaurant_app/ui/restaurant_detail_page.dart';
import 'package:reastaurant_app/ui/widgets/restaurant_card.dart';
import 'package:reastaurant_app/utils/result_state.dart';

class RestaurantSearchPage extends StatelessWidget {
  static const routeName = '/restaurant_search';

  const RestaurantSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cari Restoran')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextField(
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Cari nama restoran atau menu...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surface,
                ),
                onChanged: (query) {
                  context.read<SearchProvider>().fetchSearch(query);
                },
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Consumer<SearchProvider>(
                  builder: (context, provider, _) {
                    return switch (provider.state) {
                      InitialState() => Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search,
                              size: 64,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Mau makan apa hari ini?',
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ),

                      ResultLoading() => const Center(
                        child: CircularProgressIndicator(color: Colors.orange),
                      ),

                      ResultNoData(message: final msg) => Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.sentiment_dissatisfied,
                              size: 64,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 16),
                            Text(msg),
                          ],
                        ),
                      ),

                      ResultError(message: final msg) => Center(
                        child: Text(msg),
                      ),

                      ResultSuccess(data: final restaurants) =>
                        ListView.separated(
                          itemCount: restaurants.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 10),
                          itemBuilder: (context, index) {
                            final restaurant = restaurants[index];
                            return RestaurantCard(
                              restaurant: restaurant,
                              heroTag: 'search-${restaurant.id}',
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
                    };
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
