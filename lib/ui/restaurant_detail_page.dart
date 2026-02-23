import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:reastaurant_app/data/api/api_service.dart';
import 'package:reastaurant_app/data/model/restaurant_detail_response.dart';
import 'package:reastaurant_app/provider/database_provider.dart';
import 'package:reastaurant_app/provider/restaurant_detail_provider.dart';
import 'package:reastaurant_app/ui/widgets/menu_card.dart';
import 'package:reastaurant_app/utils/result_state.dart';
import 'package:reastaurant_app/data/model/restaurant_list_response.dart'
    as model;

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';
  final String id;
  const RestaurantDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          RestaurantDetailProvider(apiService: ApiService(), restaurantId: id),
      child: Scaffold(
        body: Consumer<RestaurantDetailProvider>(
          builder: (context, provider, _) {
            return switch (provider.state) {
              ResultLoading() => const Center(
                child: CircularProgressIndicator(color: Colors.orange),
              ),
              ResultError(message: final msg) => Center(child: Text(msg)),
              ResultSuccess(data: final restaurant) => _buildDetailContent(
                context,
                restaurant,
                provider,
              ),
              _ => const SizedBox(),
            };
          },
        ),
      ),
    );
  }
}

Widget _buildDetailContent(
  BuildContext context,
  RestaurantDetailResponse data,
  RestaurantDetailProvider provider,
) {
  const String baseUrlImage =
      "https://restaurant-api.dicoding.dev/images/medium/";

  return Scaffold(
    appBar: AppBar(title: Text(data.restaurant.name)),
    body: Padding(
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          spacing: 5,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Hero(
                  tag: data.restaurant.id,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      '$baseUrlImage${data.restaurant.pictureId}',
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: double.infinity,
                          height: 200,
                          color: Colors.grey[300],
                          child: const Icon(
                            Icons.broken_image,
                            size: 50,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Positioned(
                  bottom: -20,
                  right: 16,
                  child: Consumer<DatabaseProvider>(
                    builder: (context, provider, child) {
                      return FutureBuilder<bool>(
                        future: provider.isFavorited(data.restaurant.id),
                        builder: (context, snapshot) {
                          var isBookmarked = snapshot.data ?? false;
                          return InkWell(
                            customBorder: const CircleBorder(),
                            onTap: () {
                              if (isBookmarked) {
                                provider.removeFav(data.restaurant.id);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Dihapus dari Favorit'),
                                    duration: Duration(milliseconds: 500),
                                  ),
                                );
                              } else {
                                final restaurant = model.Restaurant(
                                  id: data.restaurant.id,
                                  name: data.restaurant.name,
                                  description: data.restaurant.description,
                                  city: data.restaurant.city,
                                  pictureId: data.restaurant.pictureId,
                                  rating: data.restaurant.rating,
                                );
                                provider.addFav(restaurant);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Ditambahkan ke Favorit'),
                                    duration: Duration(milliseconds: 500),
                                  ),
                                );
                              }
                            },
                            child: Material(
                              color: Colors.transparent,
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 4,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.surfaceBright,
                                ),
                                child: Icon(
                                  isBookmarked
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: isBookmarked
                                      ? Colors.red
                                      : Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              spacing: 5,
              children: [
                Text(
                  data.restaurant.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Spacer(),
                RatingBarIndicator(
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  itemCount: 5,
                  rating: data.restaurant.rating,
                  itemSize: 20,
                ),
                Text(
                  '${data.restaurant.rating}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  size: 16,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                Text(
                  '${data.restaurant.address}, ${data.restaurant.city}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(height: 15),
            Text('Kategori', style: Theme.of(context).textTheme.titleSmall),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: data.restaurant.categories
                  .map((cat) => _CategoryCard(category: cat.name))
                  .toList(),
            ),
            const SizedBox(height: 15),
            Text('Deskripsi', style: Theme.of(context).textTheme.titleSmall),
            ReadMoreText(
              data.restaurant.description,
              trimMode: TrimMode.Line,
              trimLines: 3,
              colorClickableText: Theme.of(context).colorScheme.primary,
              trimCollapsedText: 'Baca selengkapnya',
              trimExpandedText: ' Tampilkan lebih sedikit',
              style: Theme.of(context).textTheme.bodyMedium,
              moreStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary,
              ),
              lessStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            const SizedBox(height: 15),
            Text('Makanan', style: Theme.of(context).textTheme.titleSmall),
            SizedBox(
              height: 150,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => MenuCard(
                  title: data.restaurant.menus.foods[index].name,
                  imageUrl:
                      'https://cdn.pixabay.com/photo/2014/08/26/09/33/indonesia-427784_640.jpg',
                ),
                separatorBuilder: (context, index) => const SizedBox(width: 10),
                itemCount: data.restaurant.menus.foods.length,
              ),
            ),
            const SizedBox(height: 15),
            Text('Minuman', style: Theme.of(context).textTheme.titleSmall),
            SizedBox(
              height: 150,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => MenuCard(
                  title: data.restaurant.menus.drinks[index].name,
                  imageUrl:
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTmzavLZN70HjyO_3xM2WDdJVqW9PZZJ06v8Q&s',
                ),
                separatorBuilder: (context, index) => const SizedBox(width: 10),
                itemCount: data.restaurant.menus.drinks.length,
              ),
            ),
            Text(
              'Ulasan Pelanggan',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 10),
            ...List.generate(
              data.restaurant.customerReviews.length,
              (index) => Card(
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.person)),
                  title: Text(
                    data.restaurant.customerReviews[index].name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.restaurant.customerReviews[index].review,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        data.restaurant.customerReviews[index].date,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        _showReviewModal(context, provider, data.restaurant.id);
      },
      backgroundColor: Theme.of(context).colorScheme.secondary,
      child: Icon(
        Icons.add_comment,
        color: Theme.of(context).colorScheme.onSecondary,
      ),
    ),
  );
}

class _CategoryCard extends StatelessWidget {
  final String category;
  const _CategoryCard({required this.category});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(category, style: Theme.of(context).textTheme.bodyMedium),
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      side: BorderSide.none,
    );
  }
}

void _showReviewModal(
  BuildContext context,
  RestaurantDetailProvider provider,
  String restaurantId,
) {
  final nameController = TextEditingController();
  final reviewController = TextEditingController();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (modalContext) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(modalContext).viewInsets.bottom,
          top: 20,
          left: 16,
          right: 16,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Beri Ulasan',
                style: Theme.of(modalContext).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama Anda',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: reviewController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Ulasan',
                  hintText: 'Ceritakan pengalamanmu...',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.notes),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final name = nameController.text.trim();
                    final review = reviewController.text.trim();

                    final scaffoldMessenger = ScaffoldMessenger.of(context);

                    if (name.isEmpty || review.isEmpty) {
                      scaffoldMessenger.hideCurrentSnackBar();
                      scaffoldMessenger.showSnackBar(
                        const SnackBar(
                          content: Text('Nama dan ulasan tidak boleh kosong!'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    Navigator.pop(modalContext);

                    final success = await provider.addReview(name, review);

                    if (success) {
                      scaffoldMessenger.showSnackBar(
                        const SnackBar(
                          content: Text('Ulasan berhasil ditambahkan!'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    } else {
                      scaffoldMessenger.showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Gagal mengirim ulasan. Cek koneksi internetmu.',
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: const Text('Kirim Ulasan'),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      );
    },
  );
}
