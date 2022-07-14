// ignore_for_file: prefer_const_constructors, must_be_immutable, no_logic_in_create_state
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'dart:ui';

import 'package:flutter/material.dart';

double count = 1.00;
double price = 8.99;
double total = price * count;

class Detialscreen extends StatefulWidget {
  String s;
  Detialscreen(this.s, {Key? key}) : super(key: key);

  @override
  State<Detialscreen> createState() => _DetialscreenState(s);
}

class _DetialscreenState extends State<Detialscreen> {
  String se = "";
  _DetialscreenState(String s) {
    se = s;
  }
  var selected = 0;
  var time = [
    '12-1',
    '1-2',
    '2-3',
    '3-4',
    '4-5',
  ];
  String dropdownvalue = '1-2';
  bool visable = true;
  Icon icone = Icon(Icons.favorite_border_outlined);
  bool love = false;
  Color color = Colors.black;
  DateTime _dateTime = DateTime(2022);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        backgroundColor: Color.fromARGB(255, 37, 179, 136),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 37, 179, 136),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50)),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Container(
                      padding: EdgeInsets.all(7),
                      height: 250,
                      width: 250,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(80),
                        ),
                      ),
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(70),
                              ),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(se),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(100)),
                              child: IconButton(
                                color: color,
                                iconSize: 40,
                                icon: icone,
                                onPressed: () {
                                  setState(() {
                                    if (love == false) {
                                      love = true;
                                      icone = Icon(Icons.favorite);
                                      color = Colors.red;
                                    } else {
                                      love = false;
                                      icone =
                                          Icon(Icons.favorite_border_outlined);
                                      color = Colors.black;
                                    }
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Text(
                      "Pizza",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: 10,
                right: 10,
                top: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Card(
                    child: Container(
                      padding: EdgeInsets.all(18),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Content",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "- Cheese\n- Tomato\n- Pepper\n- Barbecue sauce\n- Olive\n- Salami",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Container(
                      padding: EdgeInsets.all(18),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Rating",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  iconDesign(1),
                                  iconDesign(1),
                                  iconDesign(1),
                                  iconDesign(0),
                                  iconDesign(0),
                                ],
                              ),
                              Text(
                                "4.2",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Feed Back",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "- Nice Dish\n\n- I'll try it again\n\n- The Barbecue sauce is Perfect",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Color.fromARGB(255, 90, 90, 90)),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Show More",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Color.fromARGB(255, 44, 44, 44)),
                          )
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Container(
                      padding: EdgeInsets.all(18),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Request Details",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: CheckboxListTile(
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  title: Text(
                                    "Today",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  value: false,
                                  onChanged: null,
                                ),
                              ),
                              Flexible(
                                child: CheckboxListTile(
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  title: Text(
                                    "Specific Day",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  value: true,
                                  onChanged: null,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Time : ",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    width: 100,
                                    child: DropdownButton(
                                      isExpanded: true,
                                      value: dropdownvalue,
                                      items: time.map((String items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Text(
                                            items,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (String? value) {
                                        setState(() {
                                          dropdownvalue = value!;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Visibility(
                                  visible: visable,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary:
                                          Color.fromARGB(255, 37, 179, 136),
                                    ),
                                    onPressed: () async {
                                      DateTime? _newDate = await showDatePicker(
                                        context: context,
                                        initialDate: _dateTime,
                                        firstDate: DateTime(2022),
                                        lastDate: DateTime(2024),
                                      );
                                      if (_newDate != null) {
                                        setState(() {
                                          _dateTime = _newDate;
                                        });
                                      }
                                    },
                                    child: Text(
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                      "${_dateTime.day}/${_dateTime.month}/${_dateTime.year}",
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Center(
                            child: Container(
                              width: 130,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        count++;
                                        total = price * count;
                                      });
                                    },
                                    icon: Icon(Icons.add),
                                  ),
                                  Text(
                                    "$count",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        count--;
                                        total = price * count;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.remove,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 2,
        child: Container(
          padding: EdgeInsets.all(20),
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total: $total",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  primary: Colors.amber,
                ),
                onPressed: () {},
                icon: Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.black,
                ),
                label: Text(
                  "Order Now",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Icon iconDesign(int i) {
    return Icon(
      i == 1 ? Icons.star : Icons.star_border_outlined,
      size: 28,
      color: Colors.amberAccent,
    );
  }
}
