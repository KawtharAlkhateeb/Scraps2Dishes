import 'package:app1/recipes.dart';
import 'package:flutter/material.dart';


const List<String> list = <String>['', 'Vegetarian', 'Vegan', 'Gluten-Free', 'Dairy-Free', 'Nut-Free'];

class DropdownButtonApp extends StatelessWidget {
  const DropdownButtonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
        title: Text('Dietary Restrictions Selection'),
        backgroundColor: Color.fromARGB(255, 255, 226, 107),
        leading: Image.asset('images/Logo 1.png', width: 250, height: 250,),
      ) ,
        body: const Center( 
          child: 
          DropdownButtonExample(),
        ),
      ),
    );
  }
}

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({Key? key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 30,),
        Text(
          'Any extras? ',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 82, 181, 77)),

        ),
        SizedBox(height: 60), // Adjust the spacing between the text and dropdown
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Dietary Requirments"), 
            SizedBox(width: 20), 
            Container(
              width: 150, // Set your desired width
              child: DropdownButton<String>(
                value: dropdownValue,
                icon: Visibility (visible:false, child: Icon(Icons.arrow_downward)),
                elevation: 20,
                style: const TextStyle(color: Color.fromARGB(255, 5, 5, 5)),
                underline: Container(
                  height: 2,
                  color: const Color.fromARGB(255, 82, 181, 77),
                ),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    dropdownValue = value!;
                  });
                },
                items: list.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              
            ),
            Icon(Icons.arrow_drop_down),
          ],
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
              builder: (context) => RecipeSearchScreen(
                dietaryRestriction: "Vegan",
                query:'Chicken', 
              ),
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
              Icon(
                Icons.search,
                size: 24.0,
              ),
              SizedBox(
                width:10,
              ),
              Text("Search Recipes", style:TextStyle(fontSize:20)),
            ],
          ),
        ),
      ],
    );
  }
}