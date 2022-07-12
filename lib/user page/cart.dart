// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';

class cart extends StatefulWidget {
  cart({Key? key}) : super(key: key);

  @override
  State<cart> createState() => _cartState();
}

class _cartState extends State<cart> {
  List<Map> myCart = [
    {
      "foodName": "Burger",
      "storeName": "My Food",
      "price": 5.99,
      "number": 2,
      "rate": "5.0",
      "image": "images/burger.jpg"
    },
    {
      "foodName": "Pizza",
      "storeName": "My Food",
      "price": 10.00,
      "number": 1,
      "rate": "4.0",
      "image": "images/pizza.jpg"
    },
    {
      "foodName": "KFC",
      "storeName": "My Food",
      "price": 7.99,
      "number": 3,
      "rate": "4.0",
      "image": "images/kfc.png"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("images/cart.jpg"))),
              ),
              Container(
                margin: EdgeInsets.only(top: 150),
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: myCart.length,
                    itemBuilder: (context, i) {
                      return Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 25),
                            width: double.infinity,
                            height: 200,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage("${myCart[i]['image']}")),
                              border: Border.all(
                                  color: Color.fromARGB(255, 197, 197, 197),
                                  width: 1),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 40, top: 10),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  myCart.removeAt(i);
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Color.fromARGB(255, 197, 197, 197),
                                      width: 1),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Icon(
                                  Icons.close,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            width: double.infinity,
                            height: 120,
                            margin: EdgeInsets.only(
                                top: 150, right: 50, left: 50, bottom: 15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              // ignore: prefer_const_literals_to_create_immutables
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromARGB(255, 197, 197, 197),
                                    blurRadius: 4)
                              ],
                              border: Border.all(color: Colors.white, width: 1),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          "${myCart[i]["foodName"]}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        Text("${myCart[i]["storeName"]}",
                                            style:
                                                TextStyle(color: Colors.grey)),
                                        Row(
                                          children: [
                                            Container(
                                                margin:
                                                    EdgeInsets.only(right: 3),
                                                child: Text(
                                                    "${myCart[i]["rate"]}")),
                                            Icon(
                                              Icons.star,
                                              color: Colors.amberAccent,
                                            )
                                          ],
                                        )
                                      ],
                                    )),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    child: VerticalDivider(
                                      color: Colors.grey,
                                      width: 2,
                                    ),
                                  ),
                                ),
                                Expanded(
                                    flex: 2,
                                    child: Container(
                                      margin: EdgeInsets.symmetric(vertical: 5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            alignment: Alignment.center,
                                            child: Text(
                                              "\$ ${clacEachOrderPrice(myCart[i]["price"], myCart[i]["number"]).toStringAsFixed(2)}",
                                              style: TextStyle(fontSize: 22),
                                            ),
                                          ),
                                          InkWell(
                                            splashColor: Colors.grey,
                                            onTap: () {},
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5),
                                              height: 40,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color: Colors.yellow[500]),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                // ignore: prefer_const_literals_to_create_immutables
                                                children: [
                                                  Text(
                                                    "Order",
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                  Icon(
                                                    Icons.shopping_cart,
                                                    size: 20,
                                                    color: Colors.black,
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    child: VerticalDivider(
                                      color: Colors.grey,
                                      width: 2,
                                    ),
                                  ),
                                ),
                                Expanded(
                                    flex: 1,
                                    child: Column(
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                myCart[i]["number"]++;
                                              });
                                            },
                                            icon: Icon(Icons.add)),
                                        Text("${myCart[i]["number"]}"),
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                if (myCart[i]["number"] <= 1) {
                                                } else {
                                                  myCart[i]["number"]--;
                                                }
                                              });
                                            },
                                            icon: Icon(Icons.minimize))
                                      ],
                                    )),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.bottomRight,
          margin: EdgeInsets.all(15),
          child: InkWell(
            onTap: () {},
            child: Container(
              width: 120,
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.yellow[500]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "\$ ${totalPriceFun().toStringAsFixed(2)}",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  Icon(
                    Icons.shopping_cart,
                    size: 25,
                    color: Colors.black,
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  /*********************** Start Functions Section ************************************ */
  double totalPriceFun() {
    double totalPrice = 0.0;
    for (int i = 0; i < myCart.length; i++) {
      totalPrice += (myCart[i]["price"] * myCart[i]["number"]);
    }
    return totalPrice;
  }

  double clacEachOrderPrice(double price, int quantity) {
    double total = price * quantity.toDouble();
    return total;
  }
  /*********************** End Functions Section ************************************ */
}
