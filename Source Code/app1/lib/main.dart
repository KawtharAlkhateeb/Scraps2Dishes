import 'package:app1/ReportIngredients.dart';
import 'package:app1/impactReport.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'logoAnimation.dart'; 

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Tooltip Example'),
//         ),
//         body: Center(
//           child: IconButton(
//             icon: Icon(Icons.info),
//             onPressed: () {
//               // Your action when the icon is pressed
//               // This can be empty or contain some logic
//             },
//             tooltip: 'Click for more info', // Tooltip text
//           ),
//         ),
//       ),
//     );
//   }
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false, 
      home: LogoAnimationScreen(),
    ),
  );
}


// void main() {
//   // Example list of ingredients
//   final ingredients = ['Olive oil', 'Garlic', 'Yogurt'];
//   searchIngredients(ingredients);
// }

// class MyApp extends StatelessWidget {
//   final bool firstLaunch;
//   MyApp({required this.firstLaunch});
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     if (firstLaunch) {
//       // Display the splash screen
//       return MaterialApp(
//         home: AnimatedSplashScreen(),
//       );
//     } else {
//       // Display the main page
//       return MaterialApp(
//         home: RecipeSearchScreen(),
//       );
//     }
//   }
// }
// class AnimatedSplashScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: 
//         CircleAvatar( 
//           radius: 68, //radius of avatar 
//           backgroundColor: Color.fromARGB(255, 82, 181, 77), //color 
//           child: Padding( 
//               padding: const EdgeInsets.all(5), // Border radius 
//               child: ClipOval(child: Image.asset('images/Logo 1.png')), 
//           ), 
//         )
//       ),
//     );
//   }

// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Text.rich(
//                 TextSpan(
//                   children: <TextSpan>[
//                     TextSpan(
//                       text:
//                           'Scraps2Dishes is a software that allows users to use their food waste/leftovers to make creative and delicious recipes.',
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             Center(
//               child:Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children:[
//                   Row(
//                     children: [
//                       const Text("You have an account? "),  
//                       TextButton(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (context) => LoginPage()),
//                           );
//                         },
//                         child: const Text("Login", style: TextStyle(color: Color.fromARGB(255, 239, 163, 69)),)
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 50),
//                   Column(
//                     children:[
//                       Row(
//                         children: [
//                           Text(
//                             "If you are a new user to the app "
//                           ), 
//                           TextButton(
//                             onPressed: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(builder: (context) => SignupScreen()),
//                               );
//                             },
//                             child: const Text("Sign up", style: TextStyle(color: Color.fromARGB(255, 239, 163, 69)),)
//                           ),
//                         ],
//                       ), 
//                     ]
//                   ), 
//                   const SizedBox(height: 10),
//                 ],
//               )
//             ) 
//           ],
//         ),
//       ),
//     );
//   }
// }
