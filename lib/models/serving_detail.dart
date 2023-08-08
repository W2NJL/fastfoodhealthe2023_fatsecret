import 'package:json_annotation/json_annotation.dart';

part 'serving_detail.g.dart';


@JsonSerializable()
class Serving {
  final List<ServingDetail> servingDetails;

  Serving({required this.servingDetails});

  factory Serving.fromJson(Map<String, dynamic> json) {
    var servingListJson = json['serving'] as List;
    var servingList = servingListJson.map((item) => ServingDetail.fromJson(item)).toList();

    return Serving(
      servingDetails: servingList,
    );
  }
}


@JsonSerializable()
class ServingDetail {
  final String calories;
  final String carbohydrate;
  final String cholesterol; // Change to double
  final String fat;
  final String fiber;
  final String measurementDescription;
  final String numberOfUnits;
  final String protein;
  final String saturatedFat;
  final String servingDescription;
  final String servingId; // Change to double
  final String servingUrl;
  final String sodium; // Change to double
  final String sugar;
  // Change to String

  ServingDetail({
    required this.calories,
    required this.carbohydrate,
    required this.cholesterol,
    required this.fat,
    required this.fiber,
    required this.measurementDescription,
    required this.numberOfUnits,
    required this.protein,
    required this.saturatedFat,
    required this.servingDescription,
    required this.servingId,
    required this.servingUrl,
    required this.sodium,
    required this.sugar,

  });

  factory ServingDetail.fromJson(Map<String, dynamic> json) {
    return ServingDetail(
      calories: json['calories'],
      carbohydrate: (json['carbohydrate'] as String).trim(),
      cholesterol: (json['cholesterol'] as String).trim(),
      fat: (json['fat'] as String).trim(),
      fiber: (json['fiber'] as String),
      measurementDescription: (json['measurement_description'] as String).trim(),
      numberOfUnits: (json['number_of_units'] as String).trim(),
      protein: (json['protein'] as String).trim(),
      saturatedFat: (json['saturated_fat'] as String).trim(),
      servingDescription: (json['serving_description'] as String).trim(),
      servingId: (json['serving_id'] as String),
      servingUrl: (json['serving_url'] as String).trim(),
      sodium: (json['sodium'] as String),
      sugar: (json['sugar'] as String).trim(),

    );
  }

}
