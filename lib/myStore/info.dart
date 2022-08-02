// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, list_remove_unrelated_type, must_be_immutable

import 'package:fast_and_yummy/api/api.dart';
import 'package:flutter/material.dart';

import '../ProductInsideStore.dart';
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
  ];

  List<Map> friedChicken = [
    {"image": "images/chk/fele.jpeg", "name": "Broasted fillet-fish"},
    {"image": "images/chk/cris.jpg", "name": "Crispy"},
    {"image": "images/chk/chf.jpg", "name": "Chicken Fingers"},
  ];
  List<Map> fries = [
    {"image": "images/fries/st.jpg", "name": "Standerd"},
    {"image": "images/fries/CP.jpg", "name": "Curly"},
    {"image": "images/fries/ck.jpg", "name": "Crinkle"},
    {"image": "images/fries/tat.jpg", "name": "Tater tots"},
  ];
  List<Map> desserts = [
    {"image": "images/sweets/cookie.jpeg", "name": "Cookies"},
    {"image": "images/sweets/creambrulee.jpeg", "name": "Cream Brulee"},
    {"image": "images/sweets/cup.jpeg", "name": "Cupcake"},
    {"image": "images/sweets/sundae.jpg", "name": "Sundae"},
    {"image": "images/sweets/donut.jpg", "name": "Donut"},
    {"image": "images/sweets/trifle.jpeg", "name": "Trifle"},
  ];
  List<Map> drinks = [
    {"image": "images/drinks/pep.jpg", "name": "Pepsi"},
    {"image": "images/drinks/cap.jpg", "name": "Cappy"},
    {"image": "images/drinks/coc.png", "name": "Coca Cola"},
    {"image": "images/drinks/dr.jpeg", "name": "Original"},
    {"image": "images/drinks/sp.png", "name": "Sprite"},
    {"image": "images/drinks/fan.jpg", "name": "Fanta"},
  ];

  @override
  void initState() {
    getCate();
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

  bringProduct(String tabelName) async {
    var resp = await api.postReq(bringProdectLink, {
      "tableName": tabelName,
      "userID": sharedPref.getString("id"),
    });
    if (resp['status'] == "suc") {
      setState(() {
        find = false;
        productList = resp['data'];
        choice = productList;
      });
    } else {
      print(resp['status']);
      setState(() {
        find = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String toSend = "";
    double earings = 300;
    int myorder = 15;
    int orderFdeliver = 3;
    int orderInWait = 1;
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
                                    "My Orders : $myorder",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Order for delivery : $orderFdeliver",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Ordar in wait : $orderInWait",
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
                widget.lis?['category'] == ""
                    ? Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Text(
                          "You didn't chose categories for your store yet, you can do that from go to store editing",
                          style: TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(255, 102, 102, 102),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : SizedBox(
                        height: 130,
                        width: double.infinity,
                        child: ListView.builder(
                            itemCount: lis2?.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, i) {
                              return MaterialButton(
                                padding: EdgeInsets.all(8),
                                onPressed: () {
                                  print(lis2?[i]["cateName"]);
                                  bringProduct(lis2?[i]["cateName"]);
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          // ignore: prefer_const_literals_to_create_immutables
                                          boxShadow: [
                                            BoxShadow(
                                                color: Color.fromARGB(
                                                    255, 197, 197, 197),
                                                blurRadius: 4)
                                          ],
                                          border: Border.all(
                                              color: Color.fromARGB(
                                                  255, 197, 197, 197),
                                              width: 1),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                  "${categories[i]['image']}"))),
                                      margin: EdgeInsets.only(bottom: 8),
                                      width: 80,
                                      height: 80,
                                    ),
                                    Text(
                                      "${lis2[i]['cateName']}",
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
                        children: listGenerate(toSend),
                      ),
              ],
            ),
    );
  }

  listGenerate(String s) {
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
                      image: AssetImage("images/profile.jpg"))),
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
                    "98 ₪",
                    style: TextStyle(fontSize: 18),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 18,
                        color: Colors.amberAccent,
                      ),
                      Icon(
                        Icons.star,
                        size: 18,
                        color: Colors.amberAccent,
                      ),
                      Icon(
                        Icons.star,
                        size: 18,
                        color: Colors.amberAccent,
                      ),
                      Icon(
                        Icons.star,
                        size: 18,
                        color: Colors.amberAccent,
                      ),
                      Icon(
                        Icons.star_border_outlined,
                        size: 18,
                        color: Colors.amberAccent,
                      ),
                    ],
                  )
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    print(productList[index]["productName"]);
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => ProductInsideStore()),
                    // );
                  },
                  child: Icon(
                    Icons.edit,
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      choice.removeAt(index);
                    });
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
