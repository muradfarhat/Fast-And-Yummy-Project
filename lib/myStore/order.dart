// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:fast_and_yummy/main.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

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
    //getAllDeliveryMan();
    bringStoreInfo();
    bringAllOrders();
    super.initState();
  }

  Api api = Api();
  List<dynamic> myOrderList = [];
  List<dynamic> products = [];
  Map storeInformation = {};
  String? deliveryID;
  bool getIDValue = true;
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

  bringStoreInfo() async {
    var respo =
        await api.postReq(storeInfo, {"id": sharedPref.getString("id")});
    if (respo['status'] == "suc") {
      setState(() {
        storeInformation = respo['data'];
      });
    }
  }

  setDeliveryManID(String id, String manID) async {
    var respo = await api.postReq(setManID, {"id": id, "manID": manID});
    if (respo['status'] == "suc") {
      print("suc");
    } else {
      print("fild");
    }
  }

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
                                    onPressed: () async {
                                      String idForData = await getDeliverMan(
                                          storeInformation["cityLocation"],
                                          double.parse(
                                              storeInformation["latitude"]),
                                          double.parse(
                                              storeInformation["longitude"]),
                                          double.parse(
                                              myOrderList[index]['latitude']),
                                          double.parse(
                                              myOrderList[index]['longitude']));
                                      setState(() {
                                        // here add algo

                                        if (idForData == "no delivery in app") {
                                          showFaildSnackBarMSG(
                                              "No delivery in app");
                                        } else if (idForData ==
                                            "no delivery in the area right now") {
                                          showFaildSnackBarMSG(
                                              "No delivery in the area right now");
                                        } else {
                                          print(
                                              "${myOrderList[index]['id']} + $idForData");
                                          setDeliveryManID(
                                              myOrderList[index]['id'],
                                              idForData);
                                          changeState(myOrderList[index]['id']);
                                          showFaildSnackBarMSG(
                                              "The delivery man ID $idForData");
                                        }

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
                              ? Colors.red
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

  showFaildSnackBarMSG(String msg) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.red.withOpacity(0.7),
      content: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 15),
            child: Icon(
              Icons.close,
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

  Future<String> getDeliverMan(String storeCity, double storeLat,
      double storeLng, double orderLat, double orderLng) async {
    double storeOrderDistance = 0.0;

    // List<Map> allDelivery = [];
    // List<Map> delivery = [];
    // List<Map> delMan = [];
    List<dynamic> allDelivery = [];
    List<dynamic> delivery = [];
    List<dynamic> delMan = [];

    scale s = new scale();
    storeOrderDistance =
        s.calculateDistance(storeLat, storeLng, orderLat, orderLng);

    var resp = await api.getReq(getAllDelivery);
    if (resp['status'] == 'suc') {
      allDelivery = resp['data'];
    } else {
      setState(() {
        deliveryID = "no delivery in app";
        getIDValue = false;
      });
      return "no delivery in app";
    }

    // if (allDelivery.isEmpty) return;
    // print("All delivery $allDelivery");

    for (int i = 0; i < allDelivery.length; i++) {
      if (allDelivery[i]["have_store"] == "yes" &&
          allDelivery[i]["cityLocation"] == storeCity) {
        delivery.add(allDelivery[i]);
      }
    }

    if (delivery.isEmpty) {
      setState(() {
        deliveryID = "no delivery in the area right now";
        getIDValue = false;
      });
      return "no delivery in the area right now";
    }
    print("Delivery $delivery");

    for (int i = 0; i < delivery.length; i++) {
      var resp = await api
          .postReq(bringDeliveryReadyOrders, {"id": delivery[i]["id"]});
      double dis = s.calculateDistance(
          storeLat,
          storeLng,
          double.parse(delivery[i]["latitude"]),
          double.parse(delivery[i]["longitude"]));
      if (resp["status"] == "suc") {
        List<dynamic> ord = resp["data"];
        int count = 0;
        for (int j = 0; j < ord.length; j++) {
          if (ord[j]['status'] == "In delivery") {
            count++;
          }
        }
        delMan.add({
          "id": delivery[i]["id"],
          "dis": dis,
          "scale": 0.0,
          "orderCount": count
        });
      } else {
        delMan.add({
          "id": delivery[i]["id"],
          "dis": dis,
          "scale": 0.0,
          "orderCount": 0
        });
      }
    }
    for (int j = 0; j < delMan.length; j++) {
      double scaleValue = s.calculateScale(
          storeOrderDistance, delMan[j]["dis"], delMan[j]["orderCount"]);
      delMan[j]["scale"] = scaleValue;
    }
    print(delMan);

    String delID = delMan[0]['id'];
    double ifScale = delMan[0]['scale'];
    int orderC = delMan[0]['orderCount'];

    for (int i = 0; i < delMan.length; i++) {
      if (delMan[i]['scale'] < ifScale) {
        ifScale = delMan[i]['scale'];
        delID = delMan[i]['id'];
        orderC = delMan[i]['orderCount'];
      } else if (delMan[i]['scale'] == ifScale) {
        if (delMan[i]['orderCount'] < orderC) {
          ifScale = delMan[i]['scale'];
          delID = delMan[i]['id'];
          orderC = delMan[i]['orderCount'];
        }
      }
    }
    print(delID);
    setState(() {
      deliveryID = delID;
      getIDValue = false;
    });
    return delID;
  }
}

class scale {
  calculateDistance(double fLat, double fLng, double sLat, double sLng) {
    var distance = Geolocator.distanceBetween(fLat, fLng, sLat, sLng);
    return distance / 1000;
  }

  calculateScale(double soDistance, double deliveryDistance, int ordersCount) {
    double scaleNum = 0.0;
    if (ordersCount == 0 || ordersCount == 1) {
      scaleNum = soDistance + deliveryDistance;
    } else {
      ordersCount -= 1;
      scaleNum = (soDistance + deliveryDistance) * (ordersCount.toDouble());
    }
    return scaleNum;
  }
}
