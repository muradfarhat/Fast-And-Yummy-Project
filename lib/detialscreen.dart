// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class detialscreen extends StatelessWidget {
  const detialscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        backgroundColor: Color.fromARGB(255, 37, 179, 136),
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Container(
            height: 300,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 37, 179, 136),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50)),
            ),
          )
        ],
      ),
    );
  }
}
