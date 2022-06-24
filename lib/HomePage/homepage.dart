// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fast_and_yummy/HomePage/signin.dart';
import 'package:fast_and_yummy/HomePage/signup.dart';
import 'package:flutter/services.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          toolbarHeight: 15,
          backgroundColor: Colors.white,
          elevation: 0,
          bottom: TabBar(
            indicatorColor: Color.fromARGB(255, 21, 157, 117),
            labelColor: Color.fromARGB(255, 21, 157, 117),
            unselectedLabelColor: Colors.black,
            padding: EdgeInsets.symmetric(horizontal: 45),
            labelStyle: TextStyle(
              fontSize: 18,
              fontFamily: "Prompt",
            ),
            // ignore: prefer_const_literals_to_create_immutables
            tabs: [
              Tab(
                text: "Sign in",
              ),
              Tab(
                text: "Sign up",
              )
            ],
          ),
        ),
        backgroundColor: Colors.white,
        body: TabBarView(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SignIn(),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SignUp(),
            ),
          ],
        ),
      ),
    );
  }
}
