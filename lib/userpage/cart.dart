// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:fast_and_yummy/api/linkapi.dart';
import 'package:fast_and_yummy/main.dart';
import 'package:fast_and_yummy/userpage/oneOrader.dart';
import 'package:fast_and_yummy/userpage/orderMapChoose.dart';
import 'package:flutter/material.dart';
import 'package:fast_and_yummy/api/api.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  List<dynamic> myCart = [];
  List<dynamic> cartList = [];

  /********************** Start Api Functions ********************************* */
  Api api = Api(); // Create API SELECT SCOPE_IDENTITY()
  bringAllCart() async {
    var response = await api
        .postReq(bringUserCartProducts, {"id": sharedPref.getString("id")});
    if (response['status'] == "suc") {
      setState(() {
        cartList = response['data'];
      });
      forLoopForProduct();
    }
  }

  bringProductFromCate(String cateID, String productID, String quantity) async {
    var resp = await api.postReq(bringNameOfCate, {"cateID": cateID});

    String? cateName;
    if (resp['status'] == "suc") {
      cateName = resp['data'];
    }
    cateName = cateName!.toLowerCase();

    var response = await api
        .postReq(bringProducts, {"id": productID, "cateName": cateName});
    if (response['status'] == "suc") {
      setState(() {
        myCart.add({
          "productID": response['data'][0]['productID'],
          "foodName": response['data'][0]['productName'],
          "storeName": response['data'][0]['storeName'],
          "rate": response['data'][0]['rate'],
          "image": "php/images/${response['data'][0]['image']}",
          "userID": response['data'][0]['userID'],
          "price": double.parse(response['data'][0]['price']),
          "totalBuy": response['data'][0]['totalBuy'],
          "number": int.parse(quantity)
        });
      });
    }
  }

  forLoopForProduct() {
    for (int i = 0; i < cartList.length; i++) {
      bringProductFromCate(cartList[i]['cateID'], cartList[i]['orderID'],
          cartList[i]['quantity']);
    }
  }

  deleteCartFromCartTable(String id) async {
    var response = await api.postReq(deleteFromUserCartTable, {"id": id});
  }

  updateCartTable(String id, String quantity) async {
    var response =
        await api.postReq(updateToCartTable, {"id": id, "quantity": quantity});
  }

/********************** End Api Functions ********************************* */
  @override
  void initState() {
    bringAllCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
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
                    itemCount: myCart.length,
                    itemBuilder: (context, i) {
                      return InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("data $i"),
                                );
                              });
                        },
                        child: Stack(
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
                                    deleteCartFromCartTable(cartList[i]["id"]);
                                    myCart.removeAt(i);
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color:
                                            Color.fromARGB(255, 197, 197, 197),
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
                                border:
                                    Border.all(color: Colors.white, width: 1),
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
                                              style: TextStyle(
                                                  color: Colors.grey)),
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
                                      margin:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: VerticalDivider(
                                        color: Colors.grey,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 5),
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
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        chooseLocation(
                                                            myCart[i]['userID'],
                                                            cartList[i]
                                                                ['cateID'],
                                                            myCart[i]
                                                                ['productID'],
                                                            cartList[i][
                                                                'quantity']), //OneOrder(),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 5),
                                                height: 40,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
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
                                      margin:
                                          EdgeInsets.symmetric(vertical: 10),
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
                                                updateCartTable(
                                                    cartList[i]["id"],
                                                    myCart[i]["number"]
                                                        .toString());
                                              },
                                              icon: Icon(Icons.add)),
                                          Text("${myCart[i]["number"]}"),
                                          IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  if (myCart[i]["number"] <=
                                                      1) {
                                                  } else {
                                                    myCart[i]["number"]--;
                                                  }
                                                });
                                                updateCartTable(
                                                    cartList[i]["id"],
                                                    myCart[i]["number"]
                                                        .toString());
                                              },
                                              icon: Icon(Icons.minimize))
                                        ],
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.bottomLeft,
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
