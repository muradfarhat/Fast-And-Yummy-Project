// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../detialscreen.dart';

class PageContent extends StatefulWidget {
  const PageContent({Key? key}) : super(key: key);

  @override
  State<PageContent> createState() => _PageContentState();
}

class _PageContentState extends State<PageContent> {
  List<Map> categories = [
    {"image": "images/food.jpg", "name": "Cate. Name"},
    {"image": "images/food.jpg", "name": "Cate. Name"},
    {"image": "images/food.jpg", "name": "Cate. Name"},
    {"image": "images/food.jpg", "name": "Cate. Name"},
    {"image": "images/food.jpg", "name": "Cate. Name"}
  ];
  List<Map> offers = [
    {
      "image": "images/burger.jpg",
      "name": "Food Name",
      "store": "Store Name",
      "newPrice": "\$ 8.99",
      "oldPrice": "\$ 10.00"
    },
    {
      "image": "images/burger.jpg",
      "name": "Food Name",
      "store": "Store Name",
      "newPrice": "\$ 8.99",
      "oldPrice": "\$ 10.00"
    },
    {
      "image": "images/burger.jpg",
      "name": "Food Name",
      "store": "Store Name",
      "newPrice": "\$ 8.99",
      "oldPrice": "\$ 10.00"
    },
    {
      "image": "images/burger.jpg",
      "name": "Food Name",
      "store": "Store Name",
      "newPrice": "\$ 8.99",
      "oldPrice": "\$ 10.00"
    }
  ];
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
      "image": "images/pizza.jpg",
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
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          /*********************************** Start Categories Section ******************************* */
          ListTile(
            title: Text(
              "Categories",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            height: 130,
            width: double.infinity,
            child: ListView.builder(
                itemCount: categories.length,
                scrollDirection: Axis.horizontal,
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
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              // ignore: prefer_const_literals_to_create_immutables
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromARGB(255, 197, 197, 197),
                                    blurRadius: 4)
                              ],
                              border: Border.all(
                                  color: Color.fromARGB(255, 197, 197, 197),
                                  width: 1),
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image:
                                      AssetImage("${categories[i]['image']}"))),
                          margin: EdgeInsets.only(bottom: 8),
                          width: 80,
                          height: 80,
                        ),
                        Text(
                          "${categories[i]['name']}",
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                  );
                }),
          ),
          /*********************************** End Categories Section ******************************* */
          /************************************* Start Offers Section **************************** */
          ListTile(
            title: Text(
              "Offers",
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
                          title: Text("Test text"),
                          actions: [Text("data")],
                        );
                      });
                },
                child: Text(
                  "View All",
                  style: TextStyle(
                      color: Color.fromARGB(255, 37, 179, 136), fontSize: 12),
                )),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            //color: Colors.red,
            height: 140,
            width: double.infinity,
            child: ListView.builder(
                itemCount: 4,
                scrollDirection: Axis.horizontal,
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
                        width: 250,
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
                                      image:
                                          AssetImage("${offers[i]['image']}"))),
                            ),
                            Container(
                              width: 120,
                              padding:
                                  EdgeInsets.only(top: 15, left: 10, right: 10),
                              child: Column(
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  Container(
                                    width: double.infinity,
                                    child: Text(
                                      "${offers[i]['name']}",
                                      overflow:
                                          TextOverflow.clip, // For text wraping
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 5),
                                    width: double.infinity,
                                    child: Text(
                                      "${offers[i]['store']}",
                                      overflow:
                                          TextOverflow.clip, // For text wraping
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.white,
                                  ),
                                  Row(
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: [
                                      Text(
                                        "${offers[i]['newPrice']}  ",
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 37, 179, 136),
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        "${offers[i]['oldPrice']}",
                                        style: TextStyle(
                                          decoration:
                                              TextDecoration.lineThrough,
                                          color:
                                              Color.fromARGB(255, 37, 179, 136),
                                          fontSize: 10,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        )),
                  );
                }),
          ),
          /************************************* End Offers Section **************************** */
          /************************************* Start Suggestions Section **************************** */
          ListTile(
            title: Text(
              "Suggestions you may like",
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
                          title: Text("Test text"),
                          actions: [Text("data")],
                        );
                      });
                },
                child: Text(
                  "View All",
                  style: TextStyle(
                      color: Color.fromARGB(255, 37, 179, 136), fontSize: 12),
                )),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            //color: Colors.red,
            height: 210,
            width: double.infinity,
            child: ListView.builder(
                itemCount: 3,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, i) {
                  return MaterialButton(
                    padding: EdgeInsets.all(8),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Detialscreen()),
                      );
                    },
                    child: Container(
                        padding: EdgeInsets.all(5),
                        width: 300,
                        height: 190,
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
                              height: 180,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image:
                                          AssetImage("${sugg[i]['image']}"))),
                            ),
                            Container(
                              width: 120,
                              padding:
                                  EdgeInsets.only(top: 15, left: 10, right: 10),
                              child: Column(
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  Container(
                                    width: double.infinity,
                                    child: Text(
                                      "${sugg[i]['name']}",
                                      overflow:
                                          TextOverflow.clip, // For text wraping
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 5),
                                    width: double.infinity,
                                    child: Text(
                                      "${sugg[i]['store']}",
                                      overflow:
                                          TextOverflow.clip, // For text wraping
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
                                        color:
                                            Color.fromARGB(255, 37, 179, 136),
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
          ),
          /************************************* End Suggestions Section **************************** */
        ],
      ),
    );
  }

  Icon iconStar(int index, String star) {
    return Icon(
      sugg[index][star] == 1 ? Icons.star : Icons.star_border_outlined,
      //Icons.star,
      size: 20,
      color: Colors.amberAccent,
    );
  }
}
