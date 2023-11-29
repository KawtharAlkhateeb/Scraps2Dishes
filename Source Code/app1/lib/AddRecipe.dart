import 'package:flutter/material.dart';
import 'CookBook.dart'; 
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Add a recipe to our cook book';

    return MaterialApp(
      title: appTitle,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Add a recipe to the community book", style: TextStyle(color: Color.fromARGB(255, 82, 181, 77), fontWeight: FontWeight.bold)),
          backgroundColor: Color.fromARGB(255, 255, 226, 107),
          leading: CircleAvatar( 
            radius: 14, //radius of avatar 
            backgroundColor: Color.fromARGB(255, 82, 181, 77), //color 
            child: Padding( 
              padding: const EdgeInsets.all(2), // Border radius 
              child: ClipOval(child: Image.asset('images/Logo 1.png')), 
            ), 
          )
        ),
        body: const MyCustomForm(),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController recipeNameController = TextEditingController();
  TextEditingController ingredientsController = TextEditingController();
  TextEditingController instructionsController = TextEditingController();
  TextEditingController categoryController = TextEditingController(); 

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 50),
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(
              hintText: 'Enter a name to be displayed with your recipe',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a username';
              }
              return null;
            },
          ),
          SizedBox(height: 20,), 
          TextFormField(
            controller: recipeNameController,
            decoration: InputDecoration(
              hintText: 'Enter your recipe title',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a recipe title';
              }
              return null;
            },
          ),
          SizedBox(height: 20,), 
          TextFormField(
            controller: ingredientsController,
            maxLines: null,
            decoration: InputDecoration(
              hintText: 'Enter ingredients (comma-separated (,))',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter ingredients';
              }
              return null;
            },
          ),
          SizedBox(height: 20,), 
          TextFormField(
            controller: instructionsController,
            maxLines: null,
            decoration: InputDecoration(
              hintText: 'Enter recipe instructions',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter instructions';
              }
              return null;
            },
          ),
          SizedBox(height: 20,), 
          TextFormField(
            controller: categoryController,
            decoration: InputDecoration(
              hintText: 'Enter recipe category (e.g., vegetarian, vegan, gluten-free)',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a category';
              }
              return null;
            },
          ),
          SizedBox(height: 20,), 
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  
                  CollectionReference recipesCollection = _firestore.collection('recipes');
                  recipesCollection.add({
                    'userId': nameController.text,
                    'recipeName': recipeNameController.text,
                    'ingredients': ingredientsController.text,
                    'instructions': instructionsController.text,
                    'category': categoryController.text, 
                  }); 
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Recipe added successfully'),
                    ),
                  );
                  Navigator.push(
                    context,
                      MaterialPageRoute(builder: (context) => CookbookScreen()),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                backgroundColor: Color.fromARGB(255, 82, 181, 77),
              ), 
              child: Wrap(
                children: <Widget>[
                  Text("Add Recipe", style:TextStyle(fontSize:20)),
                  SizedBox(
                    width:10,
                  ),
                ],
                ),
            ),
          ),
        ],
      ),
    );
  }
}
