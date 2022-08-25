// ignore_for_file: file_names, prefer_const_constructors,prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';

import '../api/api.dart';
import '../api/linkapi.dart';
import '../main.dart';

class ProductPromotion extends StatefulWidget {
  dynamic product = [];
  ProductPromotion(this.product, {Key? key}) : super(key: key);

  @override
  State<ProductPromotion> createState() => _ProductPromotionState();
}

class _ProductPromotionState extends State<ProductPromotion> {
  @override
  void initState() {
    print(widget.product);
    getVisa();
    super.initState();
  }

  GlobalKey<FormState> formState = GlobalKey<FormState>();
  Color color = Color.fromARGB(255, 37, 179, 136);
  bool switchB = false;
  bool check = false;
  bool checkOther = false;
  bool loading = false;
  bool visible = false;
  Api api = Api();
  dynamic visa = [];
  String? duration;
  getVisa() async {
    setState(() {
      loading = true;
    });
    var resp =
        await api.postReq(promotionLink, {"id": sharedPref.getString("id")});
    setState(() {
      loading = false;
    });
    if (resp['status'] == "suc") {
      setState(() {
        visa = resp['data'];
        if (visa['visaName'] != "" &&
            visa['visaNumber'] != "" &&
            visa['CVV'] != "" &&
            visa['visaDate'] != "") {
          visible = true;
        }
      });
    } else {}
  }

  addToPromotion() async {
    var resp = await api.postReq(addPromotionLink, {
      "storeID": sharedPref.getString("id"),
      "productID": widget.product['productID'],
      "status": "wait",
      "cateID": widget.product['cateID'],
      "duration": duration!.toString(),
    });
    if (resp['status'] == "suc") {
      setState(() {
        showSuccessSnackBarMSG();
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color,
        title: Text("Product Promotion"),
        centerTitle: true,
      ),
      body: switchB
          ? Container(
              width: size.width,
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          switchB = false;
                        });
                      },
                      child: Icon(Icons.arrow_back),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Visibility(
                      visible: visible,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            width: size.width,
                            height: 60,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromARGB(255, 197, 197, 197),
                                    blurRadius: 3)
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      check = !check;
                                      checkOther = false;
                                    });
                                  },
                                  child: Icon(
                                    check
                                        ? Icons.radio_button_checked
                                        : Icons.radio_button_off,
                                    color: check ? color : Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Image.asset(
                                  "images/cCard.png",
                                  height: 30,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "${visa['visaName']}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(
                                  width: 25,
                                ),
                                Text(
                                  "${visa['visaDate']}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      width: size.width,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromARGB(255, 197, 197, 197),
                              blurRadius: 3)
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    checkOther = !checkOther;
                                    check = false;
                                  });
                                },
                                child: Icon(
                                  checkOther
                                      ? Icons.radio_button_checked
                                      : Icons.radio_button_off,
                                  color: checkOther ? color : Colors.black,
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Image.asset(
                                "images/cCard.png",
                                height: 30,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Other",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          Visibility(
                              visible: checkOther,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Form(
                                      key: formState,
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            left: 15, bottom: 15, right: 15),
                                        child: Column(children: [
                                          TextFormField(
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "Can't be empty";
                                              }
                                              if (value.length < 5) {
                                                return "Invalid input";
                                              }
                                            },
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                                icon: Icon(
                                                  Icons.person,
                                                  color: color,
                                                ),
                                                labelText: "Person Name",
                                                labelStyle: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 37, 179, 136))),
                                          ),
                                          TextFormField(
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "Can't be empty";
                                              } else if (value.length < 16) {
                                                return "The card number must be just 16";
                                              }
                                            },
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                                icon: Icon(
                                                  Icons.credit_card_outlined,
                                                  color: color,
                                                ),
                                                labelText: "Card Number",
                                                labelStyle: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 37, 179, 136))),
                                            maxLength: 16,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: TextFormField(
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return "Can't be empty";
                                                    } else if (value.length <
                                                        4) {
                                                      return "Wrong Exp. Date";
                                                    }
                                                  },
                                                  keyboardType:
                                                      TextInputType.datetime,
                                                  decoration: InputDecoration(
                                                      icon: Icon(
                                                        Icons.date_range,
                                                        color: Color.fromARGB(
                                                            255, 37, 179, 136),
                                                      ),
                                                      labelText: "Exp. Date",
                                                      labelStyle: TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              37,
                                                              179,
                                                              136))),
                                                  maxLength: 5,
                                                ),
                                              ),
                                              Expanded(
                                                child: TextFormField(
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return "Can't be empty";
                                                    } else if (value.length <
                                                        3) {
                                                      return "must be 3 numbers";
                                                    }
                                                  },
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration: InputDecoration(
                                                      icon: Icon(
                                                        Icons.password,
                                                        color: Color.fromARGB(
                                                            255, 37, 179, 136),
                                                      ),
                                                      labelText: "CVV",
                                                      labelStyle: TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              37,
                                                              179,
                                                              136))),
                                                  maxLength: 3,
                                                ),
                                              )
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.white,
                                          ),
                                        ]),
                                      ))
                                ],
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: MaterialButton(
                            color: color,
                            onPressed: () {
                              if (check || checkOther) {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("Are you sure ?"),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              MaterialButton(
                                                color: color,
                                                onPressed: () {
                                                  if (checkOther) {
                                                    if (formState.currentState!
                                                        .validate()) {
                                                      addToPromotion();
                                                    }
                                                  } else {
                                                    addToPromotion();
                                                  }
                                                  Navigator.pop(context);
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Icon(Icons.check,
                                                        color: Colors.white),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      "Yes",
                                                      style: TextStyle(
                                                          color: Colors.white),
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
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Icon(Icons.close,
                                                        color: Colors.white),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      "No",
                                                      style: TextStyle(
                                                          color: Colors.white),
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
                            child: Text(
                              "Save",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextButton(
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 37, 179, 136)),
                            ),
                            onPressed: () {
                              setState(() {});
                            },
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          : Container(
              margin: EdgeInsets.fromLTRB(20, 35, 0, 35),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Promotion Duration",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          padding: EdgeInsets.only(bottom: 5, right: 15),
                          child: Icon(
                            Icons.timelapse,
                            color: color,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        margin: EdgeInsets.all(15),
                        child: Row(
                          children: [
                            containerDesign("Week", "8", color),
                            SizedBox(
                              width: 20,
                            ),
                            containerDesign(
                                "Month", "25", Colors.amber.shade900),
                            SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Container containerDesign(String text, String price, Color color) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromARGB(255, 245, 245, 245),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 155, 155, 155),
            blurRadius: 5,
          )
        ],
      ),
      height: 350,
      width: 250,
      padding: EdgeInsets.fromLTRB(15, 45, 15, 45),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "\$",
                style: TextStyle(
                    fontSize: 35, fontWeight: FontWeight.bold, color: color),
              ),
              Text(
                price,
                style: TextStyle(
                    fontSize: 65, fontWeight: FontWeight.bold, color: color),
              ),
              Text(
                "/$text",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    color: Colors.black),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check,
                color: Colors.blue,
              ),
              Flexible(
                child: Text(
                  "Recommend for users for $text",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: Colors.black),
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                switchB = true;
                duration = text;
              });
            },
            child: Text(
              "Order Now", // ${favorite[index]['name']}
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              primary: this.color,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            ),
          ),
        ],
      ),
    );
  }

  showSuccessSnackBarMSG() {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: color.withOpacity(0.7),
      content: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 15),
            child: Icon(
              Icons.check_circle_rounded,
              color: Colors.white,
              size: 35,
            ),
          ),
          Flexible(
            child: Text(
              "Your request has been submitted",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
      duration: Duration(seconds: 2),
      margin: EdgeInsets.all(20),
    ));
  }
}
