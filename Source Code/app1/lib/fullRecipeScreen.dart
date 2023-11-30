// ignore: file_names
import 'package:flutter/material.dart';

class FullRecipeScreen extends StatelessWidget {
  String recipeTitle;
  List<String> ingredientLines;

  FullRecipeScreen({
    required this.recipeTitle, 
    required this.ingredientLines, 
  });

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Full Instructions", style: TextStyle(color: Color.fromARGB(255, 82, 181, 77), fontWeight: FontWeight.bold)),
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
            Text('Ingredients:'),
            for (var ingredient in ingredientLines)
              Text(ingredient),
          ],
        ),
      ),
    );
  }
}
