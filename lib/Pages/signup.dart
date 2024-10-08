// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// // import 'package:food_app/Pages/onboard.dart';
// // import 'package:food_app/pages/login.dart';
// // import 'package:food_app/wiget/widget_support.dart';
// // ignore: unused_import
// import 'package:food_delivery/Pages/login.dart';
// import 'package:food_delivery/Pages/onboard.dart';
// import 'package:food_delivery/wiget/widget_support.dart'; // Ensure this is correctly imported

// class SignUp extends StatefulWidget {
//   const SignUp({super.key});

//   @override
//   State<SignUp> createState() => _SignUpState();
// }

// class _SignUpState extends State<SignUp> {
//   // Controllers to capture user input
//   TextEditingController nameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();

//   final _formKey = GlobalKey<FormState>();

//   // Registration function
//   // Registration function
//   Future<void> registration() async {
//     if (_formKey.currentState!.validate()) {
//       String name = nameController.text.trim();
//       String email = emailController.text.trim();
//       String password = passwordController.text.trim();

//       try {
//         // Create user using FirebaseAuth
//         UserCredential userCredential =
//             await FirebaseAuth.instance.createUserWithEmailAndPassword(
//           email: email,
//           password: password,
//         );

//         String userId = userCredential.user!.uid;

//         // Store user info in Firestore
//         await FirebaseFirestore.instance.collection('users').doc(userId).set({
//           'name': name,
//           'email': email,
//           'uid': userId,
//         });

//         // Show success message and redirect to onboard screen
//         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content:
//               Text("Registration Successful", style: TextStyle(fontSize: 20)),
//           backgroundColor: Colors.orangeAccent,
//         ));

//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const Onboard()),
//         );
//       } on FirebaseAuthException catch (e) {
//         String errorMsg;

//         // Check for specific error codes in FirebaseAuthException
//         if (e.code == 'weak-password') {
//           errorMsg = "The password is too weak.";
//         } else if (e.code == 'email-already-in-use') {
//           errorMsg = "The email address is already in use.";
//         } else if (e.code == 'invalid-email') {
//           errorMsg = "The email address is not valid.";
//         } else {
//           errorMsg =
//               "Registration failed: ${e}"; // Provide detailed Firebase error message
//         }

//         // Show error message
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text(errorMsg, style: const TextStyle(fontSize: 20)),
//           backgroundColor: Colors.redAccent,
//         ));
//       } catch (e) {
//         // Catch any other general errors
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text("An unexpected error occurred: ${e.toString()}",
//               style: const TextStyle(fontSize: 20)),
//           backgroundColor: Colors.redAccent,
//         ));
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: SizedBox(
//           width: MediaQuery.of(context).size.width,
//           child: Stack(
//             children: [
//               // Background gradient
//               Container(
//                 height: MediaQuery.of(context).size.height / 2.5,
//                 decoration: const BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                     colors: [
//                       Color(0xFFff5c30),
//                       Color(0xFFe74b1a),
//                     ],
//                   ),
//                 ),
//               ),
//               // Foreground (form)
//               Container(
//                 margin: EdgeInsets.only(
//                     top: MediaQuery.of(context).size.height / 3),
//                 height: MediaQuery.of(context).size.height / 2,
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(40),
//                     topRight: Radius.circular(40),
//                   ),
//                 ),
//               ),
//               // Form and Sign-up UI
//               Container(
//                 margin:
//                     const EdgeInsets.only(top: 60.0, left: 20.0, right: 20.0),
//                 child: Column(
//                   children: [
//                     Center(
//                       child: Image.asset(
//                         "assets/logo.png",
//                         width: MediaQuery.of(context).size.width / 1.5,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     const SizedBox(height: 50.0),
//                     Material(
//                       elevation: 5.0,
//                       borderRadius: BorderRadius.circular(20),
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: Form(
//                           key: _formKey,
//                           child: Column(
//                             children: [
//                               const SizedBox(height: 30.0),
//                               Text("Sign Up",
//                                   style: AppWidget.HeadlineTextFeildStyle()),
//                               const SizedBox(height: 30.0),
//                               // Name Input
//                               TextFormField(
//                                 controller: nameController,
//                                 decoration: const InputDecoration(
//                                   hintText: ' enter your name Name',
//                                   prefixIcon: Icon(Icons.person_outline),
//                                 ),
//                                 validator: (value) {
//                                   if (value == null || value.isEmpty) {
//                                     return "Please enter your name";
//                                   }
//                                   return null;
//                                 },
//                               ),
//                               const SizedBox(height: 30.0),
//                               // Email Input
//                               TextFormField(
//                                 controller: emailController,
//                                 decoration: const InputDecoration(
//                                   hintText: 'Email',
//                                   prefixIcon: Icon(Icons.email_outlined),
//                                 ),
//                                 validator: (value) {
//                                   if (value == null || value.isEmpty) {
//                                     return "Please enter your email";
//                                   }
//                                   return null;
//                                 },
//                               ),
//                               const SizedBox(height: 30.0),
//                               // Password Input
//                               TextFormField(
//                                 controller: passwordController,
//                                 obscureText: true,
//                                 decoration: const InputDecoration(
//                                   hintText: 'Password',
//                                   prefixIcon: Icon(Icons.lock_outline),
//                                 ),
//                                 validator: (value) {
//                                   if (value == null || value.isEmpty) {
//                                     return "Please enter your password";
//                                   }
//                                   return null;
//                                 },
//                               ),
//                               const SizedBox(height: 80.0),
//                               // Sign-Up Button
//                               GestureDetector(
//                                 onTap: registration,
//                                 child: Material(
//                                   elevation: 5.0,
//                                   borderRadius: BorderRadius.circular(20),
//                                   child: Container(
//                                     padding: const EdgeInsets.symmetric(
//                                         vertical: 8.0),
//                                     width: 200,
//                                     decoration: BoxDecoration(
//                                       color: Colors.green,
//                                       borderRadius: BorderRadius.circular(20),
//                                     ),
//                                     child: const Center(
//                                       child: Text(
//                                         "SIGN UP",
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 18.0,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(height: 70.0),
//                               GestureDetector(
//                                 onTap: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => const Login()),
//                                   );
//                                 },
//                                 child: const Text(
//                                     "Already have an account? Log In"),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/Pages/login.dart';
import 'package:food_delivery/Pages/onboard.dart';
import 'package:food_delivery/widget/widget_support.dart'; // Ensure this is correctly imported

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<void> registration() async {
    if (_formKey.currentState!.validate()) {
      String name = nameController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      try {
        // Create user with FirebaseAuth
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        String userId = userCredential.user!.uid;

        // Store user data in Firestore
        await FirebaseFirestore.instance.collection('users').doc(userId).set({
          'name': name,
          'email': email,
          'uid': userId,
        });

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content:
              Text("Registration Successful", style: TextStyle(fontSize: 20)),
          backgroundColor: Colors.orangeAccent,
        ));

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Onboard()),
        );
      } on FirebaseAuthException catch (e) {
        String errorMsg;

        if (e.code == 'weak-password') {
          errorMsg = "The password is too weak.";
        } else if (e.code == 'email-already-in-use') {
          errorMsg = "The email address is already in use.";
        } else if (e.code == 'invalid-email') {
          errorMsg = "The email address is not valid.";
        } else {
          errorMsg = "Registration failed: ${e}";
        }

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(errorMsg, style: const TextStyle(fontSize: 20)),
          backgroundColor: Colors.redAccent,
        ));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("An unexpected error occurred: ${e.toString()}",
              style: const TextStyle(fontSize: 20)),
          backgroundColor: Colors.redAccent,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2.5,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFff5c30),
                      Color(0xFFe74b1a),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 3),
                height: MediaQuery.of(context).size.height / 2,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.only(top: 60.0, left: 20.0, right: 20.0),
                child: Column(
                  children: [
                    Center(
                      child: Image.asset(
                        "assets/logo.png",
                        width: MediaQuery.of(context).size.width / 1.5,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 50.0),
                    Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              const SizedBox(height: 30.0),
                              Text("Sign Up",
                                  style: AppWidget.HeadlineTextFeildStyle()),
                              const SizedBox(height: 30.0),
                              TextFormField(
                                controller: nameController,
                                decoration: const InputDecoration(
                                  hintText: 'Enter your name',
                                  prefixIcon: Icon(Icons.person_outline),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter your name";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 30.0),
                              TextFormField(
                                controller: emailController,
                                decoration: const InputDecoration(
                                  hintText: 'Email',
                                  prefixIcon: Icon(Icons.email_outlined),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter your email";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 30.0),
                              TextFormField(
                                controller: passwordController,
                                obscureText: true,
                                decoration: const InputDecoration(
                                  hintText: 'Password',
                                  prefixIcon: Icon(Icons.lock_outline),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter your password";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 80.0),
                              GestureDetector(
                                onTap: registration,
                                child: Material(
                                  elevation: 5.0,
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    width: 200,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "SIGN UP",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 70.0),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Login()),
                                  );
                                },
                                child: const Text(
                                    "Already have an account? Log In"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
