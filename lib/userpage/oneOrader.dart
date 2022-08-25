// ignore_for_file: prefer_const_constructors, must_be_immutable

// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../api/api.dart';
import '../api/linkapi.dart';

class OneOrder extends StatefulWidget {
  dynamic list1;
  dynamic list2;
  double latitude; // .toString()
  double longitude; // .toString()
  String? cityLocation;
  OneOrder(
      this.list1, this.list2, this.latitude, this.longitude, this.cityLocation,
      {Key? key})
      : super(key: key);

  @override
  State<OneOrder> createState() => _OneOrderState();
}

class _OneOrderState extends State<OneOrder> {
  Color color = Color.fromARGB(255, 37, 179, 136);
  double price = 50;
  double quantity = 2;
  double? ratio;
  Api api = Api();
  addOrder() async {
    var resp = await api.postReq(orderCompleteLink, {
      "userID": widget.list2['userID'],
      "cateID": widget.list2['cateID'],
      "orderID": widget.list2['orderID'],
      "storeID": widget.list2['storeID'],
      "quantity": widget.list2['quantity'],
      "latitude": widget.latitude.toString(),
      "longitude": widget.longitude.toString(),
      "cityLocation": widget.cityLocation,
    });
    if (resp['status'] == "suc") {
      snackBarMSG("Added to orders", color, Icons.check_circle_outline, 2);
    } else {}
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: color,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Stack(
              children: [
                Container(
                  height: 180,
                  width: size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("images/cy.jpg"), fit: BoxFit.cover),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 136, 136, 136),
                        blurRadius: 15,
                        spreadRadius: 1,
                      )
                    ],
                  ),
                ),
                Positioned(
                  bottom: 50,
                  left: 30,
                  child: Text(
                    "YOUR\nINFO",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                Positioned(
                    top: 10,
                    left: 10,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                height: 180,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 218, 218, 218),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Orders Info\n",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                          itemCount: 4,
                          itemBuilder: (context, i) {
                            return Container(
                                padding: EdgeInsets.all(15),
                                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              "${widget.list1['productName']}",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Divider(
                                              height: 10,
                                              thickness: 5,
                                            ),
                                            Text(
                                              "Price : ${widget.list1['price']} \$",
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              "Quantity",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Divider(
                                              height: 10,
                                              thickness: 5,
                                            ),
                                            Text(
                                              "${widget.list2['quantity']}",
                                              style: TextStyle(fontSize: 16),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              "Total price",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Divider(
                                              height: 10,
                                            ),
                                            Text(
                                              "${totalPrice(widget.list1['price'], widget.list2['quantity'])} \$",
                                              style: TextStyle(fontSize: 16),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Divider(
                                      color: Colors.black,
                                    )
                                  ],
                                ));
                          }),
                    ),
                  ],
                )),
            Divider(
              indent: 30,
              endIndent: 30,
              color: Color.fromARGB(255, 179, 179, 179),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  inkDesign(
                      Color.fromARGB(255, 255, 255, 255), color, "Cancel", 0),
                  inkDesign(color, Colors.white, "Submit", 1),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  TextFormField textFieldDesign(String hint) {
    return TextFormField(
      cursorColor: Color.fromARGB(255, 21, 157, 117),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 21, 157, 117)),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 21, 157, 117)),
        ),
        hintText: hint,
        fillColor: Colors.black,
        hintStyle: TextStyle(
            fontFamily: "Prompt2",
            fontSize: 15,
            color: Color.fromARGB(179, 202, 202, 202)),
      ),
    );
  }

  Row rowDesgin(String detial) {
    return Row(
      children: [
        Text(
          detial,
          style: TextStyle(fontSize: 16, color: color),
        ),
        SizedBox(
          width: 10,
        ),
        Flexible(
          child: textFieldDesign(
            detial,
          ),
        ),
      ],
    );
  }

  Container contDesign(Column col) {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.fromLTRB(30, 20, 30, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 218, 218, 218),
            blurRadius: 6,
          ),
        ],
      ),
      child: col,
    );
  }

  InkWell inkDesign(Color color, Color color2, String name, int bol) {
    return InkWell(
      onTap: () {
        if (bol == 0) {
          Navigator.popUntil(
            context,
            (route) => route.isFirst,
          );
        } else {
          setState(() {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Are you sure of your data?"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          MaterialButton(
                            color: color,
                            onPressed: () {
                              addOrder();
                              Navigator.popUntil(
                                context,
                                (route) => route.isFirst,
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            elevation: 0,
                            color: Colors.white,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(Icons.close, color: Colors.red),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "No",
                                  style: TextStyle(color: Colors.black),
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
          });
        }
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 10, 10),
        alignment: Alignment.center,
        height: 40,
        width: 100,
        color: color,
        child: Text(
          name,
          style: TextStyle(color: color2),
        ),
      ),
    );
  }

  totalPrice(String quantity, String price) {
    double total = double.parse(quantity) * double.parse(price);
    return total;
  }

  snackBarMSG(String text, Color color, IconData icon, int duration) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: color.withOpacity(0.7),
      content: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 15),
            child: Icon(
              icon,
              color: Colors.white,
              size: 35,
            ),
          ),
          Flexible(
            child: Text(
              text,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
      duration: Duration(seconds: duration),
      margin: EdgeInsets.all(20),
    ));
  }
}
