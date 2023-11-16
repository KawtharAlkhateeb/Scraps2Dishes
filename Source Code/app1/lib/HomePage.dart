// ignore: file_names
import 'package:flutter/material.dart';
import 'CookBook.dart';
import 'FoodWasteInputPage.dart'; 
List<Recipe> myRecipes = [
  Recipe(
    title: 'Chocolate Cake',
    imageUrl: 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.mybakingaddiction.com%2Fthe-best-chocolate-cake%2F&psig=AOvVaw0PjHJYdM5ICah22_TTLnEt&ust=1700235331140000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCKC-j6rsyIIDFQAAAAAdAAAAABAE',
    ingredients: 'Flour, Sugar, Cocoa, ...',
    instructions: '1. Mix dry ingredients, 2. Add wet ingredients, ...',
    userName: 'Unknown', 
  ),
  Recipe(
    title: 'Vegetable Stir Fry',
    imageUrl: 'https://example.com/vegetable_stir_fry.jpg',
    ingredients: 'Broccoli, Carrots, Peppers, ...',
    instructions: '1. Chop vegetables, 2. Stir-fry in a pan, ...',
    userName: 'unknow', 
  ),
  // Add more recipes as needed
];
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scraps2Dishes",style: TextStyle(color: Color.fromARGB(255, 82, 181, 77), fontWeight: FontWeight.bold)),
        backgroundColor: Color.fromARGB(255, 255, 226, 107),
        leading: Image.asset('images/Logo 1.png', width: 250, height: 250,),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text.rich(
                TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text:
                          'Scraps2Dishes is a software that allows users to use their food waste/leftovers to make creative and delicious recipes.',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 50),
            Center(
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  Row(
                    children: [
                      const Text("Want to contribute to our cook book? "),  
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CookbookScreen(recipes: myRecipes)),
                          );
                        },
                        child: const Text("Cook book", style: TextStyle(color: Color.fromARGB(255, 82, 181, 77), fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      Row(
                        children: [
                          Text(
                            "Would you like to use your leftovers in a recipe?"
                          ), 
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => FoodWasteInputPage()),
                              );
                            },
                            child: const Text("Search Recipes", style: TextStyle(color: Color.fromARGB(255, 82, 181, 77), fontWeight: FontWeight.bold),)
                          ),
                        ],
                      ), 
                    ]
                  ), 
                  const SizedBox(height: 10),
                ],
              )
            ) 
          ],
        ),
      ),
    );
  }
}
