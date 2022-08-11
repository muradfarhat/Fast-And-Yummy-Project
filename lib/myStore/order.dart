// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:fast_and_yummy/main.dart';
import 'package:flutter/material.dart';

import '../api/api.dart';
import '../api/linkapi.dart';

class OrderMyStore extends StatefulWidget {
  const OrderMyStore({Key? key}) : super(key: key);

  @override
  State<OrderMyStore> createState() => _OrderMyStoreState();
}

class _OrderMyStoreState extends State<OrderMyStore> {
  @override
  void initState() {
    bringAllOrders();
    super.initState();
  }

  Api api = Api();
  List<dynamic> myOrderList = [];
  List<dynamic> products = [];
  bringAllOrders() async {
    var respo = await api
        .postReq(storeOrderLink, {"storeID": sharedPref.getString("id")});
    if (respo['status'] == "suc") {
      setState(() {
        myOrderList = respo['data'];
        products = respo['products'];
      });
    } else {}
  }

  reject(String orderN) async {
    var respo = await api.postReq(rejectOrderLink, {"id": orderN});
    if (respo['status'] == "suc") {
      bringAllOrders();
    } else {}
  }

  changeState(String orderN) async {
    var respo = await api.postReq(orderStateLink, {"id": orderN});
    if (respo['status'] == "suc") {
      bringAllOrders();
    } else {}
  }

  List<Map> myOrder = [
    {
      "name": "Chicken Fingers",
      "image": "images/chk/chf.jpg",
      "price": 8.99,
      "number": 1,
      "time": "1-2 PM,Wen",
      "ready": false,
    },
    {
      "name": "Crispy",
      "image": "images/chk/cris.jpg",
      "price": 10.99,
      "number": 2,
      "time": "6-7 PM,Today",
      "ready": false,
    },
    {
      "name": "Broasted fillet-fish",
      "image": "images/chk/fele.jpeg",
      "price": 7.99,
      "number": 3,
      "time": "Now",
      "ready": false,
    }
  ];

  bool delevState = false;
  Color color = Colors.black;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return myOrderList.isEmpty
        ? SizedBox(
            height: size.height / 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "No order in your store",
                  style: TextStyle(fontSize: 25, color: Colors.grey),
                )
              ],
            ),
          )
        : Container(
            padding: EdgeInsets.all(20),
            color: Color.fromARGB(255, 247, 247, 247),
            width: size.width,
            height: 500,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  ...listGenerate(),
                  SizedBox(
                    height: 80,
                  )
                ],
              ),
            ));
  }

  listGenerate() {
    return List.generate(myOrderList.length, (index) {
      return Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image:
                      NetworkImage("$imageRoot/${products[index]['image']}")),
              border: Border.all(
                  color: Color.fromARGB(255, 197, 197, 197), width: 1),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Do you want really to reject this order?"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                MaterialButton(
                                  color: Color.fromARGB(255, 37, 179, 136),
                                  onPressed: () async {
                                    setState(() {
                                      if (myOrderList[index]['status'] !=
                                          "In delivery") {
                                        reject(myOrderList[index]['id']);
                                        Navigator.pop(context);
                                      } else {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text(
                                                "You can't reject it, it's in delivery",
                                                style: TextStyle(fontSize: 18),
                                              ),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      MaterialButton(
                                                        color: Colors.orange,
                                                        onPressed: () {
                                                          setState(() {
                                                            Navigator.pop(
                                                                context);
                                                          });
                                                        },
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Icon(Icons.check,
                                                                color: Colors
                                                                    .white),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(
                                                              "Ok",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
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
                                      }
                                    });
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
                child: Container(
                    margin: EdgeInsets.only(left: 40, top: 15),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      "Reject",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )),
              ),
              InkWell(
                onTap: () {
                  if (myOrderList[index]['status'] != "In delivery") {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Is it ready ?"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  MaterialButton(
                                    color: Color.fromARGB(255, 37, 179, 136),
                                    onPressed: () {
                                      setState(() {
                                        changeState(myOrderList[index]['id']);
                                        Navigator.pop(context);
                                      });
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
                  }
                },
                child: Container(
                    margin: EdgeInsets.only(right: 40, top: 15),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: myOrderList[index]["status"] == "In wait"
                              ? Colors.yellow
                              : myOrderList[index]["status"] == "In delivery"
                                  ? Colors.orange
                                  : Colors.green,
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 5),
                            child: Text(
                              myOrderList[index]["status"],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ))
                      ],
                    )),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            height: 120,
            margin: EdgeInsets.only(top: 150, right: 50, left: 50, bottom: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Color.fromARGB(255, 197, 197, 197), blurRadius: 4)
              ],
              border: Border.all(color: Colors.white, width: 1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          products[index]['productName'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
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
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: Text(
                              "${products[index]['price']} \$",
                              style: TextStyle(fontSize: 22),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("Quantity : "),
                              Text("${myOrderList[index]['quantity']}"),
                            ],
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "Order Time",
                                  style: TextStyle(color: Colors.green[800]),
                                ),
                                Text("${myOrderList[index]['time']}",
                                    style: TextStyle(color: Colors.green[800]))
                              ],
                            ),
                          )
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ],
      );
    });
  }
}
