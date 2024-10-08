import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/Admin/add_food.dart';
import 'package:food_delivery/Admin/admin_login.dart';
import 'package:food_delivery/Admin/home_admin.dart';
import 'package:food_delivery/Pages/home.dart';
// import 'package:food_delivery/Pages/admin_login.dart';
// import 'package:food_delivery/admin_login.dart';
// import 'package:food_app/firebase_options.dart';
// import 'package:food_app/pages/buttomnav.dart';
// import 'package:food_app/pages/home.dart';
// import 'package:food_app/pages/login.dart';
// import 'package:food_app/pages/onboard.dart';
// import 'package:food_app/pages/signup.dart';
import 'package:food_delivery/Pages/onboard.dart';
import 'package:food_delivery/Pages/profile.dart';
import 'package:food_delivery/firebase_options.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase with different options for Web, Android, and iOS
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions
        .currentPlatform, // Add this to pass platform-specific FirebaseOptions
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: Onboard(),
      // home: AdminLogin(),
      // home: (),
      // home: AddFood(),
      // home: Home(),
      home: Profile(),
      // home: Pizza(),
      // home: HomeAdmin(),
    );
  }
}
