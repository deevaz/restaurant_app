import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/restaurant_list_response.dart';
import '../model/restaurant_detail_response.dart';
import '../model/restaurant_search_response.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  // 1. Mendapatkan Daftar Restoran
  Future<RestaurantListResponse> getList() async {
    final response = await http.get(Uri.parse("${_baseUrl}list"));
    if (response.statusCode == 200) {
      return RestaurantListResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal memuat daftar restoran');
    }
  }

  // 2. Mendapatkan Detail Restoran
  Future<RestaurantDetailResponse> getDetail(String id) async {
    final response = await http.get(Uri.parse("${_baseUrl}detail/$id"));
    if (response.statusCode == 200) {
      return RestaurantDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal memuat detail restoran');
    }
  }

  // 3. Mencari Restoran
  Future<RestaurantSearchResponse> search(String query) async {
    final response = await http.get(Uri.parse("${_baseUrl}search?q=$query"));
    if (response.statusCode == 200) {
      return RestaurantSearchResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal mencari restoran');
    }
  }

  // 4. Menambahkan Review (POST)
  Future<bool> postReview(String id, String name, String review) async {
    final response = await http.post(
      Uri.parse("${_baseUrl}review"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({"id": id, "name": name, "review": review}),
    );
    return response.statusCode == 201;
  }
}
