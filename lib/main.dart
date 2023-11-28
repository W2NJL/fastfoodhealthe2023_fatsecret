import 'package:ffhe_fat_secret/screens/config_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as dotenv;
import './services/api_service.dart';
import 'dart:async';

import 'models/food_item.dart';

void main() async {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fast Food Health-E',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();
  Timer? _debounce;
  String _restaurant = '';

  // Add a state variable to store food items
  List<FoodItem> _foodItems = [];
  bool _isLoadingFoodItems = false;

  @override
  void initState() {
    super.initState();

    _controller.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onSearchChanged);
    _controller.dispose();
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    super.dispose();
  }

  _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(seconds: 2), () {
      setState(() {
        _restaurant = _controller.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('Fast Food Health-E'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ConfigScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(
                'https://static.wixstatic.com/media/7d5dd4_7314dd4e69d3447e8fcf6319495fdb80~mv2.png/v1/fill/w_150,h_150,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/FastFoodHealthELogo.png'),
          ),
          Text(
              'Our database, powered by FatSecret, features over 172,000 items from restaurants.  We help you find the nutritional values of meal options that are often difficult or impossible to locate!'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter restaurant',
                    ),
                    onSubmitted: (value) {
                      _searchAndDisplayRestaurants(value);
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    _searchAndDisplayRestaurants(_controller.text);
                  },
                ),
              ],
            ),
          ),



          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "This app is recommended for Adults 19-59 years of age\n"
                    "(Reference: Dietary Guidelines for Americans 2020-2025; "
                    "https://www.dietaryguidelines.gov/sites/default/files/2021-03/Dietary_Guidelines_for_Americans-2020-2025.pdf)\n\n"
                    "Mayo Clinic.org reference:\n"
                    "Generally, to lose 1 to 2 pounds a week (safe rate of weight loss), you need to shave 500 to 1,000 calories from your daily intake to achieve a calorie deficit. "
                    "This can be achieved by eating fewer calories or using up more through regular physical activity.\n\n"
                    "A caveat – every person’s caloric needs and deficits are different and depend on many factors, like exercise, genes, hormones and your metabolism.",
                style: TextStyle(fontSize: 11),
              ))
        ],
      ),
    );
  }

  void _searchAndDisplayRestaurants(String query) async {
    try {
      List<String> restaurants = await ApiService.getRestaurants(query);
      _showRestaurantList(restaurants);
    } catch (e) {
      // Handle error (e.g., show a toast or a dialog with the error message)
    }
  }

  void _showRestaurantList(List<String> restaurants) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select a Restaurant'),
          content: SingleChildScrollView(
            child: ListBody(
              children: restaurants.map((restaurant) =>
                  ListTile(
                    title: Text(restaurant),
                    onTap: () {
                      Navigator.of(context).pop();
                      _showFoodItems(restaurant);
                    },
                  )).toList(),
            ),
          ),
        );
      },
    );
  }

  void _showFoodItems(String restaurant) async {
    // Show a loading dialog
    _showLoadingDialog();

    try {
      var foodItems = await ApiService.getFoodItemsByRestaurant(restaurant, calorieLimit: 2000);
      // Close the loading dialog
      Navigator.of(context).pop();

      setState(() {
        _foodItems = foodItems;
      });
      _showFoodItemsDialog();
    } catch (e) {
      // Close the loading dialog
      Navigator.of(context).pop();

      // Handle error
    }
  }

  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // User must not close the dialog manually
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text("Loading..."),
            ],
          ),
        );
      },
    );
  }


  void _showFoodItemsDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Food Items'),
          content: _isLoadingFoodItems
              ? CircularProgressIndicator()
              : SingleChildScrollView(
            child: ListBody(
              children: _foodItems.map<Widget>((item) {
                // For each food item, return a widget that displays its details
                return Card(
                  child: ListTile(
                    title: Text(item.name),
                    // Assuming 'item' has a 'name' property
                    subtitle: Text('Calories: ${item.calories}'),
                    // Replace with actual property names
                    onTap: () {

                final serving = item.serving!.servingDetails!.first; // Assuming there's at least one serving detail
                showDialog(
                context: context,
                builder: (context) {
                return AlertDialog(
                title: Text('Serving Details', style: TextStyle(fontWeight: FontWeight.bold)),
                content: SingleChildScrollView(
                child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text('Nutrition Facts', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                SizedBox(height: 6),
                Text('Serving Size: ${serving.measurementDescription}', style: TextStyle(fontWeight: FontWeight.bold)),
                Divider(thickness: 2),
                _nutritionLabelLine('Amount Per Serving'),
                SizedBox(height: 4),
                _nutritionLabelLine('Calories', serving.calories, true, false),
                Divider(thickness: 1),
                _nutritionLabelLine('Total Fat ${serving.fat}g', '', true),
                _nutritionLabelLine('Saturated Fat ${serving.saturatedFat}g'),
                _nutritionLabelLine('Cholesterol ${serving.cholesterol}mg'),
                _nutritionLabelLine('Sodium ${serving.sodium}mg'),
                _nutritionLabelLine('Total Carbohydrate ${serving.carbohydrate}g', '', true),
                _nutritionLabelLine('Dietary Fiber ${serving.fiber}g'),
                _nutritionLabelLine('Total Sugars ${serving.sugar}g'),
                _nutritionLabelLine('Protein ${serving.protein}g', '', true),
                Divider(thickness: 2),
                Text('Serving ID: ${serving.servingId}'),
                Text('Serving URL: ${serving.servingUrl}'),
                // Add any additional attributes here
                ],
                ),
                ),
                ));
                },
                );
                }));
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}


  Widget _nutritionLabelLine(String leftText, [String rightText = '', bool isBold = false, bool isIndented = true]) {
  return Padding(
    padding: EdgeInsets.only(left: isIndented ? 10 : 0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          leftText,
          style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
        ),
        if (rightText.isNotEmpty)
          Text(
            rightText,
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
      ],
    ),
  );
}

