import 'package:flutter/material.dart';
import 'package:reastaurant_app/data/db/database_helper.dart';
import 'package:reastaurant_app/utils/result_state.dart';

import '../data/model/restaurant_list_response.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}) {
    _getFavorites();
  }

  ResultState _state = InitialState();
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<Restaurant> _favorites = [];
  List<Restaurant> get favorites => _favorites;

  void _getFavorites() async {
    _state = ResultLoading();
    notifyListeners();

    try {
      _favorites = await databaseHelper.getFavorites();

      if (_favorites.isNotEmpty) {
        _state = ResultSuccess(_favorites);
      } else {
        _state = ResultNoData('Belum ada Data Favorit');
        _message = 'Belum ada Data Favorit';
      }
    } catch (e) {
      _state = ResultError(e.toString());
      _message = 'Gagal Memuat Data';
    }
    notifyListeners();
  }

  void addFav(Restaurant restaurant) async {
    try {
      await databaseHelper.insertFavorite(restaurant);
      _getFavorites();
    } catch (e) {
      _state = ResultError(e.toString());
      _message = 'Gagal menambahkan data';
      notifyListeners();
    }
  }

  Future<bool> isFavorited(String id) async {
    final favRestaurant = await databaseHelper.getFavoriteById(id);

    return favRestaurant != null;
  }

  void removeFav(String id) async {
    try {
      await databaseHelper.removeFavorite(id);
      _getFavorites();
    } catch (e) {
      _state = ResultError(e.toString());
      _message = 'Gagal menghapus Favorit';
      notifyListeners();
    }
  }
}
