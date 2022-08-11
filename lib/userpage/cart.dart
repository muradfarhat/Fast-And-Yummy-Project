// ignore_for_file: prefer_const_constructors, slash_for_doc_comments

import 'dart:io';

import 'package:fast_and_yummy/api/linkapi.dart';
import 'package:fast_and_yummy/main.dart';
import 'package:fast_and_yummy/userpage/orderMapChoose.dart';
import 'package:flutter/material.dart';
import 'package:fast_and_yummy/api/api.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  List myCart2 = [];
  List cart = [];

  /********************** Start Api Functions ********************************* */
  Api api = Api(); // Create API SELECT SCOPE_IDENTITY()

  bringMyCart() async {
    setState(() {
      loading = true;
    });
    var resp =
        await api.postReq(userCartLink, {"userID": sharedPref.getString("id")});
    setState(() {
      loading = false;
    });
    if (resp['status'] == "suc") {
      setState(() {
        myCart2 = resp['products'];
        cart = resp['data'];
      });
    }
  }

  deleteCartFromCartTable(String id) async {
    await api.postReq(deleteFromUserCartTable, {"id": id});
  }

  updateCartTable(String id, String quantity) async {
    await api.postReq(updateToCartTable, {"id": id, "quantity": quantity});
  }

  @override
  void initState() {
    bringMyCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color color = Color.fromARGB(255, 37, 179, 136);
    Size size = MediaQuery.of(context).size;
    return loading
        ? SizedBox(
            height: size.height,
            width: size.width,
            child: Center(
              child: CircularProgressIndicator(color: color),
            ),
          )
        : Stack(
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
                          itemCount: myCart2.length,
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
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 25),
                                    width: double.infinity,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              "$imageRoot/${myCart2[i]['image']}")),
                                      border: Border.all(
                                          color: Color.fromARGB(
                                              255, 197, 197, 197),
                                          width: 1),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 40, top: 10),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          deleteCartFromCartTable(
                                              cart[i]["id"]);
                                          myCart2.removeAt(i);
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Color.fromARGB(
                                                  255, 197, 197, 197),
                                              width: 1),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    width: double.infinity,
                                    height: 120,
                                    margin: EdgeInsets.only(
                                        top: 150,
                                        right: 50,
                                        left: 50,
                                        bottom: 15),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      // ignore: prefer_const_literals_to_create_immutables
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color.fromARGB(
                                                255, 197, 197, 197),
                                            blurRadius: 4)
                                      ],
                                      border: Border.all(
                                          color: Colors.white, width: 1),
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
                                                  "${myCart2[i]["productName"]}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20),
                                                ),
                                                Text(
                                                    "${myCart2[i]["storeName"]}",
                                                    style: TextStyle(
                                                        color: Colors.grey)),
                                                Row(
                                                  children: [
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            right: 3),
                                                        child: Text(double
                                                                .parse(myCart2[
                                                                    i]["rate"])
                                                            .toStringAsFixed(
                                                                2))),
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
                                            margin: EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: VerticalDivider(
                                              color: Colors.grey,
                                              width: 2,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                            flex: 2,
                                            child: Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 5),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Container(
                                                    width: double.infinity,
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      "\$ ${clacEachOrderPrice(myCart2[i]["price"], cart[i]["quantity"]).toStringAsFixed(1)}",
                                                      style: TextStyle(
                                                          fontSize: 22),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    splashColor: Colors.grey,
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              ChooseLocation(
                                                                  myCart2[i],
                                                                  cart[
                                                                      i]), //OneOrder(),
                                                        ),
                                                      );
                                                    },
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5),
                                                      height: 40,
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          color: Colors
                                                              .yellow[500]),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        // ignore: prefer_const_literals_to_create_immutables
                                                        children: [
                                                          Text(
                                                            "Order",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black),
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
                                            margin: EdgeInsets.symmetric(
                                                vertical: 10),
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
                                                        cart[i]["quantity"] =
                                                            (double.parse(cart[
                                                                            i][
                                                                        "quantity"]) +
                                                                    1)
                                                                .toStringAsFixed(
                                                                    2);
                                                      });
                                                      updateCartTable(
                                                          cart[i]["id"]
                                                              .toString(),
                                                          cart[i]["quantity"]
                                                              .toString());
                                                    },
                                                    icon: Icon(Icons.add)),
                                                Text("${cart[i]["quantity"]}"),
                                                IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        if ((double.parse(cart[
                                                                            i][
                                                                        "quantity"]) -
                                                                    1) *
                                                                double.parse(
                                                                    myCart2[i][
                                                                        "price"]) >=
                                                            double.parse(
                                                                myCart2[i][
                                                                    "price"])) {
                                                          cart[i]["quantity"] =
                                                              (double.parse(cart[
                                                                              i]
                                                                          [
                                                                          "quantity"]) -
                                                                      1)
                                                                  .toString();
                                                        }
                                                      });
                                                      updateCartTable(
                                                          cart[i]["id"]
                                                              .toString(),
                                                          cart[i]["quantity"]
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
              ),
            ],
          );
  }

  /*********************** Start Functions Section ************************************ */
  double totalPriceFun() {
    double totalPrice = 0.0;
    for (int i = 0; i < myCart2.length; i++) {
      totalPrice += (double.parse(myCart2[i]["price"]) *
          double.parse(cart[i]["quantity"]));
    }
    return totalPrice;
  }

  double clacEachOrderPrice(String price, String quantity) {
    double total = double.parse(price) * double.parse(quantity);
    return total;
  }
  /*********************** End Functions Section ************************************ */
}
