// ignore: file_names
import 'package:flutter/material.dart';

class FullRecipeScreen extends StatelessWidget {
  final String recipeTitle;
  final List<String> ingredientLines;

  FullRecipeScreen({
      required this.recipeTitle, 
      required this.ingredientLines, 
    });

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: Text(recipeTitle)),
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
