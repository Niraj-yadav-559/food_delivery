import 'package:flutter/material.dart';
import 'package:food_app/DataBase/users_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../wiget/widget_support.dart';
// import 'package:food_app/DataBase/shared_preferences_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static const String userIdKey = "USER_ID";

  // Save the User ID
  Future<bool> saveUserId(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(userIdKey, userId);
  }

  // Get the User ID
  Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userIdKey);
  }

  // Clear the User ID
  Future<bool> clearUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.remove(userIdKey);
  }
}
  // Import SharedPreferenceHelper

class Details extends StatefulWidget {
  String image, name, detail, price;
  Details({
    required this.detail,
    required this.image,
    required this.name,
    required this.price,
  });

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int a = 1, total = 0;
  String? id;

  // Get the shared preference for user ID
  Future<void> getTheSharedPref() async {
    id = await SharedPreferenceHelper().getUserId();
    setState(() {});
  }

  // Load data on initialization
  Future<void> onTheLoad() async {
    await getTheSharedPref();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    onTheLoad();
    total = int.parse(widget.price);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios_new_outlined,
                color: Colors.black,
              ),
            ),
            Image.network(
              widget.image,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.5,
              fit: BoxFit.fill,
            ),
            const SizedBox(height: 15.0),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.name, style: AppWidget.semiboldTextFeildStyle()),
                    Text("Chickpea Salad", style: AppWidget.boldTextFeildStyle()),
                  ],
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    if (a > 1) {
                      --a;
                      total = total - int.parse(widget.price);  // Fix the calculation
                    }
                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.remove, color: Colors.white),
                  ),
                ),
                const SizedBox(width: 20.0),
                Text(a.toString(), style: AppWidget.semiboldTextFeildStyle()),
                const SizedBox(width: 20.0),
                GestureDetector(
                  onTap: () {
                    ++a;
                    total = total + int.parse(widget.price);
                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.add, color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Text(
              widget.detail,
              maxLines: 4,
              style: AppWidget.LightTextFeildStyle(),
            ),
            const SizedBox(height: 20.0),
            Row(
              children: [
                Text("Delivery Time", style: AppWidget.semiboldTextFeildStyle()),
                const SizedBox(width: 20.0),
                const Icon(Icons.alarm, color: Colors.black54),
                const SizedBox(width: 20.0),
                Text("30 min", style: AppWidget.semiboldTextFeildStyle()),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Total Price", style: AppWidget.semiboldTextFeildStyle()),
                      Text(
                        "\$" + total.toString(),
                        style: AppWidget.HeadlineTextFeildStyle(),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (id != null) {
                        Map<String, dynamic> addFoodToCart = {
                          "Name": widget.name,
                          "Quantity": a.toString(),
                          "Total": total.toString(),
                          "Image": widget.image,
                        };
                        await DatabaseMethods().addFoodToCart(addFoodToCart, id!);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.orange,
                            content: Text(
                              "Food Added to cart",
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                              "User ID not found",
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                        );
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text(
                            "Add to cart",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          const SizedBox(width: 40.0),
                          Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
                          ),
                          const SizedBox(width: 10.0),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
