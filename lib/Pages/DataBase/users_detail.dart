
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future AddUserDetails(Map<String, dynamic> userInfoMap, String Id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(Id)
        .set(userInfoMap);
  }
}
// class DatabaseMethods {
//   Future AddUserDetails(Map<String, dynamic> userInfoMap, String Id) async {
//     return await FirebaseFirestore.instance
//         .collection("users")
//         .doc(Id)
//         .set(userInfoMap);
//   }
// }

Future addFoodItem(Map<String, dynamic> userInfoMap, String name) async {
  return await FirebaseFirestore.instance.collection(name).add(userInfoMap);
}
