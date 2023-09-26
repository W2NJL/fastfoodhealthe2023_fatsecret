import 'package:shared_preferences/shared_preferences.dart';

extension DietConfigPreferences on DietConfig {
  static const _dailyCaloriesKey = 'dailyCalories';
  static const _mealCaloriesKey = 'mealCalories';
  static const _numMealsKey= 'mealsNum';

  // Save DietConfig to SharedPrefs
  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(_dailyCaloriesKey, dailyCalories);
    prefs.setInt(_mealCaloriesKey, mealCalories);
    prefs.setInt(_numMealsKey, numOfMeals);
  }

  // Load DietConfig from SharedPrefs
  static Future<DietConfig?> load() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(_dailyCaloriesKey) || !prefs.containsKey(_mealCaloriesKey) || !prefs.containsKey(_numMealsKey)) {
      return null;
    }
    final dailyCalories = prefs.getInt(_dailyCaloriesKey);
    final mealCalories = prefs.getInt(_mealCaloriesKey);
    final numMeals = prefs.getInt(_numMealsKey);
    return DietConfig(dailyCalories: dailyCalories!, mealCalories: mealCalories!, numOfMeals: numMeals!, sodium: 0,
    carbs: 0, fat: 0);
  }
}


class DietConfig {
  final int dailyCalories;
  final int mealCalories;
  final int numOfMeals; // Add this new parameter
  final int sodium; // added
  final int carbs;  // added
  final int fat;    // added

  DietConfig({required this.dailyCalories, required this.mealCalories, required this.numOfMeals, required this.sodium, required this.carbs, required this.fat, });

// You can add methods to save/load this configuration from local storage or server.
}