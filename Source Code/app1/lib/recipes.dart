import 'dart:convert';
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
class RecipeSearchScreen extends StatefulWidget {
  @override
  _RecipeSearchScreenState createState() => _RecipeSearchScreenState();
}

class _RecipeSearchScreenState extends State<RecipeSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _searchResults = [];
  Future<void> _searchRecipes(String query) async {
    // const String appId = '7b9709ca';
    // const String appKey = '56a4fea3e7b52a84e5f1f1df6fc822a1';

    final apiUrl = 'https://api.edamam.com/api/recipes/v2?type=public&q=$query&app_id=7b9709ca&app_key=7e0129f0430ff85fc362dede31008d5f';

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
   Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Scraps2Dishes')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Enter ingredients (e.g., chicken, rice)',
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                String query = _searchController.text;
                _searchRecipes(query);
              },
              child: Text('Search Recipes'),
            ),
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
                  // Build recipe cards here
                  return Card(
                    child: Column(
                      children: [
                        // Image.network(
                        //   image,
                        //   height: 150,
                        //   width: 150,
                        //   errorBuilder: (context, error, stackTrace) {
                        //     return Icon(Icons.error); // Display an error icon or placeholder
                        //   },
                        // ),
                        ListTile(
                          title: Text(label ?? 'Recipe Label not available'),
                          subtitle: Text(ingredientLines?.join(', ') ?? 'Ingredients not available'),
                        ),
                        ListTile(
                          title: Text('Source: $source'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FullRecipeScreen(
                                  recipeTitle: _searchResults[index]['recipe']['label'],
                                  ingredientLines: List<String>.from(_searchResults[index]['recipe']['ingredientLines']),
                                  // recipeInstructions: _searchResults[index]['recipe']['instructions'], // Adjust this based on your actual data structure
                                ),
                              ),
                            );
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