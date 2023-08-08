import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../models/food_item.dart';
import '../models/serving_detail.dart';

class ApiService {
  static const String _baseUrl = 'https://platform.fatsecret.com/rest/server.api';
  static const String _tokenUrl = 'https://oauth.fatsecret.com/connect/token';

  static Future<List<FoodItem>> getFoodItemsByRestaurant(String restaurant) async {
    final token = await _getAccessToken();

    final uri = Uri.parse(_baseUrl);
    final response = await http.post(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: {
        'method': 'foods.search',
        'format': 'json',
        'search_expression': restaurant,
        'max_results': '50',   // add this line
        'page_number': '0',    // add this line
      },
    );
    print("Hello");
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      List<FoodItem> foodItems = [];
      var data = jsonDecode(response.body);
      try {
        if (data['foods'] != null && data['foods']['food'] != null) {
          var items = data['foods']['food'] as List<dynamic>;
          for (var item in items) {
            FoodItem foodItem = FoodItem.fromJson(item as Map<String, dynamic>);
            // Get details including servings for each food item
            //print(foodItem.id.toString());
            final servingDetails = await getFoodDetails(foodItem.id);
            foodItem.serving = servingDetails; // Set the serving property
            foodItems.add(foodItem);
          }
          // Sort by calories (desc)
          foodItems.sort((a, b) => b.calories.compareTo(a.calories));
        }
      } catch (e) {
        print('Error during deserialization: $e');
      }

      return foodItems;
    } else {
      throw Exception('Failed to load food items');
    }
  }

  static Future<Serving> getFoodDetails(int foodId) async {
    print(foodId.toString());
    final token = await _getAccessToken();

    final uri = Uri.parse(_baseUrl);
    final response = await http.post(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: {
        'method': 'food.get.v3',
        'format': 'json',
        'food_id': foodId.toString(),
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data.toString());
      if (data['food'] != null && data['food']['servings'] != null) {
        return Serving.fromJson(data['food']['servings']);
      } else {
        throw Exception('Failed to retrieve food details');
      }
    } else {
      throw Exception('Failed to get food details: ${response.statusCode}');
    }
  }



  static Future<String> _getAccessToken() async {
    final uri = Uri.parse(_tokenUrl);
    final response = await http.post(uri, body: {
      'grant_type': 'client_credentials',
      'client_id': 'ceb8d7db01f0430a96e4715047bdc58b',
      'client_secret': '8d622e6e66c04058b3e92cac68d3e208',
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['access_token'] as String;
    } else {
      throw Exception('Failed to obtain access token: ${response.statusCode}');
    }
  }
}
