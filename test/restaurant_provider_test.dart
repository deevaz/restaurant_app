import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reastaurant_app/data/api/api_service.dart';
import 'package:reastaurant_app/data/model/restaurant_list_response.dart';
import 'package:reastaurant_app/provider/restaurant_provider.dart';
import 'package:reastaurant_app/utils/result_state.dart';

class MockApiService extends Mock implements ApiService {}

void main() {
  late RestaurantProvider restaurantProvider;
  late MockApiService mockApiService;

  setUp(() {
    mockApiService = MockApiService();
  });

  group('Restaurant Provider Unit Test', () {
    test('should return Loading state when provider is initialized', () {
      when(() => mockApiService.getList()).thenAnswer(
        (_) async => RestaurantListResponse(
          error: false,
          message: "success",
          count: 0,
          restaurants: [],
        ),
      );

      restaurantProvider = RestaurantProvider(apiService: mockApiService);

      expect(restaurantProvider.state, isA<ResultLoading>());
    });

    test('should return Success state when data fetch is successful', () async {
      final tResponse = RestaurantListResponse(
        error: false,
        message: "success",
        count: 1,
        restaurants: [],
      );
      when(() => mockApiService.getList()).thenAnswer((_) async => tResponse);

      restaurantProvider = RestaurantProvider(apiService: mockApiService);
      await Future.delayed(Duration.zero);

      expect(
        restaurantProvider.state,
        anyOf(isA<ResultSuccess>(), isA<ResultNoData>()),
      );
    });

    test('should return Error state when data fetch fails', () async {
      const errorMessage = 'Exception: Connection Failed';
      when(
        () => mockApiService.getList(),
      ).thenThrow(Exception('Connection Failed'));

      restaurantProvider = RestaurantProvider(apiService: mockApiService);
      await Future.delayed(Duration.zero);

      expect(restaurantProvider.state, isA<ResultError>());
      final state = restaurantProvider.state as ResultError;
      expect(state.message, equals(errorMessage));
    });
  });
}
