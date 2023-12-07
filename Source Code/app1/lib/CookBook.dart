import 'package:app1/AddRecipe.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class CookbookScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Community Cookbook", style: GoogleFonts.lato(
          textStyle: TextStyle(
            color: Color.fromARGB(255, 82, 181, 77)),
            fontWeight: FontWeight.bold, 
          )
        ), 
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
              category: data['category']
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
                category: 'Dafault', 
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
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  recipe.title,
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(color: Color.fromARGB(255, 82, 181, 77)),
                    fontWeight: FontWeight.bold, 
                    fontSize: 20, 
                  ), 
                ),
                SizedBox(height: 8.0),
                Text(
                  'Ingredients:',
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      color: Color.fromARGB(255, 53, 55, 53), fontWeight: FontWeight.bold),
                  ), 
                ),
                SizedBox(height: 8.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: recipe.ingredients
                      .split(',') // Assuming ingredients are separated by commas
                      .map((ingredient) => Text(
                            '• $ingredient',
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                color: Color.fromARGB(255, 53, 55, 53)),
                            ), 
                          ))
                      .toList(),
                ),
                SizedBox(height: 20),
                Text(
                  'Instructions:',
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      color: Color.fromARGB(255, 53, 55, 53), fontWeight: FontWeight.bold),
                  ), 
                ),
                SizedBox(height: 8.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: recipe.instructions
                      .split(',') // Assuming ingredients are separated by commas
                      .map((instruction) => Text(
                            '• $instruction',
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(color: Color.fromARGB(255, 53, 55, 53)),
                            ), 
                          ))
                      .toList(),
                ),
                SizedBox(height: 10),
                Text("Added by: ${recipe.userName}",style:GoogleFonts.lato( 
                  textStyle: TextStyle(
                    color: Color.fromARGB(255, 53, 55, 53), 
                  )
                ),
                ),  
                SizedBox(height: 10),
                Text("Category: ${recipe.category}",style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    color: Color.fromARGB(255, 101, 128, 101), 
                    fontWeight: FontWeight.w600, 
                  )
                ), 
                ), 
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
  final String category; 

  Recipe({
    required this.title,
    required this.ingredients,
    required this.instructions,
    required this.userName, 
    required this.category
  });
}
