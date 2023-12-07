// ignore: file_names
import 'package:app1/impactReport.dart';
import 'package:flutter/material.dart';
import 'CookBook.dart';
import 'FoodWasteInputPage.dart'; 

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    // Replace these with your actual pages
    CookbookScreen(),
    FoodWasteInputPage(), 
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Cook Book',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Recipes',
          ),
        ],
        selectedItemColor: const Color.fromARGB(255, 82, 181, 77),
      ),
    );
  }
}