// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class viewAllOffers extends StatefulWidget {
  viewAllOffers({Key? key}) : super(key: key);

  @override
  State<viewAllOffers> createState() => _viewAllOffersState();
}

class _viewAllOffersState extends State<viewAllOffers> {
  TextEditingController searchValue =
      new TextEditingController(); // variable to store text field value in it

  List<Map> offers = [
    {
      "image": "images/burger.jpg",
      "name": "Food Name",
      "store": "Store Name",
      "newPrice": "\$ 8.99",
      "oldPrice": "\$ 10.00",
      "rate": "4.0"
    },
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
          itemCount: offers.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, i) {
            return MaterialButton(
              padding: EdgeInsets.all(8),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Test text"),
                        actions: [Text("data")],
                      );
                    });
              },
              child: Container(
                  padding: EdgeInsets.all(5),
                  width: double.infinity,
                  height: 120,
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
                        width: 120,
                        height: 110,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("${offers[i]['image']}"))),
                      ),
                      Container(
                        width: 120,
                        // ignore: prefer_const_constructors
                        padding: EdgeInsets.only(top: 15, left: 10, right: 10),
                        child: Column(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Container(
                              width: double.infinity,
                              child: Text(
                                "${offers[i]['name']}",
                                overflow: TextOverflow.clip, // For text wraping
                                // ignore: prefer_const_constructors
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              width: double.infinity,
                              child: Text(
                                "${offers[i]['store']}",
                                overflow: TextOverflow.clip, // For text wraping
                                // ignore: prefer_const_constructors
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            // ignore: prefer_const_constructors
                            Divider(
                              color: Colors.white,
                            ),
                            Container(
                              child: Row(children: [
                                Container(
                                  margin: EdgeInsets.only(right: 5),
                                  child: Text("${offers[i]["rate"]}"),
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow[600],
                                )
                              ]),
                            )
                          ],
                        ),
                      ),
                      Row(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Text(
                            "${offers[i]['newPrice']}  ",
                            style: TextStyle(
                              color: Color.fromARGB(255, 37, 179, 136),
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            "${offers[i]['oldPrice']}",
                            style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: Color.fromARGB(255, 37, 179, 136),
                              fontSize: 10,
                            ),
                          )
                        ],
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
  /************************ End Functions Section ************************************* */
}
