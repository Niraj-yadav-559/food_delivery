import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_app/DataBase/users_detail.dart';
import 'package:food_app/pages/details.dart';
import 'package:food_app/wiget/widget_support.dart';
// import 'package:food_app/widget/widget_support.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

bool icecream = false, pizza = false, salad = false, burger = false;

Stream? fooditemStrem;

ontheload()async {
fooditemStrem= await DatabaseMethods().getFoodItem("Pizza");
setState(() {
  
});
}


void initState() {
  super.initState();
  ontheload();
}

Widget allItems() {
  return StreamBuilder(stream: fooditemStrem, builder: (context, AsyncSnapshot snapshot){
  return snapshot.hasData? ListView.builder(
    padding: EdgeInsets.zero,
    itemCount: snapshot.data.docs.length,
    shrinkWrap: true,
    scrollDirection: Axis.horizontal,
    itemBuilder: (context, index){
    DocumentSnapshot ds = snapshot.data.docs[index];
    rerurn  GestureDetector;(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const Details()));
                        },
                        child: Container(
                          margin: const EdgeInsets.all(4),
                          child: Material(
                            elevation: 5.0,
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                Image.network(ds["Image"],
                                 height: 150,
                                width: 150, 
                                fit: BoxFit.cover,
                                ),
                                Text(ds["Name"],
                                 style: AppWidget.semiboldTextFeildStyle()),
                                 const SizedBox(height: 5.0,),
                                 Text("Fresh and Healthy",
                                 style: AppWidget.LightTextFeildStyle()),
                                 const SizedBox(height: 5.0,),
                                 Text("\$25"+ds["Price"], style: AppWidget.semiboldTextFeildStyle(),)
                              ],),
                            ),
                          ),
                        ),
                      );
  }):CircularProgressIndicator();
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 50.0, left: 10.0,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Hello Niraj",
                style: AppWidget.boldTextFeildStyle()
                ),
                 Container(
                  margin: const EdgeInsets.only(right: 20.0),
                  padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
            ),
              ],
            ),
            const SizedBox(height: 20.0,),
            Text("Delicios Food",
                style: AppWidget.HeadlineTextFeildStyle()
                ),
                Text("Delicios and Get Great Food",
                style: AppWidget.LightTextFeildStyle()
                ),
                const SizedBox(height: 20.0,),
                Container(
                  margin: const EdgeInsets.only(right: 20.0),
                  child: showItem()),
                const SizedBox(height: 20.0,),
                Container(
                  height: 270,
                  child: allItems()),
                const SizedBox(height: 30.0,),
              Container(
                margin: const EdgeInsets.only(right: 20.0),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset("assets/salad2.png",
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover,
                        ),
                        const SizedBox(width: 20.0,),
                        Column(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width/2,
                              child: Text("Mediterranean Chickpea salad",
                               style: AppWidget.semiboldTextFeildStyle(),
                               
                               ),
                               
                            ),
                            const SizedBox(height: 5.0,),
                            SizedBox(
                              width: MediaQuery.of(context).size.width/2,
                              child: Text("Honey Goot chees",
                               style: AppWidget.LightTextFeildStyle(),
                               ),
                               
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width/2,
                              child: Text("\$28",
                               style: AppWidget.semiboldTextFeildStyle(),
                               
                               ),
                               
                            ),
                            
                            
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
           

          ]
        ),
      ),
    );
  }

  Widget showItem(){
    return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (){
                        icecream = true;
                        pizza = false;
                        salad = false;
                        burger = false;
                        setState(() {
                          
                        });
                      },
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          decoration: BoxDecoration(color: icecream?Colors.black: Colors.white, borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.all(8),
                          child: Image.asset("assets/ice-cream.png", height: 40, width: 40, fit: BoxFit.cover, color: icecream? Colors.white: Colors.black,),
                        ),
                      ),
                    ),
                   GestureDetector(
                      onTap: (){
                        icecream = false;
                        pizza = true;
                        salad = false;
                        burger = false;
                        setState(() {
                          
                        });
                      },
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          decoration: BoxDecoration(color: pizza?Colors.black: Colors.white, borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.all(8),
                          child: Image.asset("assets/pizza.png", height: 40, width: 40, fit: BoxFit.cover, color: pizza? Colors.white: Colors.black,),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        icecream = false;
                        pizza = false;
                        salad = true;
                        burger = false;

                        setState(() {
                          
                        });
                      },
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          decoration: BoxDecoration(color: salad?Colors.black: Colors.white, borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.all(8),
                          child: Image.asset("assets/salad.png", height: 40, width: 40, fit: BoxFit.cover, color: salad? Colors.white: Colors.black,),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        icecream = false;
                        pizza = false;
                        salad = false;
                        burger = true;
                        setState(() {
                          
                        });
                      },
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          decoration: BoxDecoration(color: burger?Colors.black: Colors.white, borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.all(8),
                          child: Image.asset("assets/burger.png", height: 40, width: 40, fit: BoxFit.cover, color: burger? Colors.white: Colors.black,),
                        ),
                      ),
                    ),
                  ],
                );
  }
}