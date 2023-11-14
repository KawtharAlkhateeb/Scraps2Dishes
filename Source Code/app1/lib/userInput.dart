import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: TextField(
            decoration: InputDecoration(
              hintText: 'Enter ingredients (e.g., chicken, rice)',
            ),
          ), 
      ),  
    ); 
  }
}