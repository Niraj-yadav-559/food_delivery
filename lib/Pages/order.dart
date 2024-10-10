import 'package:flutter/material.dart';
import 'package:food_delivery/widget/widget_support.dart';

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              elevation: 2.0,
              child: Container(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Center(
                  child: Text(
                    "Food Cart",
                    style: AppWidget.HeadlineTextFeildStyle(),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              margin: EdgeInsets.only(left: 20.0, right: 20.0),
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular((10)),
                child: Row(
                  children: [
                    Container(
                      height: 90,
                      width: 40,
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Center(child: Text("2")),
                    ),
                    SizedBox(width: 20.0),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: Image.asset(
                        "assets/food.jpg",
                        height: 90,
                        width: 90,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 20.0),
                    Column(
                      children: [
                        Text(
                          "Pizaa",
                          style: AppWidget.semiboldTextFeildStyle(),
                        ),
                        Text(
                          "\$40",
                          style: AppWidget.semiboldTextFeildStyle(),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Spacer(),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Row(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Price",
                        style: AppWidget.HeadlineTextFeildStyle(),
                      ),
                      Text(
                        "\$50.0",
                        style: AppWidget.HeadlineTextFeildStyle(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
              child: Center(
                child: Text(
                  "CheckOut",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
