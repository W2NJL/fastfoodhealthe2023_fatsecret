import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as dotenv;
import './services/api_service.dart';
import 'dart:async';

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
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network('https://static.wixstatic.com/media/7d5dd4_7314dd4e69d3447e8fcf6319495fdb80~mv2.png/v1/fill/w_150,h_150,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/FastFoodHealthELogo.png'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter restaurant',
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: _restaurant.isNotEmpty ? ApiService.getFoodItemsByRestaurant(_restaurant) : null,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final item = snapshot.data![index];
                      final servingDetails = item.serving?.servingDetails!;
                      return Card(
                        margin: EdgeInsets.all(10.0),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                item.name,
                                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10.0),
                              Text('Calories: ${item.calories} kcal'),
                              Divider(),
                              Text('Description'),
                              SizedBox(height: 5.0),
                              Text(
                                item.description,
                                style: TextStyle(fontSize: 16.0),
                              ),
                          TextButton(
                            onPressed: () {
                              final serving = item.serving!.servingDetails!.first; // Assuming there's at least one serving detail
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Serving Details'),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: [
                                          Text('Calories: ${serving.calories}'),
                                          Text('Carbohydrates: ${serving.carbohydrate}'),
                                          Text('Cholesterol: ${serving.cholesterol}'),
                                          Text('Fat: ${serving.fat}'),
                                          Text('Fiber: ${serving.fiber}'),
                                          Text('Measurement Description: ${serving.measurementDescription}'),
                                          Text('Number of Units: ${serving.numberOfUnits}'),
                                          Text('Protein: ${serving.protein}'),
                                          Text('Saturated Fat: ${serving.saturatedFat}'),
                                          Text('Serving Description: ${serving.servingDescription}'),
                                          Text('Serving ID: ${serving.servingId}'),
                                          Text('Serving URL: ${serving.servingUrl}'),
                                          Text('Sodium: ${serving.sodium}'),
                                          Text('Sugar: ${serving.sugar}'),
                                       
                                          // Add any additional attributes here
                                        ],
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
                            },
                            child: Text('Show Details'),
                          ),

                        ]),
                        ),
                      );
                    },
                  );
                } else {
                  return Text("Please enter a restaurant name.");
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
