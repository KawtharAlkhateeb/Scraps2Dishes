import 'dart:convert';
import 'package:app1/HomePage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'fullRecipeScreen.dart'; 

// Define a function to launch the URL
void _launchURL(String url) async {
  final Uri uri = Uri.parse(url); // Convert the String URL to a Uri
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    throw 'Could not launch $url';
  }
}

class EdamamService {
  Future<List<dynamic>> searchRecipes(String apiUrl) async {
    final response = await http.get(
      Uri.parse(apiUrl),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['hits'];
    } else {
      throw Exception('Failed to load recipes');
    }
  }
}
// ignore: must_be_immutable
class RecipeSearchScreen extends StatefulWidget {
  String query; 
  String dietaryRestriction; 
  RecipeSearchScreen({
      required this.query, 
      required this.dietaryRestriction, 
  });
  @override
  // ignore: library_private_types_in_public_api
  _RecipeSearchScreenState createState() => _RecipeSearchScreenState();
}

class _RecipeSearchScreenState extends State<RecipeSearchScreen> {
  List<dynamic> _searchResults = [];
  Future<void> _searchRecipes() async {
    // const String appId = '7b9709ca';
    // const String appKey = '56a4fea3e7b52a84e5f1f1df6fc822a1';

    final apiUrl = 'https://api.edamam.com/api/recipes/v2?type=public&q=${widget.query}&app_id=7b9709ca&app_key=7e0129f0430ff85fc362dede31008d5f&health=vegan';

    final service = EdamamService();

    try {
      final recipes = await service.searchRecipes(apiUrl);
      setState(() {
        _searchResults = recipes;
      });
    } catch (e) {
      print('Error: $e');
    }
  }
  @override
    void initState() {
      super.initState();
      // Call the search method when the widget is initialized
      _searchRecipes();
    }
   Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipes', style: TextStyle(color: Color.fromARGB(255, 82, 181, 77), fontWeight: FontWeight.bold)),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        leading: CircleAvatar( 
          radius: 14, //radius of avatar 
          backgroundColor: Color.fromARGB(255, 82, 181, 77), //color 
          child: Padding( 
            padding: const EdgeInsets.all(2), // Border radius 
            child: ClipOval(child: Image.asset('images/Logo 1.png')), 
          ), 
        )
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox( height: 30, width: 30,), 
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  // Build recipe cards here
                  // _searchResults[index] contains recipe data
                  final recipe = _searchResults[index]['recipe']; 
                  final image = recipe['image'];
                  final label = recipe['label'];
                  final ingredientLines = recipe['ingredientLines'];
                  final source = recipe['source'];
                  final recipeUrl = recipe['url'];
                  final healthLabels = recipe['healthLabels']; 
                  final ingredients = recipe['ingredients'];
                  final oneIngredient = ingredients[1]['food']; 
                  print ("ingredient 1: $oneIngredient"); 

                  // Build recipe cards here
                  return Card(
                    child: Column(
                      children: [
                        Image.network(
                          Uri.encodeFull(image),
                          width: 300, // Adjust width as needed
                          height: 200, // Adjust height as needed
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.error); // Display an error icon or placeholder
                          },
                        ),
                        ListTile(
                          title: Text(label ?? 'Recipe Label not available'),
                          subtitle: Text(ingredientLines?.join(', ') ?? 'Ingredients not available'),
                        ),
                        ListTile(
                          title: Text('Source: $source'),
                        ),
                        ListTile(
                          title: Text('Health labels:'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: (healthLabels as List<dynamic>)
                                .map((label) => Text(label.toString()))
                                .toList(),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => FullRecipeScreen(recipeTitle: label, ingredientLines: [ingredientLines],                                ),
                            //   ),
                            // );
                          },
                          child: Text('View more'),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            _launchURL(recipeUrl);
                          },
                          child: Text('View Recipe on $source'),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            //
                          },
                          child: Text('Select Recipe'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}