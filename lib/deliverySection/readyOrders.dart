import 'package:fast_and_yummy/api/api.dart';
import 'package:fast_and_yummy/api/linkapi.dart';
import 'package:fast_and_yummy/deliverySection/orderMap.dart';
import 'package:fast_and_yummy/main.dart';
import 'package:flutter/material.dart';

class readyOrder extends StatefulWidget {
  readyOrder({Key? key}) : super(key: key);

  @override
  State<readyOrder> createState() => _readyOrderState();
}

class _readyOrderState extends State<readyOrder> {
  Color color = const Color.fromARGB(255, 37, 179, 136);
  List<dynamic> OrderData = [];
  List<dynamic> ready = [];
  List<dynamic> users = [];
  List<dynamic> productsInfo = [];
  List<dynamic> colors = [];
  Set<String> storesLocation = {};

  bool loading = true;

  Api api = Api();
  getOrderData() async {
    var resp = await api
        .postReq(bringDeliveryReadyOrders, {"id": sharedPref.getString("id")});

    if (resp['status'] == "suc") {
      setState(() {
        OrderData = resp['data'];
      });
      getReadyOrders();
    } else {
      setState(() {
        loading = false;
      });
    }
  }

  getReadyOrders() {
    for (int i = 0; i < OrderData.length; i++) {
      if (OrderData[i]['status'] == 'In delivery') {
        // on way
        setState(() {
          ready.add(OrderData[i]);
          Color? c = Colors.yellow[600];
          colors.add(c!);
        });
      }
    }
    getUsers();
  }

  getUsers() async {
    for (int i = 0; i < ready.length; i++) {
      var response = await api.postReq(getInfoLink, {"id": ready[i]['userID']});

      if (response['status'] == "suc") {
        setState(() {
          users.add(response['data']);
        });
      }
    }
    getProduct();
  }

  getProduct() async {
    String? cateName;
    for (int i = 0; i < ready.length; i++) {
      var response =
          await api.postReq(bringNameOfCate, {"cateID": ready[i]['cateID']});
      if (response['status'] == "suc") {
        cateName = response['data'];
        cateName = cateName!.toLowerCase();
      }
      var respo = await api.postReq(
          bringProducts, {"id": ready[i]['orderID'], "cateName": cateName});
      if (respo['status'] == "suc") {
        setState(() {
          productsInfo.add(respo["data"][0]);
        });
        getStoreLocation(ready[i]["storeID"]);
      }
    }
    setState(() {
      loading = false;
    });
  }

  getStoreLocation(String store) async {
    var response = await api.postReq(storeInfo, {"id": store});
    if (response['status'] == "suc") {
      setState(() {
        storesLocation.add(response['data']["cityLocation"]);
      });
    }
  }

  changeOrderStatus(String id) async {
    var response = await api.postReq(updateOrdersStatus, {"id": id});
  }

  @override
  void initState() {
    getOrderData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
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
                ...List.generate(ready.length, (index) {
                  //ready.length
                  return InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: ((context) {
                        return orderMap(
                            ready[index]['storeID'],
                            ready[index]['latitude'],
                            ready[index]['longitude'],
                            ready[index]['cityLocation'],
                            "${users[index]['first_name']} ${users[index]['last_name']}",
                            users[index]['phone'],
                            "\$${(double.parse(productsInfo[index]['price']) * double.parse(ready[index]['quantity']))}  +  \$5.00  Delivery");
                      })));
                    },
                    child: Container(
                      width: double.infinity,
                      height: 225,
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: const Color.fromARGB(255, 197, 197, 197),
                            width: 2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "From : ${productsInfo.isEmpty ? "Null" : productsInfo[index]['storeName']}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18)),
                          Text(
                              "To : ${users.isEmpty ? "Null" : users[index]['first_name']} ${users.isEmpty ? "Null" : users[index]['last_name']}  - ${ready[index]['cityLocation']}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18)),
                          Text(
                              "Phone : 0${users.isEmpty ? "Null" : users[index]['phone']}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18)),
                          const Divider(),
                          Row(
                            children: [
                              Text(
                                "${productsInfo.isEmpty ? "Null" : productsInfo[index]['productName']}  |  ",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              Text(
                                  "Quantity : ${ready.isEmpty ? "Null" : ready[index]['quantity']}")
                            ],
                          ),
                          Text(
                              "Price : \$ ${productsInfo.isEmpty ? "Null" : (double.parse(productsInfo[index]['price']) * double.parse(ready[index]['quantity']))}  +  \$5.00  Delivery",
                              style: const TextStyle(fontSize: 18)),
                          const Divider(),
                          InkWell(
                            onTap: () {
                              if (ready.length != 0) {
                                changeOrderStatus(ready[index]['id']);
                                setState(() {
                                  // ready.removeAt(index);
                                  // productsInfo.removeAt(index);
                                  // users.removeAt(index);
                                  colors[index] = Colors.green[400];
                                  ready[index]["status"] = "Delivered";
                                });
                              }
                            },
                            child: Container(
                              width: double.infinity,
                              height: 50,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.only(left: 90),
                              color: colors.length == 0
                                  ? Colors.yellow[600]
                                  : colors[index],
                              child: Row(
                                children: [
                                  Text(
                                    "Order Status : ${ready.length == 0 ? "Null" : ready[index]["status"]}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
    );
  }
}
