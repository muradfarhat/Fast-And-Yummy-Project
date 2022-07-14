// ignore_for_file: prefer_const_constructors

// ignore_for_file: prefer_const_literals_to_create_immutables
import 'dart:html';

import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  Color color = Color.fromARGB(255, 37, 179, 136);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color,
        toolbarHeight: 0,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 200,
                  width: size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("images/food.jpg"),
                        fit: BoxFit.cover),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromARGB(255, 78, 78, 78),
                          blurRadius: 15,
                          spreadRadius: 5,
                          offset: Offset(0, 3))
                    ],
                  ),
                ),
                Container(
                  height: 200,
                  width: size.width,
                  decoration:
                      BoxDecoration(color: Colors.black.withOpacity(0.3)),
                ),
                Positioned(
                  left: 10,
                  top: 10,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              width: size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    onTap: () {},
                    title: Text(
                      "New Category",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(
                      Icons.edit_note_sharp,
                      size: 30,
                      color: color,
                    ),
                  ),
                  Visibility(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      width: size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          textFieldDesign(
                              "Catagory Name", Icons.food_bank, true),
                          SizedBox(
                            height: 10,
                          ),
                          textFieldDesign("Image Path", Icons.image, false),
                          SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            child: Container(
                              alignment: Alignment.center,
                              height: 40,
                              width: 100,
                              color: color,
                              child: Text(
                                "Save",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    title: Text(
                      "New Item",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(
                      Icons.edit_note_sharp,
                      size: 30,
                      color: Color.fromARGB(255, 37, 179, 136),
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

  TextFormField textFieldDesign(String hint, IconData icon, bool en) {
    return TextFormField(
      cursorColor: Color.fromARGB(255, 21, 157, 117),
      decoration: InputDecoration(
        enabled: en,
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 21, 157, 117)),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 21, 157, 117)),
        ),
        hintText: hint,
        fillColor: Colors.black,
        hintStyle: TextStyle(
          fontFamily: "Prompt2",
        ),
        icon: InkWell(
          child: Icon(
            icon,
            color: Color.fromARGB(255, 21, 157, 117),
          ),
        ),
      ),
    );
  }
}
