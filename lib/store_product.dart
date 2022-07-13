// ignore_for_file: prefer_const_constructors
//ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:fast_and_yummy/containter_design_for_store_page.dart';
import 'package:flutter/material.dart';

class StoreProduct extends StatelessWidget {
  const StoreProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 37, 179, 136),
        title: Center(child: Text("Store Name")),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              height: 200,
              width: size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/macdonald.png"),
                    fit: BoxFit.cover),
                boxShadow: [
                  BoxShadow(
                      color: Color.fromARGB(255, 133, 133, 133),
                      blurRadius: 8,
                      offset: Offset(0, 3))
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            listTileDesign("Meats", context),
            ContDFSP("images/pizza.jpg", "Pizza", "20₪"),
            ContDFSP("images/burger.jpg", "Burger", "10₪"),
            listTileDesign("Sweets", context),
            ContDFSP("images/food.jpg", "Sald", "6₪"),
            ContDFSP("images/makloba.jpg", "Makloba", "30₪"),
          ],
        ),
      ),
    );
  }

  ListTile listTileDesign(String title, BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      trailing: TextButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(title),
                  actions: [Text("Exit")],
                );
              });
        },
        child: Text(
          "View All",
          style:
              TextStyle(color: Color.fromARGB(255, 37, 179, 136), fontSize: 12),
        ),
      ),
    );
  }
}
