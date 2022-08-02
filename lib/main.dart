// ignore_for_file: prefer_const_constructors, sort_child_properties_last
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:fast_and_yummy/HomePage/homepage.dart';
import 'package:fast_and_yummy/deliverySection/profilePage.dart';
import 'package:fast_and_yummy/userpage/basic_user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPref;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: sharedPref.getString("id") == null
          ? "deliveryProfile"
          : "deliveryProfile", // sharedPref.getString("id") == null ? "home" : "userpage" // sharedPref.getString("id") == null ? "deliveryProfile" : "deliveryProfile"

      routes: {
        "home": (context) => HomePage(),
        "userpage": (context) => UserPage(),
        "deliveryProfile": (context) => deliveryProfile(),
      },
    );
  }
}
