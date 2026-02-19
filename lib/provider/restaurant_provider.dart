import 'package:flutter/material.dart';
import '../data/api/api_service.dart';
import '../utils/result_state.dart';

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({required this.apiService}) {
    _fetchAllRestaurant();
  }

  ResultState _state = ResultLoading();
  ResultState get state => _state;

  Future<void> _fetchAllRestaurant() async {
    try {
      _state = ResultLoading();
      notifyListeners();

      final result = await apiService.getList();
      if (result.restaurants.isEmpty) {
        _state = ResultNoData('Daftar restoran kosong');
      } else {
        _state = ResultSuccess(result.restaurants);
      }
    } catch (e) {
      _state = ResultError('Terjadi kesalahan koneksi');
    } finally {
      notifyListeners();
    }
  }
}
