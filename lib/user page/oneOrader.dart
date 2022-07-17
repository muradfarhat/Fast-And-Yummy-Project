// ignore_for_file: prefer_const_constructors

// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class OneOrder extends StatefulWidget {
  const OneOrder({Key? key}) : super(key: key);

  @override
  State<OneOrder> createState() => _OneOrderState();
}

class _OneOrderState extends State<OneOrder> {
  Color color = Color.fromARGB(255, 37, 179, 136);
  double price = 50;
  double quantity = 2;

  double? ratio;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double total = price * quantity;
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
                                        Text(
                                          "FOOD NAME",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              "Quantity",
                                            ),
                                            Divider(
                                              height: 10,
                                              thickness: 5,
                                            ),
                                            Text(
                                              "$quantity",
                                              style: TextStyle(fontSize: 16),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              "Total price",
                                            ),
                                            Divider(
                                              height: 10,
                                            ),
                                            Text(
                                              "$total \$",
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
            contDesign(
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Personal Info",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  rowDesgin("Name"),
                  rowDesgin("Phone Number"),
                  rowDesgin("City"),
                  rowDesgin("Town"),
                  rowDesgin("Street"),
                ],
              ),
            ),
            Divider(
              indent: 30,
              endIndent: 30,
              color: Color.fromARGB(255, 179, 179, 179),
            ),
            contDesign(Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Credit Card Info",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                rowDesgin("Card Number"),
                rowDesgin("Card Name"),
                Row(
                  children: [
                    Flexible(child: rowDesgin("Date")),
                    SizedBox(
                      width: 20,
                    ),
                    Flexible(child: rowDesgin("CVV"))
                  ],
                )
              ],
            )),
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
                  inkDesign(color, Colors.white, "Apply", 1),
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
          Navigator.pop(context);
        } else {
          setState(() {
            ratio = quantity * price * 0.2;
          });
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("App Ratio : $ratio"),
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
}
