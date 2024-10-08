import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:food_app/pages/home.dart';
import 'package:food_app/pages/order.dart';
import 'package:food_app/pages/profile.dart';
// ignore: unused_import
import 'package:food_app/pages/wallet.dart';

class Buttomnav extends StatefulWidget {
  const Buttomnav({super.key});

  @override
  State<Buttomnav> createState() => _ButtomnavState();
}

class _ButtomnavState extends State<Buttomnav> {
  int currentTabIndex = 0;

  late List<Widget> pages;
  late Widget currentPage;
  late Home homepage;
  late Profile profile;
  late Order order;
  late Wallet wallet;ō

  @override
  void initState() {
    homepage = const Home();
    order = const Order();
    profile = const Profile();
    wallet = const Wallet(); 
    pages = [homepage, order, wallet, profile];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height:54,
        backgroundColor:Colors.white,
        color: Colors.black,
        animationDuration:const Duration(milliseconds: 500,),
        onTap: (int index){
          setState(() {
            currentTabIndex = index;
          });
        }, 
        
    items:const [
        Icon(
          Icons.home_outlined,
          color: Colors.white,
          ),
        Icon(
          Icons.shopping_bag_outlined,
          color: Colors.white,
          ),
        Icon(
          Icons.wallet_outlined,
          color: Colors.white,
          ),
        Icon(
          Icons.person_outlined,
          color: Colors.white,
          ),

      ],),
        body: pages[currentTabIndex],
    );
  }
 // CurvedNavigationBar({required items, required int height, required Color backgroundColor, required Duration animationDuration, required Null Function(dynamic int, dynamic index) onTap}) {}
}