// ignore_for_file: prefer_const_constructors, sort_child_properties_last
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:fast_and_yummy/HomePage/homepage.dart';
import 'package:fast_and_yummy/api/api.dart';
import 'package:fast_and_yummy/api/linkapi.dart';
import 'package:fast_and_yummy/deliverySection/deliveryHomePage.dart';
import 'package:fast_and_yummy/userpage/basic_user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPref;

dynamic lis;
bool loading = false;
bool isTrue = false;
Api api = Api();
Future<bool> getDeliveryData() async {
  loading = true;
  if (sharedPref.getString("id") != null) {
    var resp =
        await api.postReq(getInfoFromUsers, {"id": sharedPref.getString("id")});
    if (resp['status'] == "suc") {
      lis = resp['data'];
      loading = false;
      isTrue = true;
    }
  }
  return isTrue;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref = await SharedPreferences.getInstance();
  await getDeliveryData();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: sharedPref.getString("id") == null
          ? "home"
          : "userpage", // sharedPref.getString("id") == null ? "home" : "userpage" // sharedPref.getString("id") == null ? "deliveryProfile" : "deliveryProfile"

      routes: {
        "home": (context) => HomePage(),
        "userpage": (context) => sharedPref.getString("id") != null &&
                lis?['deliveryOrCustomer'] == "Delivery"
            ? homePageDelivery()
            : UserPage(), //UserPage(),
        //"deliveryProfile": (context) => homePageDelivery(),
      },
    );
  }
}
