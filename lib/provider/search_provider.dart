import 'dart:async';

import 'package:flutter/material.dart';
import '../data/api/api_service.dart';
import '../utils/result_state.dart';

class SearchProvider extends ChangeNotifier {
  final ApiService apiService;

  SearchProvider({required this.apiService});

  ResultState _state = InitialState();
  ResultState get state => _state;

  Timer? _debounceTimer;

  void onSearchInput(String query) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      _fetchSearch(query);
    });
  }

  Future<void> _fetchSearch(String query) async {
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

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }
}
