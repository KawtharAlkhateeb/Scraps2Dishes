// ignore: file_names
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'userInput.dart'; 

class FoodWasteInputPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _FoodWasteInputPageState createState() => _FoodWasteInputPageState();
}

class _FoodWasteInputPageState extends State<FoodWasteInputPage> {
  String foodWaste = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search for Recipes", style: GoogleFonts.lato(
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("Please enter below what ingredients you have and would like to use in a new recipe"), 
            SizedBox(height: 30),
            SizedBox(height: 40),
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter ingredients (e.g., chicken, rice)',
              ),
              onChanged: (value) {
                foodWaste = value;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the next page for dietary restrictions input
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DieteryRestictions (queryData: foodWaste,),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                backgroundColor: Color.fromARGB(255, 82, 181, 77),
              ), 
              child: Wrap(
                children: <Widget>[
                  Text("Next ..", style:TextStyle(fontSize:20)),
                  SizedBox(
                    width:10,
                  ),
                ],
                ),
            ),
          ],
        ),
      ),
    );
  }
}
