// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class profile extends StatefulWidget {
  profile({Key? key}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 30),
          height: 150,
          width: 150,

          // ignore: prefer_const_constructors
          decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage("images/burger.jpg")),
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        Row(
          children: [
            Expanded(
              flex: 4,
              child: Text("Customer Name",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            ),
            Expanded(child: Icon(Icons.edit))
          ],
        ),
        ListTile(
          title: Text("data"),
        )
      ]),
    );
  }
}
