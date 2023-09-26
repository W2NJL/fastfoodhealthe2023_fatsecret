import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/diet_config.dart';

class ConfigScreen extends StatefulWidget {
  @override
  _ConfigScreenState createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  DietConfig? selectedDiet;
  int selectedNumOfMeals = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Diet Configuration')),
      body: Padding( // Add overall padding
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align items to start
            children: [

              // Meal selection header
              Text(
                "Number of Meals",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10), // A little space between header and dropdown
              DropdownButton<int>(
                value: selectedNumOfMeals,
                onChanged: (int? newValue) {
                  if (newValue! <= selectedDiet!.numOfMeals) {
                    setState(() { selectedNumOfMeals = newValue; });
                  } else {
                    print('Nah');
                  }
                },
                items: [1, 2, 3].map<DropdownMenuItem<int>>((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text('$value meals/day'),
                  );
                }).toList(),
              ),
              Divider(thickness: 2), // Separate sections with a divider
              SizedBox(height: 10),

              // Calorie plan header
              Text(
                "Choose your Diet",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),

              ..._buildDietOptions(), // Extract diet options to a new function for cleanliness

              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildDietOptions() {
    return [
      // Your diet options go here, example:
      ListTile(
        title: const Text('2000 Calorie Diet'),
        leading: Radio(
          value: DietConfig(dailyCalories: 2000, mealCalories: 660, numOfMeals: 3, sodium: 9999, fat: 9999, carbs: 9999),
          groupValue: selectedDiet,
          onChanged: (DietConfig? value) {
            setState(() { selectedDiet = value; });
          },
        ),
        trailing: IconButton(
          icon: Icon(Icons.info_outline),
          onPressed: () => _showDietPlanInfo("2000 Calorie Diet"),
        ),
      ),
      ListTile(
        title: const Text('1500 Calorie Diet'),
        leading: Radio(
          value: DietConfig(dailyCalories: 2000, mealCalories: 660, numOfMeals: 3, sodium: 9999, fat: 9999, carbs: 9999),
          groupValue: selectedDiet,
          onChanged: (DietConfig? value) {
            setState(() { selectedDiet = value; });
          },
        ),
        trailing: IconButton(
          icon: Icon(Icons.info_outline),
          onPressed: () => _showDietPlanInfo("1500 Calorie Diet"),
        ),
      ),
      ListTile(
        title: const Text('1200 Calorie Diet'),
        leading: Radio(
          value: DietConfig(dailyCalories: 2000, mealCalories: 660, numOfMeals: 3, sodium: 9999, fat: 9999, carbs: 9999),
          groupValue: selectedDiet,
          onChanged: (DietConfig? value) {
            setState(() { selectedDiet = value; });
          },
        ),
        trailing: IconButton(
          icon: Icon(Icons.info_outline),
          onPressed: () => _showDietPlanInfo("1200 Calorie Diet"),
        ),
      ),
      ListTile(
        title: const Text('Lower Sodium Diet'),
        leading: Radio(
          value: DietConfig(dailyCalories: 2000, mealCalories: 660, numOfMeals: 3, sodium: 2300, carbs: 9999, fat: 9999),
          groupValue: selectedDiet,
          onChanged: (DietConfig? value) {
            setState(() { selectedDiet = value; });
          },
        ),
        trailing: IconButton(
          icon: Icon(Icons.info_outline),
          onPressed: () => _showDietPlanInfo("Lower Sodium Diet"),
        ),
      ),
      // Lowest Sodium Diet Option
      ListTile(
        title: const Text('Lowest Sodium Diet'),
        leading: Radio(
          value: DietConfig(dailyCalories: 2000, mealCalories: 500, numOfMeals: 3, sodium: 1500, carbs: 0, fat: 0),
          groupValue: selectedDiet,
          onChanged: (DietConfig? value) {
            setState(() { selectedDiet = value; });
          },
        ),
        trailing: IconButton(
          icon: Icon(Icons.info_outline),
          onPressed: () => _showDietPlanInfo("Lowest Sodium Diet"),
        ),
      ),

      // Very Low Carbohydrate Diet Options
      ListTile(
        title: const Text('2000 Calorie Very Low Carbohydrate Diet'),
        leading: Radio(
          value: DietConfig(dailyCalories: 2000, mealCalories: 660, numOfMeals: 3, sodium: 0, carbs: 50, fat: 0),
          groupValue: selectedDiet,
          onChanged: (DietConfig? value) {
            setState(() { selectedDiet = value; });
          },
        ),
        trailing: IconButton(
          icon: Icon(Icons.info_outline),
          onPressed: () => _showDietPlanInfo("2000 Calorie Very Low Carbohydrate Diet"),
        ),
      ),
      // Very Low Carbohydrate Diet Options
      ListTile(
      title: const Text('1500 Calorie Very Low Carbohydrate Diet'),
      leading: Radio(
      value: DietConfig(dailyCalories: 1500, mealCalories: 660, numOfMeals: 3, sodium: 0, carbs: 50, fat: 0),
      groupValue: selectedDiet,
      onChanged: (DietConfig? value) {
      setState(() { selectedDiet = value; });
      },
      ),
      trailing: IconButton(
      icon: Icon(Icons.info_outline),
      onPressed: () => _showDietPlanInfo("1500 Calorie Very Low Carbohydrate Diet"),
    ),
    ),
      ListTile(
        title: const Text('1200 Calorie Very Low Carbohydrate Diet'),
        leading: Radio(
          value: DietConfig(dailyCalories: 1200, mealCalories: 660, numOfMeals: 3, sodium: 0, carbs: 50, fat: 0),
          groupValue: selectedDiet,
          onChanged: (DietConfig? value) {
            setState(() { selectedDiet = value; });
          },
        ),
        trailing: IconButton(
          icon: Icon(Icons.info_outline),
          onPressed: () => _showDietPlanInfo("1200 Calorie Very Low Carbohydrate Diet"),
        ),
      ),

      // ... Similarly add other Very Low Carbohydrate and Low Carbohydrate Diet Options

      // Low Fat Diet Options
      ListTile(
        title: const Text('2000 Calorie Low Fat Diet'),
        leading: Radio(
          value: DietConfig(dailyCalories: 2000, mealCalories: 660, numOfMeals: 3, sodium: 0, carbs: 0, fat: 67),
          groupValue: selectedDiet,
          onChanged: (DietConfig? value) {
            setState(() { selectedDiet = value; });
          },
        ),
        trailing: IconButton(
          icon: Icon(Icons.info_outline),
          onPressed: () => _showDietPlanInfo("1500 Calorie Low Fat Diet"),
        ),
      ),
      ListTile(
        title: const Text('1500 Calorie Low Fat Diet'),
        leading: Radio(
          value: DietConfig(dailyCalories: 1500, mealCalories: 660, numOfMeals: 3, sodium: 0, carbs: 0, fat: 67),
          groupValue: selectedDiet,
          onChanged: (DietConfig? value) {
            setState(() { selectedDiet = value; });
          },
        ),
        trailing: IconButton(
          icon: Icon(Icons.info_outline),
          onPressed: () => _showDietPlanInfo("1500 Calorie Low Fat Diet"),
        ),
      ),
      ListTile(
        title: const Text('1200 Calorie Low Fat Diet'),
        leading: Radio(
          value: DietConfig(dailyCalories: 1200, mealCalories: 660, numOfMeals: 3, sodium: 0, carbs: 0, fat: 67),
          groupValue: selectedDiet,
          onChanged: (DietConfig? value) {
            setState(() { selectedDiet = value; });
          },
        ),
        trailing: IconButton(
          icon: Icon(Icons.info_outline),
          onPressed: () => _showDietPlanInfo("1200 Calorie Low Fat Diet"),
        ),
      ),
      // Add other diet options similarly
    ];
  }


  void _showDietPlanInfo(String plan) {
    String info = "";
    switch (plan) {
      case "2000 Calorie Diet":
        info = "This 2000 calorie diet plan is defined as 3 meals per day each meal no more than 660 calories; There are no other nutrition restrictions other than calories."; // description here
        break;
      case "1200 Calorie Diet":
        info = "This 1200 calorie diet plan is defined as 3 meals per day each meal no more than 400 calories ; There are no other nutrient restrictions other than calories. "; // description here
        break;
      case "1500 Calorie Diet":
        info = "This 1500 calorie diet plan is defined as 3 meals per day each meal no more than 500 calories. There are no other nutrient restrictions other than calories."; // description here
        break;
    // Add other cases as needed
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("$plan Info"),
        content: Text(info),
        actions: [
          TextButton(
            child: Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

}
