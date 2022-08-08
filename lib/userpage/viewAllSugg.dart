// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../detialscreen.dart';

class viewAllSugg extends StatefulWidget {
  viewAllSugg({Key? key}) : super(key: key);

  @override
  State<viewAllSugg> createState() => _viewAllSuggState();
}

class _viewAllSuggState extends State<viewAllSugg> {
  TextEditingController searchValue =
      new TextEditingController(); // variable to store text field value in it

  List<Map> sugg = [
    {
      "image": "images/pizza.jpg",
      "name": "Food Name",
      "store": "Store Name",
      "price": "\$ 8.99",
      "star1": 1,
      "star2": 1,
      "star3": 1,
      "star4": 1,
      "star5": 1
    },
    {
      "image": "images/makloba.jpg",
      "name": "Food Name",
      "store": "Store Name",
      "price": "\$ 8.99",
      "star1": 1,
      "star2": 0,
      "star3": 0,
      "star4": 0,
      "star5": 0
    },
    {
      "image": "images/burger.jpg",
      "name": "Food Name",
      "store": "Store Name",
      "price": "\$ 8.99",
      "star1": 1,
      "star2": 1,
      "star3": 1,
      "star4": 0,
      "star5": 0
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        title: TextFormField(
          onEditingComplete: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(searchValue.text),
                  );
                });
          },

          controller:
              searchValue, // take text value and store it in searchValue variable
          textInputAction: TextInputAction.go,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 1),
            // ignore: prefer_const_constructors
            prefixIcon: Icon(
              Icons.search,
              color: Colors.grey,
            ),
            filled: true,
            fillColor: Colors.white,
            hintText: "Search",
            focusedBorder: outLDesign(),
            enabledBorder: outLDesign(),
            disabledBorder: outLDesign(),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 37, 179, 136),
      ),
      body: ListView.builder(
          itemCount: sugg.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, i) {
            return MaterialButton(
              padding: EdgeInsets.all(8),
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) =>
                //           Detialscreen()),
                // );
              },
              child: Container(
                  padding: EdgeInsets.all(5),
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    // ignore: prefer_const_literals_to_create_immutables
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromARGB(255, 197, 197, 197),
                          blurRadius: 4)
                    ],
                    color: Colors.white,

                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 170,
                        height: 140,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("${sugg[i]['image']}"))),
                      ),
                      Container(
                        width: 120,
                        padding: EdgeInsets.only(top: 15, left: 10, right: 10),
                        child: Column(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Container(
                              width: double.infinity,
                              child: Text(
                                "${sugg[i]['name']}",
                                overflow: TextOverflow.clip, // For text wraping
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              width: double.infinity,
                              child: Text(
                                "${sugg[i]['store']}",
                                overflow: TextOverflow.clip, // For text wraping
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Divider(
                              color: Colors.white,
                            ),
                            Container(
                              width: double.infinity,
                              child: Text(
                                "${sugg[i]['price']}  ",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 37, 179, 136),
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Divider(
                              color: Colors.white,
                            ),
                            Container(
                              width: double.infinity,
                              child: Row(
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  iconStar(i, "star1"),
                                  iconStar(i, "star2"),
                                  iconStar(i, "star3"),
                                  iconStar(i, "star4"),
                                  iconStar(i, "star5"),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )),
            );
          }),
    );
  }

  /************************ Start Functions Section ************************************* */
  OutlineInputBorder outLDesign() {
    return OutlineInputBorder(
        gapPadding: 10,
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Colors.white, width: 1));
  }

  Icon iconStar(int index, String star) {
    return Icon(
      sugg[index][star] == 1 ? Icons.star : Icons.star_border_outlined,
      //Icons.star,
      size: 20,
      color: Colors.amberAccent,
    );
  }
  /************************ End Functions Section ************************************* */
}
