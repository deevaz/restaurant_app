import 'package:flutter_test/flutter_test.dart';
import 'package:reastaurant_app/data/model/restaurant_list_response.dart';

void main() {
  test('should parse json to restaurant object correctly', () {
    const json = {
      "id": "s1k7459y7ndkfw1e867",
      "name": "Kafe Kita",
      "description": "Quisque rutrum a erat.",
      "pictureId": "25",
      "city": "Gorontalo",
      "rating": 4.2,
    };

    final result = Restaurant.fromJson(json);

    expect(result.id, equals("s1k7459y7ndkfw1e867"));
    expect(result.name, equals("Kafe Kita"));
    expect(result.rating, equals(4.2));
  });
}
