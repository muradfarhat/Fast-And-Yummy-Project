// ignore_for_file: prefer_const_constructors, sort_child_properties_last
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:fast_and_yummy/HomePage/homepage.dart';
import 'package:fast_and_yummy/HomePage/signup.dart';
import 'package:fast_and_yummy/ProductInsideStore.dart';
import 'package:fast_and_yummy/Stores.dart';
import 'package:fast_and_yummy/detialscreen.dart';
import 'package:fast_and_yummy/myStore.dart';
import 'package:fast_and_yummy/myStore/addpage.dart';
import 'package:fast_and_yummy/splash.dart';
import 'package:fast_and_yummy/store_product.dart';
import 'package:fast_and_yummy/user%20page/basic_user.dart';
import 'package:flutter/material.dart';
import 'dart:html';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UserPage(),
    );
  }
}
