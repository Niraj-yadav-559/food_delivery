import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:food_app/firebase_options.dart';
import 'package:food_app/pages/onboard.dart';
import 'package:food_app/wiget/app_constent.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized(); // Ensure all Flutter bindings are initialized
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform); // Initialize Firebase
//   runApp(MyApp()); // Run the app
// }
// Future<void> initializeDefault() async {
//     FirebaseApp app = await Firebase.initializeApp(
//       options: DefaultFirebaseOptions.currentPlatform,
//     );
//    // print('Initialized default app $app');
//   }
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized(); // initialize app
//   await Firebase.initializeApp(); // initialize Firebase
//   runApp(MyApp()); // run app
//    Future<void> initializeDefault() async {
//     FirebaseApp app = await Firebase.initializeApp(
//       //options: FirebaseOptions(apiKey:"abcd",appId: "com.example.food_app",messagingSenderId: "com.example.food_app",projectId: "com.example.food_app"),
//     );
//     print('Initialized default app $app');
//   }
// }

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   //Stripe.publishableKey = publishableKey;
//   await Firebase.initializeApp();
//   runApp(const MyApp());
// }/
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();  // Firebase must be initialized
//   runApp(MyApp());
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = publishableKey;

  // Initialize Firebase with different options for Web, Android, and iOS
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Add this to pass platform-specific FirebaseOptions
  );

  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Onboard(),
      // home: on(),
    );
  }
}