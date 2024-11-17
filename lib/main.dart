import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/firebase_options.dart';
import 'package:food_delivery/splashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions
          .currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: AddCategoryPage(),
        // home: FetchCategoryPage(),
        // home: AddFood(),
        // home: FetchFood(),
        // home: HomeAdmin(),
        // home: Home(),
        home: Splashscreen(),
        // home: Login(),
    );
  }
}