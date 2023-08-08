// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serving_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Serving _$ServingFromJson(Map<String, dynamic> json) => Serving(
      servingDetails: (json['servingDetails'] as List<dynamic>)
          .map((e) => ServingDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ServingToJson(Serving instance) => <String, dynamic>{
      'servingDetails': instance.servingDetails,
    };

ServingDetail _$ServingDetailFromJson(Map<String, dynamic> json) =>
    ServingDetail(
      calories: json['calories'] as String,
      carbohydrate: json['carbohydrate'] as String,
      cholesterol: json['cholesterol'] as String,
      fat: json['fat'] as String,
      fiber: json['fiber'] as String,
      measurementDescription: json['measurementDescription'] as String,
      numberOfUnits: json['numberOfUnits'] as String,
      protein: json['protein'] as String,
      saturatedFat: json['saturatedFat'] as String,
      servingDescription: json['servingDescription'] as String,
      servingId: json['servingId'] as String,
      servingUrl: json['servingUrl'] as String,
      sodium: json['sodium'] as String,
      sugar: json['sugar'] as String,
    );

Map<String, dynamic> _$ServingDetailToJson(ServingDetail instance) =>
    <String, dynamic>{
      'calories': instance.calories,
      'carbohydrate': instance.carbohydrate,
      'cholesterol': instance.cholesterol,
      'fat': instance.fat,
      'fiber': instance.fiber,
      'measurementDescription': instance.measurementDescription,
      'numberOfUnits': instance.numberOfUnits,
      'protein': instance.protein,
      'saturatedFat': instance.saturatedFat,
      'servingDescription': instance.servingDescription,
      'servingId': instance.servingId,
      'servingUrl': instance.servingUrl,
      'sodium': instance.sodium,
      'sugar': instance.sugar,
    };
