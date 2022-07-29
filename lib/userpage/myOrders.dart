// ignore_for_file: prefer_const_constructors

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
  List<dynamic> myOrder = [];
  List<dynamic> myOrderList = [];
  // {
  //     "name": "Pizza",
  //     "store": "Food Store",
  //     "image": "images/pizza.jpg",
  //     "price": 8.99,
  //     "number": 1,
  //     "delivery":
  //         1, // if = 1 that mean deliverd , if = 2 that mean the order in way , if = 0 that mean not deliver yet
  //     "cancel": false,
  //     "time": "1-2 PM,Wen"
  //   }
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
    }
  }

  bringProductFromMyOrder(
      String cateID, String productID, String quantity, String time) async {
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
        myOrder.add({
          "productID": response['data'][0]['productID'],
          "name": response['data'][0]['productName'],
          "store": response['data'][0]['storeName'],
          "rate": response['data'][0]['rate'],
          "image": "php/images/${response['data'][0]['image']}",
          "userID": response['data'][0]['userID'],
          "price": double.parse(response['data'][0]['price']),
          "totalBuy": response['data'][0]['totalBuy'],
          "number": int.parse(quantity),
          "time": time,
          "cancel": false,
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
          myOrderList[i]["time"]);
    }
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
                                image: AssetImage("${myOrder[i]['image']}")),
                            border: Border.all(
                                color: Color.fromARGB(255, 197, 197, 197),
                                width: 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                if (myOrder[i]["delivery"] == 1) {
                                  cancelOrderMSG();
                                } else {
                                  setState(() {
                                    myOrder[i]["cancel"] = true;
                                    myOrder.removeAt(i);
                                  });
                                }
                              },
                              child: Container(
                                  margin: EdgeInsets.only(left: 40, top: 15),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.red[600],
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Text(
                                    "Cancel Order",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
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
                                        Container(
                                          alignment: Alignment.center,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                "Order Time",
                                                style: TextStyle(
                                                    color: Colors.green[800]),
                                              ),
                                              Text("${myOrder[i]["time"]}",
                                                  style: TextStyle(
                                                      color: Colors.green[800]))
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

  cancelOrderMSG() {
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
            "Cannot Cancel deliverd order",
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
