import 'package:flutter/material.dart';
import 'recipes.dart'; 
import 'login.dart'; 
import 'signup.dart'; 
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Scraps2Dishes',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 224, 117, 17)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Scraps2Dishes'),
      routes: {
        '/signup': (context) => SignupScreen(), // Route to the signup page
        '/login': (context) => LoginPage(), // Route to the login page
        '/recipes':(context) => RecipeSearchScreen(), // route to recipe search page
      },
    );
  }
}

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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
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
            const SizedBox(height: 20),
            Center(
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  Row(
                    children: [
                      const Text("You have an account? "),  
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginPage()),
                          );
                        },
                        child: const Text("Login", style: TextStyle(color: Color.fromARGB(255, 239, 163, 69)),)
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  Column(
                    children:[
                      Row(
                        children: [
                          Text(
                            "If you are a new user to the app "
                          ), 
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SignupScreen()),
                              );
                            },
                            child: const Text("Sign up", style: TextStyle(color: Color.fromARGB(255, 239, 163, 69)),)
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
