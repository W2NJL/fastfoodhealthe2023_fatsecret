import 'package:ffhe_fat_secret/models/serving_detail.dart';
import 'package:json_annotation/json_annotation.dart';

part 'food_item.g.dart';

@JsonSerializable()
class FoodItem {
  final int id;
  final String name;
  final String description;
  final int calories; // Added new field



  Serving? serving; // Nullable


  FoodItem({
    required this.id,
    required this.name,
    required this.description,
    required this.calories,
    required this.serving,


  });

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    final id = int.parse(json['food_id'] as String);

    final name = json['food_name'] as String;
    final description = json['food_description'] as String;

    final caloriePart = description.split('|')[0];
    final calorieString = caloriePart.split(':')[1].replaceAll('kcal', '').trim();
    final calories = int.tryParse(calorieString) ?? 0; // Parse calories and handle exceptions
    final servingsJson = json['servings'];
    final serving = servingsJson != null ? Serving.fromJson(servingsJson) : null;

    return FoodItem(
      id: id,
      name: name,
      description: description,
      calories: calories, serving: serving,


      
    );
  }
}
