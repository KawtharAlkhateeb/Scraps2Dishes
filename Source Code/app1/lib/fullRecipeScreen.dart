// ignore: file_names
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FullRecipeScreen extends StatelessWidget {
  String recipeTitle;
  List<dynamic> ingredientLines;

  FullRecipeScreen({
    required this.recipeTitle, 
    required this.ingredientLines, 
  });

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Full Instructions", style: GoogleFonts.lato(
          textStyle: TextStyle(
            color: Color.fromARGB(255, 82, 181, 77)),
            fontWeight: FontWeight.bold, 
          )
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
          children:[
            Text('Ingredients:'),
            for (var ingredient in ingredientLines)
              Text(ingredient),
          ],
        ),
      ),
    );
  }
}
