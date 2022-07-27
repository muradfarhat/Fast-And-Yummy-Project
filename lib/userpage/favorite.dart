// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class favorite extends StatefulWidget {
  favorite({Key? key}) : super(key: key);

  @override
  State<favorite> createState() => _favoriteState();
}

class _favoriteState extends State<favorite> {
  List<Map> myFav = [
    {
      "foodName": "KFC",
      "storeName": "Food For You",
      "rate": "4.0",
      "image": "images/kfc.png",
      "fav": true
    },
    {
      "foodName": "Burger",
      "storeName": "Food For You",
      "rate": "4.0",
      "image": "images/burger.jpg",
      "fav": true
    },
    {
      "foodName": "Pizza", // 12 char just
      "storeName": "Food For You",
      "rate": "4.0",
      "image": "images/pizza.jpg",
      "fav": true
    },
  ];

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("images/favorite.jpg"))),
          ),
          Container(
            margin: EdgeInsets.only(top: 5, left: 5),
            child: IconButton(
                onPressed: () => Scaffold.of(context).openDrawer(),
                icon: Icon(
                  Icons.menu,
                  color: Colors.white,
                  size: 35,
                )),
          ),
          Container(
            margin: EdgeInsets.only(top: 150),
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: myFav.length,
                itemBuilder: (context, i) {
                  return MaterialButton(
                    onPressed: () {},
                    child: Container(
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.only(bottom: 10, top: 10),
                      width: double.infinity,
                      height: 110,
                      decoration: BoxDecoration(
                        color: Colors.white,
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
                      ),
                      child: Row(children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color.fromARGB(255, 197, 197, 197),
                                    width: 1),
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage("${myFav[i]['image']}"))),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${myFav[i]["foodName"]}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Container(
                                  //margin: EdgeInsets.only(top: 5, bottom: 5),
                                  child: Text("${myFav[i]["storeName"]}",
                                      style: TextStyle(color: Colors.grey)),
                                ),
                                Row(
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(right: 3),
                                        child: Text("${myFav[i]["rate"]}")),
                                    Icon(
                                      Icons.star,
                                      color: Colors.amberAccent,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: IconButton(
                              color: myFav[i]["fav"] == false
                                  ? Colors.black
                                  : Colors.red,
                              iconSize: 25,
                              icon: myFav[i]["fav"] == false
                                  ? Icon(Icons.favorite_border_outlined)
                                  : Icon(Icons.favorite),
                              onPressed: () {
                                setState(() {
                                  if (myFav[i]["fav"] == false) {
                                    myFav[i]["fav"] = true;
                                  } else {
                                    myFav[i]["fav"] = false;
                                  }
                                });
                              },
                            ),
                          ),
                        )
                      ]),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
