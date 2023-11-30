import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ImpactReport extends StatefulWidget {
  final List<String> ingredients;
  final String recipeTitle;

  ImpactReport({
    required this.recipeTitle,
    required this.ingredients,
  });

  @override
  _ImpactReportState createState() => _ImpactReportState();
}

class _ImpactReportState extends State<ImpactReport> {
  double totalCo2Score = 0;

  @override
  void initState() {
    super.initState();
    calculateTotalCo2Score();
  }

  Future<void> calculateTotalCo2Score() async {
    for (final ingredient in widget.ingredients) {
      final Map<String, String> params = {
        'action': 'process',
        'json': '1',
        'search_terms': ingredient,
      };

      const String apiUrl = 'https://world.openfoodfacts.org/cgi/search.pl';
      final Uri uri = Uri.parse(apiUrl).replace(queryParameters: params);

      final http.Response response = await http.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final products = data['products'];

        if (products != null && products is List && products.isNotEmpty) {
          final firstProduct = products[0];
          Map<String, dynamic> ecoscore = firstProduct['ecoscore_data'];
          Map<String, dynamic> agribalyse = ecoscore['agribalyse'];
          final productCo2Score = agribalyse['co2_total'];
          totalCo2Score += (productCo2Score ?? 0.0);
          print('Total c02 score : $totalCo2Score'); 
        }
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your Impact Report/Score",
          style: TextStyle(
              color: Color.fromARGB(255, 82, 181, 77),
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        leading:IconButton(
          icon: Icon(
            Icons.arrow_back, 
            color:Color.fromARGB(255, 82, 181, 77),
          ),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Recipe Title: ${widget.recipeTitle}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 82, 181, 77),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          'Total CO2 Score for the recipe:',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 82, 181, 77),
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          '${totalCo2Score.toStringAsFixed(2)} gCO2',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 82, 181, 77),
                          ),
                        ),
                        SizedBox(width: 10),
                        IconButton(
                          icon: Icon(
                            Icons.eco_sharp,
                            color: Color.fromARGB(255, 82, 181, 77),
                            size: 24,
                          ),
                          onPressed: () {
                            // Your action when the icon is pressed
                            // This can be empty or contain some logic
                          },
                          tooltip:
                            'The CO2 score, or carbon dioxide (CO2) score, is a measure of the carbon footprint associated with the recipe...',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
          ],
        ),

      ),
    );
  }
}
