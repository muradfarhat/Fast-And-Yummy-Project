import 'package:fast_and_yummy/api/api.dart';
import 'package:fast_and_yummy/api/linkapi.dart';
import 'package:fast_and_yummy/main.dart';
import 'package:flutter/material.dart';

class doneOrders extends StatefulWidget {
  doneOrders({Key? key}) : super(key: key);

  @override
  State<doneOrders> createState() => _doneOrdersState();
}

class _doneOrdersState extends State<doneOrders> {
  Color color = const Color.fromARGB(255, 37, 179, 136);
  List<dynamic> OrderData = [];
  List<dynamic> ready = [];
  List<dynamic> users = [];
  List<dynamic> productsInfo = [];

  bool loading = true;

  Api api = Api();
  getOrderData() async {
    var resp = await api
        .postReq(bringDeliveryReadyOrders, {"id": sharedPref.getString("id")});

    if (resp['status'] == "suc") {
      setState(() {
        OrderData = resp['data'];
      });
      getDeliveredOrders();
    }
  }

  getDeliveredOrders() {
    for (int i = 0; i < OrderData.length; i++) {
      if (OrderData[i]['status'] == 'deliverd') {
        setState(() {
          ready.add(OrderData[i]);
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
      }
    }
    setState(() {
      loading = false;
    });
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
                  return Container(
                    width: double.infinity,
                    height: 220,
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 197, 197, 197),
                          width: 1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "From : ${productsInfo.length == 0 ? "Null" : productsInfo[index]['storeName']}  - At Location",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                        Text(
                            "To : ${users.length == 0 ? "Null" : users[index]['first_name']} ${users.length == 0 ? "Null" : users[index]['last_name']}  - At Location",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                        Text(
                            "Phone : 0${users.length == 0 ? "Null" : users[index]['phone']}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                        const Divider(),
                        Row(
                          children: [
                            Text(
                              "${productsInfo.length == 0 ? "Null" : productsInfo[index]['productName']}  |  ",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            Text(
                                "Quantity : ${ready.length == 0 ? "Null" : ready[index]['quantity']}")
                          ],
                        ),
                        Text(
                            "Price : \$ ${productsInfo.length == 0 ? "Null" : (double.parse(productsInfo[index]['price']) * double.parse(ready[index]['quantity']))}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                        Divider(),
                        Container(
                          width: double.infinity,
                          height: 50,
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(left: 90),
                          color: Colors.green[400],
                          child: Row(
                            children: [
                              Text(
                                "Order Status : ${ready.length == 0 ? "Null" : ready[index]["status"]}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }),
              ],
            ),
    );
  }
}
