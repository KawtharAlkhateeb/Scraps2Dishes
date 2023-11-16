import 'package:app1/AddRecipe.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class CookbookScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Community Cookbook", style: TextStyle(color: Color.fromARGB(255, 82, 181, 77), fontWeight: FontWeight.bold)),
        backgroundColor: Color.fromARGB(255, 255, 226, 107),
        leading: Image.asset('images/Logo 1.png', width: 250, height: 250,),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('recipes').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Loading indicator while waiting for data
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          // Use the snapshot data to build your UI
          final recipes = snapshot.data?.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return Recipe(
              title: data['recipeName'] ?? '',
              ingredients: data['ingredients'] ?? '',
              instructions: data['instructions'] ?? '',
              userName: data['userId'] ?? '',
            );
          }).toList();

          return ListView.builder(
            itemCount: recipes?.length ?? 0,
            itemBuilder: (context, index) {
              return RecipeCard(recipe: recipes?[index] ?? Recipe(
                title: 'Default Title',
                ingredients: 'Default Ingredients',
                instructions: 'Default Instructions',
                userName: 'Default User',
              ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the page to add a recipe
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MyApp(), // Adjust this based on your actual page for adding recipes
            ),
          );
        },
        backgroundColor: Color.fromARGB(255, 255, 226, 107), // Change the background color
        foregroundColor: Colors.white, // Change the icon (foreground) color
        elevation: 2.0, // Change the elevation (shadow)
        mini: false, // Set to true for a mini button
        child:Wrap(
          children: <Widget>[
            //Text("Add", style:TextStyle(fontSize:20)),
            Icon(Icons.add), 
          ],
        ),
      ),
    );
  }
}


class RecipeCard extends StatelessWidget {
  final Recipe recipe;

  RecipeCard({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image.network(
          //   recipe.imageUrl,
          //   width: double.infinity,
          //   height: 150.0,
          //   fit: BoxFit.cover,
          //   errorBuilder: (context, error, stackTrace) {
          //     return Icon(Icons.error); // Display an error icon or placeholder
          //   },
          // ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  recipe.title,
                  style: TextStyle(color: Color.fromARGB(255, 82, 181, 77),fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text('Ingredients: ${recipe.ingredients}', style: TextStyle(color: Color.fromARGB(255, 53, 55, 53), fontWeight: FontWeight.bold)),
                SizedBox(height: 8.0),
                Text('Instructions: ${recipe.instructions}', style: TextStyle(color: Color.fromARGB(255, 53, 55, 53), fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
                Text("Added by: ${recipe.userName}",style: TextStyle(color: Color.fromARGB(255, 53, 55, 53))), 
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Recipe {
  final String title;
  final String ingredients;
  final String instructions;
  final String userName; 

  Recipe({
    required this.title,
    required this.ingredients,
    required this.instructions,
    required this.userName, 
  });
}
