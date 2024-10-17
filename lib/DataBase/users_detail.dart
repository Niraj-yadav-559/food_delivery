import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  // Method to add user details
  Future AddUserDetails(Map<String, dynamic> userInfoMap, String Id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(Id)
        .set(userInfoMap);
  }

  // Method to add a food item to a specific collection (e.g., food items)
  Future addFoodItem(Map<String, dynamic> addItem, String collectionName) async {
    return await FirebaseFirestore.instance
        .collection(collectionName)
        .add(addItem);
  }

  // Method to add food to cart
  Future addFoodToCart(Map<String, dynamic> addFoodtoCart, String cartId) async {
    return await FirebaseFirestore.instance
        .collection("cart")
        .doc(cartId)
        .set(addFoodtoCart);
  }

  Stream? getFoodItem(String s) {}
}
