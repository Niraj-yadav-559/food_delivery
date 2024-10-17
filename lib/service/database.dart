import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  // Method to add user details
  Future<void> addUserDetail(Map<String, dynamic> userInfoMap, String id) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .set(userInfoMap);
  }

  // Method to update user wallet
  Future<void> updateUserWallet(String id, String amount) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update({'wallet': amount});
  }

  // Method to add food item
  Future<void> addFoodItem(Map<String, dynamic> foodData, String foodName) async {
    try {
      await FirebaseFirestore.instance
          .collection('foodItems')
          .doc(foodName)
          .set(foodData);
    } catch (e) {
      print("Error adding food item: $e");
    }
  }

  // Method to get food items as a stream
  Future<Stream<QuerySnapshot>> getFoodItem(String name) async {
    return FirebaseFirestore.instance.collection(name).snapshots();
  }

  // Method to add food to cart
  Future<void> addFoodToCart(Map<String, dynamic> userInfoMap, String id) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection("cart")
        .add(userInfoMap);
  }
}
