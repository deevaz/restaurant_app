import 'package:flutter/material.dart';
import '../data/api/api_service.dart';
import '../utils/result_state.dart';

class SearchProvider extends ChangeNotifier {
  final ApiService apiService;

  SearchProvider({required this.apiService});

  ResultState _state = InitialState();
  ResultState get state => _state;

  Future<void> fetchSearch(String query) async {
    if (query.isEmpty) {
      _state = InitialState();
      notifyListeners();
      return;
    }

    try {
      _state = ResultLoading();
      notifyListeners();

      final response = await apiService.search(query);
      if (response.restaurants.isEmpty) {
        _state = ResultNoData('Restoran yang kamu cari tidak ditemukan.');
      } else {
        _state = ResultSuccess(response.restaurants);
      }
    } catch (e) {
      _state = ResultError('Terjadi kesalahan saat mencari.');
    } finally {
      notifyListeners();
    }
  }
}
