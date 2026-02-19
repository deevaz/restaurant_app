import 'package:flutter/material.dart';
import '../../data/model/restaurant_list_response.dart';

class RestaurantCard extends StatelessWidget {
  final VoidCallback? onTap;
  final String? heroTag;

  final Restaurant restaurant;
  const RestaurantCard({
    super.key,
    this.onTap,
    this.heroTag,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    final String imageUrl =
        'https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}';

    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IntrinsicHeight(
            child: Row(
              spacing: 10,
              children: [
                Hero(
                  tag: heroTag ?? 'restaurant-image',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      imageUrl,
                      height: 70,
                      width: 110,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey[300],
                        child: const Icon(
                          Icons.broken_image,
                          size: 50,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 2,
                    children: [
                      Text(
                        restaurant.name,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 16,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          Text(
                            restaurant.city,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 16,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          Text(
                            restaurant.rating.toString(),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
