// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoodItem _$FoodItemFromJson(Map<String, dynamic> json) => FoodItem(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      calories: json['calories'] as int,
      serving: json['serving'] == null
          ? null
          : Serving.fromJson(json['serving'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FoodItemToJson(FoodItem instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'calories': instance.calories,
      'serving': instance.serving,
    };
