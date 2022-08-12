// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, list_remove_unrelated_type, must_be_immutable

import 'package:fast_and_yummy/api/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../productPages/ProductInsideStore.dart';
import '../api/linkapi.dart';
import '../main.dart';

class InfoMyStore extends StatefulWidget {
  dynamic lis;
  InfoMyStore(this.lis, {Key? key}) : super(key: key);

  @override
  State<InfoMyStore> createState() => _InfoMyStoreState();
}

class _InfoMyStoreState extends State<InfoMyStore> {
  List<Map> categories = [
    {"image": "images/cat/CH.jpeg", "name": "Fried chicken"},
    {"image": "images/cat/bot.jpg", "name": "French fries"},
    {"image": "images/cat/des.jpeg", "name": "Desserts"},
    {"image": "images/cat/drink.jpg", "name": "Soft drinks"},
    {"image": "images/cat/drink.jpg", "name": "Soft drinks"},
  ];
  String? cateNAME;
  deletePoduct(String number, String image) async {
    var resp = await api.postReq(deleteproductLink, {
      "tableName": cateNAME,
      "productID": number,
      "userID": sharedPref.getString("id"),
      "imagename": image,
    });
    if (resp['status'] == "suc") {
    } else {
      setState(() {});
    }
  }

  int wait = 0, deliv = 0;
  List<dynamic> myOrderList = [];

  bringAllOrders() async {
    var respo = await api
        .postReq(storeOrderLink, {"storeID": sharedPref.getString("id")});
    if (respo['status'] == "suc") {
      setState(() {
        myOrderList = respo['data'];
      });

      for (int i = 0; i < myOrderList.length; i++) {
        if (myOrderList[i]['status'] == "In wait") {
          setState(() {
            wait++;
          });
        } else if (myOrderList[i]['status'] == "In delivery") {
          setState(() {
            deliv++;
          });
        }
      }
    } else {}
  }

  @override
  void initState() {
    getCate();
    bringAllOrders();
    super.initState();
  }

  dynamic lis2;
  dynamic productList;
  Api api = Api();
  dynamic choice = [];
  bool loading = false;
  bool find = false;
  Color color = Color.fromARGB(255, 37, 179, 136);
  getCate() async {
    setState(() {
      loading = true;
    });
    var resp = await api.postReq(bringAllCate, {});
    setState(() {
      loading = false;
    });
    if (resp['status'] == "suc") {
      setState(() {
        lis2 = resp['data'];
      });
    } else {}
  }

  bringProduct(String tableName) async {
    setState(() {
      loading = true;
    });
    var resp = await api.postReq(bringProdectLink, {
      "tableName": tableName,
      "userID": sharedPref.getString("id"),
    });
    setState(() {
      loading = false;
    });
    if (resp['status'] == "suc") {
      setState(() {
        find = false;
        productList = resp['data'];
        choice = productList;
      });
    } else {
      setState(() {
        find = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String toSend = "";
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(20),
      color: Color.fromARGB(255, 247, 247, 247),
      width: size.width,
      child: loading
          ? SizedBox(
              height: size.height,
              width: size.width,
              child: Center(
                child: CircularProgressIndicator(color: color),
              ),
            )
          : Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 218, 218, 218),
                              blurRadius: 5,
                              spreadRadius: 2,
                            )
                          ],
                        ),
                        height: 150,
                        child: loading
                            ? SizedBox(
                                height: size.height,
                                width: size.width,
                                child: Center(
                                  child:
                                      CircularProgressIndicator(color: color),
                                ),
                              )
                            : Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "My Orders : ${myOrderList.length}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Order for delivery : $deliv",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Ordar in wait : $wait",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 218, 218, 218),
                              blurRadius: 5,
                              spreadRadius: 2,
                            )
                          ],
                        ),
                        height: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Total Earings ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "${widget.lis?['earrings']} ₪",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: Colors.black,
                  height: 70,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Categories",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 130,
                  width: double.infinity,
                  child: ListView.builder(
                      itemCount: lis2?.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, i) {
                        return MaterialButton(
                          padding: EdgeInsets.all(8),
                          onPressed: () {
                            setState(() {
                              cateNAME = lis2?[i]["cateName"];
                            });
                            bringProduct(lis2?[i]["cateName"]);
                          },
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: Color.fromARGB(
                                              255, 197, 197, 197),
                                          blurRadius: 4)
                                    ],
                                    border: Border.all(
                                        color:
                                            Color.fromARGB(255, 197, 197, 197),
                                        width: 1),
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                            "${categories[i]['image']}"))),
                                margin: EdgeInsets.only(bottom: 8),
                                width: 80,
                                height: 80,
                              ),
                              Text(
                                "${lis2?[i]['cateName']}",
                                style: TextStyle(fontSize: 12),
                              )
                            ],
                          ),
                        );
                      }),
                ),
                find
                    ? Container(
                        margin: EdgeInsets.only(top: 15),
                        child: Text(
                          "There is no proudcts for this category in your store",
                          style: TextStyle(
                              color: Color.fromARGB(255, 121, 121, 121),
                              fontSize: 13),
                        ),
                      )
                    : Column(
                        children: listGenerate(),
                      ),
                SizedBox(
                  height: 40,
                )
              ],
            ),
    );
  }

  listGenerate() {
    return List.generate(choice.length, (index) {
      return Container(
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.only(bottom: 15),
        width: double.infinity,
        height: 120,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Color.fromARGB(255, 197, 197, 197), blurRadius: 4)
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
                      image: NetworkImage(
                          "$imageRoot/${productList[index]['image']}"))),
            ),
            SizedBox(
              width: 10,
            ),
            SizedBox(
              width: 170,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productList[index]["productName"],
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    "${productList[index]['price']} \$",
                    style: TextStyle(fontSize: 18),
                  ),
                  RatingBarIndicator(
                    rating: double.parse(productList[index]['rate']),
                    itemSize: 20,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                  )
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductInsideStore(
                              productList?[index], cateNAME!)),
                    );
                  },
                  child: Icon(
                    Icons.edit,
                  ),
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Are you sure ?"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  MaterialButton(
                                    color: color,
                                    onPressed: () {
                                      setState(() {
                                        deletePoduct(
                                          productList[index]["productID"],
                                          productList[index]["image"],
                                        );

                                        bringProduct(cateNAME!);
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(Icons.check, color: Colors.white),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Yes",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                  MaterialButton(
                                    color: Colors.red,
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Icon(Icons.close, color: Colors.white),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "No",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                  ),
                ),
              ],
            )
          ],
        ),
      );
    });
  }
}
