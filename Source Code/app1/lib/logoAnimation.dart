import 'package:app1/FoodWasteInputPage.dart';
import 'package:flutter/material.dart';
import 'recipes.dart'; 

class LogoAnimationScreen extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _LogoAnimationScreenState createState() => _LogoAnimationScreenState();
  
}

class _LogoAnimationScreenState extends State<LogoAnimationScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2), // Adjust the duration as needed
      vsync: this,
    );
    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _controller.forward(); // Start the animation

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _navigateToMainContent(); // Call a method to navigate
      }
    });
  }

  // Create a method to handle navigation
  void _navigateToMainContent() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) {
        return FoodWasteInputPage();
      },
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Opacity(
              opacity: _opacity.value,
              child: 
              CircleAvatar( 
                radius: 140, //radius of avatar 
                backgroundColor: Color.fromARGB(255, 82, 181, 77), //color 
                child: Padding( 
                  padding: const EdgeInsets.all(5), // Border radius 
                  child: ClipOval(child: Image.asset('images/Logo 1.png')), 
                ), 
              )
            );
          },
        ),
      ),
    );
  }
}
