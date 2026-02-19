import 'package:flutter/material.dart';
import '../data/api/api_service.dart';
import '../utils/result_state.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String restaurantId;

  RestaurantDetailProvider({
    required this.apiService,
    required this.restaurantId,
  }) {
    fetchRestaurantDetail();
  }

  ResultState _state = ResultLoading();
  ResultState get state => _state;

  Future<void> fetchRestaurantDetail() async {
    try {
      _state = ResultLoading();
      notifyListeners();

      final response = await apiService.getDetail(restaurantId);
      _state = ResultSuccess(response);
    } catch (e) {
      _state = ResultError('Gagal memuat detail restoran.');
    } finally {
      notifyListeners();
    }
  }

  Future<bool> addReview(String name, String review) async {
    try {
      final success = await apiService.postReview(restaurantId, name, review);
      if (success) {
        await fetchRestaurantDetail();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
