import 'package:flutter/material.dart';
import 'userInput.dart'; 
import 'recipes.dart'; 

class FoodWasteInputPage extends StatefulWidget {
  @override
  _FoodWasteInputPageState createState() => _FoodWasteInputPageState();
}

class _FoodWasteInputPageState extends State<FoodWasteInputPage> {
  String foodWaste = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Input'),
        backgroundColor: Color.fromARGB(255, 255, 226, 107),
        leading: Image.asset('images/Logo 1.png', width: 250, height: 250,),
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
                    builder: (context) => DropdownButtonApp(),
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
