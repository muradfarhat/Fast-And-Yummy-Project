// ignore_for_file: prefer_const_constructors

import 'package:fast_and_yummy/userpage/myOrderMap.dart';
import 'package:flutter/material.dart';
import 'package:fast_and_yummy/api/api.dart';
import 'package:fast_and_yummy/api/linkapi.dart';
import 'package:fast_and_yummy/main.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  Color basicColor = const Color.fromARGB(255, 37, 179, 136);
  List<dynamic> myOrder = [];
  List<dynamic> myOrderList = [];
  Color color = Color.fromARGB(255, 37, 179, 136);
  /********************** Start Api Functions ********************************* */
  Api api = Api(); // Create API SELECT SCOPE_IDENTITY()
  bringAllOrders() async {
    var respo = await api
        .postReq(bringUserMyOrdersProducts, {"id": sharedPref.getString("id")});

    if (respo['status'] == "suc") {
      setState(() {
        myOrderList = respo['data'];
      });
      forLoopForBringProduct();
    } else {}
  }

  setEarnings(String id, String storeID, String earn) async {
    var respo = await api
        .postReq(earnLink, {"id": id, "storeID": storeID, "earn": earn});

    if (respo['status'] == "suc") {
      setState(() {
        print("Nice");
      });
    } else {}
  }

  bringProductFromMyOrder(
      String cateID, String productID, String quantity, int delivery) async {
    var resp = await api.postReq(bringNameOfCate, {"cateID": cateID});

    String? cateName;
    if (resp['status'] == "suc") {
      cateName = resp['data'];
    }
    cateName = cateName!.toLowerCase();

    var response = await api
        .postReq(bringProducts, {"id": productID, "cateName": cateName});
    if (response['status'] == "suc") {
      double qun = double.parse(quantity);
      setState(() {
        myOrder.add({
          "productID": response['data'][0]['productID'],
          "name": response['data'][0]['productName'],
          "store": response['data'][0]['storeName'],
          "rate": response['data'][0]['rate'],
          "image": response['data'][0]['image'],
          "userID": response['data'][0]['userID'],
          "price": double.parse(response['data'][0]['price']),
          "totalBuy": response['data'][0]['totalBuy'],
          "number": qun.toInt(), //int.parse(quantity),
          "cancel": false,
          "delivery": delivery
        });
      });
    }
  }

  forLoopForBringProduct() {
    for (int i = 0; i < myOrderList.length; i++) {
      bringProductFromMyOrder(
          myOrderList[i]['cateID'],
          myOrderList[i]['orderID'],
          myOrderList[i]['quantity'],
          ifDelivery(myOrderList[i]['status']));
    }
  }

  deleteFromMyOrder(String ProductID) async {
    var resp = await api.postReq(deleteFromMyOrderTable, {"id": ProductID});
  }

  int ifDelivery(String status) {
    int state = 0;
    if (status == "In delivery") {
      state = 2;
    } else if (status == "In wait") {
      state = 0;
    } else if (status == "deliverd") {
      state = 1;
    }
    return state;
  }

/********************** End Api Functions ********************************* */

  @override
  void initState() {
    bringAllOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey =
        new GlobalKey<ScaffoldState>(); // For snackBar

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
                    image: AssetImage("images/myOrders.jpg"))),
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
                itemCount: myOrder.length,
                itemBuilder: (context, i) {
                  return InkWell(
                    onTap: () {
                      if (myOrder[i]["delivery"] == 2) {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: ((context) {
                          return myOrderMap(
                              myOrder[i]['userID'],
                              myOrderList[i]['deliveryManID'],
                              myOrderList[i]['latitude'],
                              myOrderList[i]['longitude'],
                              myOrderList[i]['cityLocation'],
                              myOrder[i]['name'],
                              clacEachOrderPrice(
                                      myOrder[i]["price"], myOrder[i]["number"])
                                  .toStringAsFixed(2));
                        })));
                      } else {
                        cancelOrderMSG("Order not on way !");
                      }
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
                                image: NetworkImage(
                                    "$imageRoot/${myOrder[i]['image']}")),
                            border: Border.all(
                                color: Color.fromARGB(255, 197, 197, 197),
                                width: 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Visibility(
                                  visible:
                                      myOrderList[i]['status'] == "deliverd" &&
                                              myOrderList[i]['receipt'] == "no"
                                          ? true
                                          : false,
                                  child: InkWell(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title:
                                                  Text("Has it been received?"),
                                              actions: [
                                                MaterialButton(
                                                  onPressed: () {
                                                    setEarnings(
                                                        myOrderList[i]["id"],
                                                        myOrderList[i]
                                                            ["storeID"],
                                                        myOrder[i]["price"]
                                                            .toString());
                                                    Navigator.of(context).pop();
                                                  },
                                                  color: color,
                                                  child: Text(
                                                    "Yes",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text(
                                                      "No",
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    ))
                                              ],
                                            );
                                          });
                                    },
                                    child: Container(
                                        margin:
                                            EdgeInsets.only(left: 40, top: 15),
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: color,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Text(
                                          "It was received",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ),
                                ),
                                Visibility(
                                  visible:
                                      myOrderList[i]['status'] == "deliverd"
                                          ? false
                                          : true,
                                  child: InkWell(
                                    onTap: () {
                                      if (myOrder[i]["delivery"] == 1 ||
                                          myOrder[i]["delivery"] == 2) {
                                        cancelOrderMSG(
                                            "Cannot Cancel deliverd order");
                                      } else {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: Text(
                                                    "Are you sure you want to cancel this order?"),
                                                content: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Divider(),
                                                    Text(myOrder[i]["name"]),
                                                    Row(
                                                      children: [
                                                        Text(
                                                            "\$ ${clacEachOrderPrice(myOrder[i]["price"], myOrder[i]["number"]).toStringAsFixed(2)}"),
                                                        Text(
                                                            "  |  Quantity: ${myOrder[i]["number"]}"),
                                                      ],
                                                    ),
                                                    Text(
                                                        "At ${myOrder[i]["time"]}"),
                                                    Divider()
                                                  ],
                                                ),
                                                actions: [
                                                  MaterialButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        deleteFromMyOrder(
                                                            myOrderList[i]
                                                                ['id']);
                                                        myOrder[i]["cancel"] =
                                                            true;
                                                        myOrder.removeAt(i);
                                                      });
                                                      Navigator.of(context)
                                                          .pop();
                                                      cancelOrderMSG(
                                                          "Canceled");
                                                    },
                                                    color: Colors.red,
                                                    child: Text(
                                                      "Yes",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Text(
                                                        "No",
                                                        style: TextStyle(
                                                            color: Colors.red),
                                                      ))
                                                ],
                                              );
                                            });
                                      }
                                    },
                                    child: Container(
                                        margin:
                                            EdgeInsets.only(left: 40, top: 15),
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.red[600],
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Text(
                                          "Cancel Order",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                                margin: EdgeInsets.only(right: 40, top: 15),
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(right: 5),
                                      child: Icon(
                                        Icons.circle,
                                        color: deliveryStatusColor(i),
                                      ),
                                    ),
                                    Text(deliveryStatus(i))
                                  ],
                                )),
                          ],
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
                                        "${myOrder[i]["name"]}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      Text("${myOrder[i]["store"]}",
                                          style: TextStyle(color: Colors.grey)),
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
                                            "\$ ${clacEachOrderPrice(myOrder[i]["price"], myOrder[i]["number"]).toStringAsFixed(2)}",
                                            style: TextStyle(fontSize: 22),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text("Quantity : "),
                                            Text("${myOrder[i]["number"]}"),
                                          ],
                                        ),
                                      ],
                                    ),
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
    );
  }

/********************************** Start Functions Section ********************************** */
  double clacEachOrderPrice(double price, int quantity) {
    double total = price * quantity.toDouble();
    return total;
  }

  String deliveryStatus(int index) {
    if (myOrder[index]["delivery"] == 0) {
      return "Not delivered";
    } else if (myOrder[index]["delivery"] == 1) {
      return "Delivered";
    } else if (myOrder[index]["delivery"] == 2) {
      return "On Way";
    } else {
      return "No Status";
    }
  }

  Color? deliveryStatusColor(int index) {
    if (myOrder[index]["delivery"] == 1) {
      return Colors.green[600];
    } else if (myOrder[index]["delivery"] == 2) {
      return Colors.yellow[600];
    } else {
      return Colors.red[600];
    }
  }

  cancelOrderMSG(String msg) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Color.fromARGB(255, 75, 75, 75).withOpacity(0.7),
      content: Row(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Container(
            margin: EdgeInsets.only(right: 15),
            child: Icon(
              Icons.info,
              color: Colors.white,
              size: 35,
            ),
          ),
          Text(
            msg,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )
        ],
      ),
      duration: Duration(seconds: 2),
      margin: EdgeInsets.all(20),
    ));
  }
  /********************************** End Functions Section ********************************** */
}
