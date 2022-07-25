// ignore_for_file: prefer_const_constructors, non_constant_identifier_names
import 'package:fast_and_yummy/api/api.dart';
import 'package:fast_and_yummy/api/linkapi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../main.dart';

class profile extends StatefulWidget {
  profile({Key? key}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  GlobalKey<FormState> formStateForName =
      new GlobalKey<FormState>(); // For Text Filed in Customer Name

// variables for show and hidden the fields
  bool hidePass = true;
  bool hidePass2 = true;
  bool notEnable = false;
  bool showSaveInfo = false;
  bool showFavEdit = false;
  bool showCardEdit = false;

// variables for personal information
  String? firstName;
  String? lastName;
  String? pass;
  String? confirmValue;
  String? phone;
  String? city;
  String? town;
  String? street;
// variables for credit card
  String? cardName;
  String? cardNum;
  String? cardDate;
  int? cardCVV;

  List<Map> personalInfo = [
    {"firstName": "Customer"},
    {"lastName": "Name"},
    {"email": "customer@email.com"},
    {"password": "12345678"},
    {"phone": "598418464"},
    {"city": "Nablus"},
    {"town": "Beita"},
    {"street": "50 Street"},
    {"image": "images/profile.jpg"}
  ];

  List<Map> favoriteCkeckBox = [
    // favorite items that will check from it :: fixed list edit just from admin
    {"name": "Sweet"},
    {"name": "Meat"},
    {"name": "Drinks"},
    {"name": "Traditional"},
    {"name": "Traditional"}
  ];

  List<Map> favorite = [
    {"name": "Sweet"},
    {"name": "Meat"},
    {"name": "Traditional"},
  ];

  List<Map> bankCardInfo = [
    {"cardNumber": "5555555555555555"},
    {"name": "Person Name"},
    {"expDate": '10/23'},
    {"cvv": 999}
  ];
  String? inital;
  String? inital2;
  Api api = Api();
  getData() async {
    var resp =
        await api.postReq(getInfoLink, {"id": sharedPref.getString("id")});
    if (resp['status'] == "suc") {
      return resp;
    } else {}
  }

  udpatePersonalData() async {
    var resp = await api.postReq(updatePers, {
      "password": pass,
      "phone": phone,
      "city": city,
      "town": town,
      "street": street,
      "id": sharedPref.getString("id"),
    });

    if (resp['status'] == "suc") {
      return true;
    }
  }

  updateUName() async {
    var resp = await api.postReq(updateNameLink, {
      "first_name": firstName,
      "last_name": lastName,
      "id": sharedPref.getString("id"),
    });
    if (resp['status'] == "suc") {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formStateForPersonal =
        GlobalKey<FormState>(); // For Text Filed in Personal Info

    GlobalKey<FormState> formStateForFavorite =
        GlobalKey<FormState>(); // For Text Filed in Favorite

    GlobalKey<FormState> formStateForCardInfo =
        GlobalKey<FormState>(); // For Text Filed in Favorite

    GlobalKey<ScaffoldState> scaffoldKey =
        GlobalKey<ScaffoldState>(); // For snackBar

/********** Start Function for edit personal information & Favorite & Card Information validation ************** */

    bool EditPersonalData() {
      var formData = formStateForPersonal.currentState;

      if (formData!.validate()) {
        formData.save();
        udpatePersonalData();

        return true;
      } else {
        return false;
      }
    }

    bool EditCardData() {
      var formCardData = formStateForCardInfo.currentState;

      if (formCardData!.validate()) {
        formCardData.save();

        if (!cardNum!.isEmpty) {
          bankCardInfo[0]['cardNumber'] = cardNum;
        }
        bankCardInfo[1]['name'] = cardName;
        bankCardInfo[2]['expDate'] = cardDate;
        bankCardInfo[3]['cvv'] = cardCVV;

        return true;
      } else {
        return false;
      }
    }
/********** End Function for edit personal information & Favorite & Card Information validation ************** */

    return SingleChildScrollView(
      key: scaffoldKey,
      child: FutureBuilder(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              inital = "${snapshot.data['data']['first_name']}";
              inital2 = "${snapshot.data['data']['last_name']}";
              return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /*************************************** Start header => User image and name *************************** */
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 37, 179, 136),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(100),
                            bottomRight: Radius.circular(100)),
                      ),
                      padding: EdgeInsets.only(bottom: 10),
                      child: Stack(
                        children: [
                          Positioned(
                            left: 10,
                            top: 10,
                            child: IconButton(
                                onPressed: () =>
                                    Scaffold.of(context).openDrawer(),
                                icon: Icon(
                                  Icons.menu,
                                  color: Colors.white,
                                  size: 35,
                                )),
                          ),
                          Column(children: [
                            Stack(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 30, bottom: 20),
                                  height: 150,
                                  width: 150,

                                  // ignore: prefer_const_constructors
                                  decoration: BoxDecoration(
                                    // ignore: prefer_const_literals_to_create_immutables
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.white, blurRadius: 10)
                                    ],
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                            "${personalInfo[8]['image']}")),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                ),
                                Positioned(
                                  bottom: 15,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: IconButton(
                                      splashColor: Colors.white,
                                      color: Color.fromARGB(255, 37, 179, 136),
                                      iconSize: 20,
                                      icon: Icon(Icons.camera_enhance),
                                      onPressed: () {},
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                Expanded(child: Container()),
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    child: Text(
                                        "${snapshot.data['data']['first_name']} ${snapshot.data['data']['last_name']}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    child: IconButton(
                                      splashColor: Colors.white,
                                      alignment: Alignment.centerLeft,
                                      color: Colors.white,
                                      iconSize: 20,
                                      icon: Icon(Icons.edit),
                                      onPressed: () {
                                        editName();
                                      },
                                    ),
                                  ),
                                )
                              ],
                            )
                          ]),
                        ],
                      ),
                    ),
                    /*************************************** End header => User image and name *************************** */

                    /*************************************** Start Personal Information ********************************** */
                    Form(
                      key: formStateForPersonal,
                      child: Card(
                        child: Column(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            listTileInfo('Personal Information', 0),
                            Container(
                              margin: EdgeInsets.only(
                                  left: 15, bottom: 15, right: 15),
                              child: Column(
                                children: [
                                  TextFormField(
                                    initialValue:
                                        "${snapshot.data['data']['email']}",
                                    enabled: false,
                                    decoration: InputDecoration(
                                      suffixText: "Fixed",
                                      labelText: "Email",
                                      labelStyle: TextStyle(
                                          color: Color.fromARGB(
                                              255, 37, 179, 136)),
                                      icon: Icon(Icons.email,
                                          color: Color.fromARGB(
                                              255, 37, 179, 136)),
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.white,
                                  ),
                                  TextFormField(
                                    autovalidateMode: AutovalidateMode.always,
                                    validator: (pass) {
                                      if (pass!.length < 8) {
                                        return "It must be 8 or more characters";
                                      } else {
                                        return null;
                                      }
                                    },
                                    onSaved: (text) {
                                      pass = text;
                                    },
                                    onChanged: (confirm) {
                                      confirmValue = confirm;
                                    },
                                    initialValue:
                                        "${snapshot.data['data']['password']}",
                                    enabled: notEnable,
                                    obscureText: hidePass,
                                    decoration: InputDecoration(
                                      labelText: "Password",
                                      labelStyle: TextStyle(
                                          color: Color.fromARGB(
                                              255, 37, 179, 136)),
                                      suffixIcon: Visibility(
                                        visible: showSaveInfo,
                                        child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                if (hidePass) {
                                                  hidePass = false;
                                                } else {
                                                  hidePass = true;
                                                }
                                              });
                                            },
                                            icon: Icon(
                                              hidePass
                                                  ? Icons.visibility_sharp
                                                  : Icons.visibility_off_sharp,
                                              color: Color.fromARGB(
                                                  255, 37, 179, 136),
                                            )),
                                      ),
                                      icon: Icon(Icons.password,
                                          color: Color.fromARGB(
                                              255, 37, 179, 136)),
                                    ),
                                  ),
                                  Visibility(
                                    visible: showSaveInfo,
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Divider(
                                            color: Colors.white,
                                          ),
                                          TextFormField(
                                            autovalidateMode:
                                                AutovalidateMode.always,
                                            validator: (text) {
                                              if (confirmValue == null) {
                                                return null;
                                              } else if (text != confirmValue) {
                                                return "Passwords are not the same";
                                              } else {
                                                return null;
                                              }
                                            },
                                            enabled: notEnable,
                                            obscureText: hidePass2,
                                            decoration: InputDecoration(
                                              suffixIcon: IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      if (hidePass2) {
                                                        hidePass2 = false;
                                                      } else {
                                                        hidePass2 = true;
                                                      }
                                                    });
                                                  },
                                                  icon: Icon(
                                                    hidePass2
                                                        ? Icons.visibility_sharp
                                                        : Icons
                                                            .visibility_off_sharp,
                                                    color: Color.fromARGB(
                                                        255, 37, 179, 136),
                                                  )),
                                              labelText: "Confirm Password",
                                              labelStyle: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 37, 179, 136)),
                                              icon: Icon(Icons.password,
                                                  color: Color.fromARGB(
                                                      255, 37, 179, 136)),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.white,
                                  ),
                                  TextFormField(
                                    autovalidateMode: AutovalidateMode.always,
                                    validator: (phone) {
                                      if (phone!.length < 9 ||
                                          phone.length > 12) {
                                        return "The phone number must be 10 digits";
                                      } else {
                                        return null;
                                      }
                                    },
                                    onSaved: (text) {
                                      if (text!.startsWith("0")) {
                                        text = text.substring(1);
                                        phone = text;
                                      } else {
                                        phone = text;
                                      }
                                    },
                                    initialValue:
                                        "${snapshot.data['data']['phone']}",
                                    keyboardType: TextInputType.number,
                                    enabled: notEnable,
                                    decoration: InputDecoration(
                                      labelText: "Phone Number",
                                      labelStyle: TextStyle(
                                          color: Color.fromARGB(
                                              255, 37, 179, 136)),
                                      prefix: Text(
                                        "+970 ",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      icon: Icon(Icons.phone,
                                          color: Color.fromARGB(
                                              255, 37, 179, 136)),
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.white,
                                  ),
                                  TextFormField(
                                    autovalidateMode: AutovalidateMode.always,
                                    validator: (city) {
                                      if (city!.length > 20 ||
                                          city.length < 3) {
                                        return "Invalid input";
                                      } else {
                                        return null;
                                      }
                                    },
                                    onSaved: (text) {
                                      city = text;
                                    },
                                    initialValue:
                                        "${snapshot.data['data']['city']}",
                                    enabled: notEnable,
                                    decoration: InputDecoration(
                                      labelText: "City",
                                      labelStyle: TextStyle(
                                          color: Color.fromARGB(
                                              255, 37, 179, 136)),
                                      icon: Icon(Icons.map,
                                          color: Color.fromARGB(
                                              255, 37, 179, 136)),
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.white,
                                  ),
                                  TextFormField(
                                    autovalidateMode: AutovalidateMode.always,
                                    validator: (city) {
                                      if (city!.length > 20 ||
                                          city.length < 3) {
                                        return "Invalid input";
                                      } else {
                                        return null;
                                      }
                                    },
                                    onSaved: (text) {
                                      town = text;
                                    },
                                    initialValue:
                                        "${snapshot.data['data']['town']}",
                                    enabled: notEnable,
                                    decoration: InputDecoration(
                                      labelText: "Town",
                                      labelStyle: TextStyle(
                                          color: Color.fromARGB(
                                              255, 37, 179, 136)),
                                      icon: Icon(Icons.location_city,
                                          color: Color.fromARGB(
                                              255, 37, 179, 136)),
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.white,
                                  ),
                                  TextFormField(
                                    autovalidateMode: AutovalidateMode.always,
                                    validator: (city) {
                                      if (city!.length > 20 ||
                                          city.length < 3) {
                                        return "Invalid input";
                                      } else {
                                        return null;
                                      }
                                    },
                                    onSaved: (text) {
                                      street = text;
                                    },
                                    initialValue:
                                        "${snapshot.data['data']['street']}",
                                    enabled: notEnable,
                                    decoration: InputDecoration(
                                      labelText: "Street",
                                      labelStyle: TextStyle(
                                          color: Color.fromARGB(
                                              255, 37, 179, 136)),
                                      icon: Icon(Icons.edit_location,
                                          color: Color.fromARGB(
                                              255, 37, 179, 136)),
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.white,
                                  ),
                                  Visibility(
                                    visible: showSaveInfo,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: MaterialButton(
                                            color: Color.fromARGB(
                                                255, 37, 179, 136),
                                            onPressed: () {
                                              if (EditPersonalData()) {
                                                setState(() {
                                                  notEnable = false;
                                                  showSaveInfo = false;
                                                  hidePass = true;
                                                  hidePass2 = true;
                                                  confirmValue = null;
                                                });
                                                showSuccessSnackBarMSG(); // a Function in Functions Section
                                              } else {
                                                showFaildSnackBarMSG(); // a Function in Functions Section
                                              }
                                            },
                                            child: Text(
                                              "Save",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: TextButton(
                                            child: Text(
                                              "Cancel",
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 37, 179, 136)),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                notEnable = false;
                                                showSaveInfo = false;
                                                hidePass = true;
                                                hidePass2 = true;
                                                confirmValue = null;
                                              });
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    /*************************************** End Personal Information ********************************** */

                    /*************************************** Start Favorite Information ********************************** */
                    Form(
                      key: formStateForFavorite,
                      child: Card(
                        child: Column(
                          children: [
                            listTileInfo('Favorite Information',
                                1), // a Function in Functions Section
                            Container(
                              child:
                                  wrapFavoriteContent(), // Wrap Function a Function in Functions Section
                            ),
                            Visibility(
                                visible: showFavEdit,
                                child: Column(
                                  children: [
                                    Divider(),
                                    ListTile(
                                      title: Text(
                                        "Choose your favorite",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      child:
                                          wrapFavoriteContentCheckBox(), // Wrap Function a Function in Functions Section
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          right: 15, bottom: 15, left: 15),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: MaterialButton(
                                              color: Color.fromARGB(
                                                  255, 37, 179, 136),
                                              onPressed: () {},
                                              child: Text(
                                                "Save",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: TextButton(
                                              child: Text(
                                                "Cancel",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 37, 179, 136)),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  showFavEdit = false;
                                                });
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ))
                          ],
                        ),
                      ),
                    ),
                    /*************************************** End Favorite Information ********************************** */

                    /*************************************** Satrt Visa Card Information ********************************** */
                    Card(
                      child: Column(children: [
                        listTileInfo('Credit Card Information', 2),
                        Container(
                          margin:
                              EdgeInsets.only(left: 10, right: 10, bottom: 15),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.blue[700],
                              borderRadius: BorderRadius.circular(15)),
                          // ignore: prefer_const_literals_to_create_immutables
                          child: Column(children: [
                            ListTile(
                              textColor: Colors.white,
                              leading: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage("images/master.jpg")),
                                ),
                                height: 40,
                                width: 70,
                              ),
                              trailing: Transform.rotate(
                                angle: 90 * math.pi / 180,
                                child: Icon(
                                  Icons.wifi,
                                  size: 35,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              width: double.infinity,
                              margin: EdgeInsets.all(15),
                              child: Column(
                                children: [
                                  cardInfo('name', 1, 18),
                                  cardInfo('cardNumber', 0, 20),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 15),
                                    width: double.infinity,
                                    child: Row(children: [
                                      Container(
                                        margin: EdgeInsets.only(right: 10),
                                        child: Text(
                                          "Exp. Date",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14),
                                        ),
                                      ),
                                      Text(
                                        "${snapshot.data['data']['visaDate']}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Spacer(),
                                      Container(
                                        margin: EdgeInsets.only(right: 10),
                                        child: Text(
                                          "cvv",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14),
                                        ),
                                      ),
                                      Text(
                                        "${snapshot.data['data']['CVV']}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ]),
                                  )
                                ],
                              ),
                            )
                          ]),
                        ),
                        Visibility(
                            visible: showCardEdit, // showCardEdit
                            child: Form(
                                key: formStateForCardInfo,
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 15, bottom: 15, right: 15),
                                  child: Column(children: [
                                    TextFormField(
                                      validator: (value) {
                                        if (value!.length < 5) {
                                          return "Invalid input";
                                        } else {
                                          return null;
                                        }
                                      },
                                      onSaved: (text) {
                                        cardName = text;
                                      },
                                      initialValue: bankCardInfo[1]['name'],
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                          icon: Icon(
                                            Icons.person,
                                            color: Color.fromARGB(
                                                255, 37, 179, 136),
                                          ),
                                          labelText: "Person Name",
                                          labelStyle: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 37, 179, 136))),
                                    ),
                                    TextFormField(
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return null;
                                        } else if (value.length < 16) {
                                          return "The card number must be just 16";
                                        } else {
                                          return null;
                                        }
                                      },
                                      onSaved: (text) {
                                        cardNum = text;
                                      },
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          icon: Icon(
                                            Icons.credit_card_outlined,
                                            color: Color.fromARGB(
                                                255, 37, 179, 136),
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
                                              if (value!.length < 4) {
                                                return "Wrong Exp. Date";
                                              } else {
                                                return null;
                                              }
                                            },
                                            onSaved: (text) {
                                              cardDate = text;
                                            },
                                            initialValue: bankCardInfo[2]
                                                ['expDate'],
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
                                                        255, 37, 179, 136))),
                                            maxLength: 5,
                                          ),
                                        ),
                                        Expanded(
                                          child: TextFormField(
                                            validator: (value) {
                                              if (value!.length < 3) {
                                                return "must be 3 numbers";
                                              } else {
                                                return null;
                                              }
                                            },
                                            onSaved: (text) {
                                              cardCVV = int.parse(text!);
                                            },
                                            initialValue: bankCardInfo[3]['cvv']
                                                .toString(),
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                                icon: Icon(
                                                  Icons.password,
                                                  color: Color.fromARGB(
                                                      255, 37, 179, 136),
                                                ),
                                                labelText: "CVV",
                                                labelStyle: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 37, 179, 136))),
                                            maxLength: 3,
                                          ),
                                        )
                                      ],
                                    ),
                                    Divider(
                                      color: Colors.white,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: MaterialButton(
                                            color: Color.fromARGB(
                                                255, 37, 179, 136),
                                            onPressed: () {
                                              if (EditCardData()) {
                                                setState(() {
                                                  showCardEdit = false;
                                                });
                                                showSuccessSnackBarMSG();
                                              } else {
                                                showFaildSnackBarMSG();
                                              }
                                            },
                                            child: Text(
                                              "Save",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: TextButton(
                                            child: Text(
                                              "Cancel",
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 37, 179, 136)),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                showCardEdit = false;
                                              });
                                            },
                                          ),
                                        )
                                      ],
                                    )
                                  ]),
                                )))
                      ]),
                    ),
                    /*************************************** End Visa Card Information ********************************** */
                  ]);
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: Text("Loading"));
            }
            return Center(child: Text("Loading"));
          }),
    );
  }

/************************************************ Start Functions Section *********************************** */
  Wrap wrapFavoriteContent() {
    return Wrap(
      direction: Axis.horizontal,
      children: listGenerate(),
    );
  }

  listGenerate() {
    return List.generate(favorite.length, (index) {
      return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            // ignore: prefer_const_literals_to_create_immutables
            boxShadow: [
              BoxShadow(
                  color: Color.fromARGB(255, 197, 197, 197), blurRadius: 4)
            ],
            borderRadius: BorderRadius.circular(30),
          ),
          padding: EdgeInsets.symmetric(horizontal: 10),
          margin: EdgeInsets.only(left: 5, bottom: 15, right: 5),
          alignment: Alignment.center,
          width: 180,
          height: 40,
          child: Row(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Expanded(child: Icon(Icons.food_bank)),
              Expanded(
                flex: 3,
                child: Container(
                  child: Text(
                    "${favorite[index]['name']}", // ${favorite[index]['name']}
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ),
              Expanded(
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          favorite.removeAt(index);
                        });
                      },
                      icon: Icon(Icons.close),
                      splashColor: Colors.white))
            ],
          ));
    });
  }

  Wrap wrapFavoriteContentCheckBox() {
    return Wrap(
      direction: Axis.horizontal,
      children: CheckBoxGenerate(),
    );
  }

  CheckBoxGenerate() {
    return List.generate(favoriteCkeckBox.length, (index) {
      return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            // ignore: prefer_const_literals_to_create_immutables
            boxShadow: [
              BoxShadow(
                  color: Color.fromARGB(255, 197, 197, 197), blurRadius: 4)
            ],
            borderRadius: BorderRadius.circular(30),
          ),
          padding: EdgeInsets.symmetric(horizontal: 10),
          margin: EdgeInsets.only(left: 5, bottom: 15, right: 5),
          alignment: Alignment.center,
          width: 180,
          height: 40,
          child: Row(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Expanded(child: Icon(Icons.food_bank)),
              Expanded(
                flex: 2,
                child: Container(
                  child: Text(
                    "${favoriteCkeckBox[index]['name']}", // ${favorite[index]['name']}
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              )
            ],
          ));
    });
  }

  ListTile listTileInfo(String tileTitle, int whichInfo) {
    return ListTile(
      title: Text(
        tileTitle,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      trailing: IconButton(
        splashColor: Color.fromARGB(255, 37, 179, 136),
        alignment: Alignment.centerLeft,
        color: Color.fromARGB(255, 37, 179, 136),
        icon: Icon(Icons.edit_note),
        onPressed: () {
          if (whichInfo == 0) {
            setState(() {
              notEnable = true;
              showSaveInfo = true;
            });
          } else if (whichInfo == 1) {
            setState(() {
              showFavEdit = true;
            });
          } else if (whichInfo == 2) {
            setState(() {
              showCardEdit = true;
            });
          }
        },
      ),
    );
  }

  String convertString(String convert) {
    List<String> convertString = convert.split("");
    String finalConvert = "";
    for (int i = 0; i < 4; i++) {
      finalConvert += convertString[i];
    }
    finalConvert += " XXXX XXXX XXXX";
    return finalConvert;
  }

  Container cardInfo(String infoType, int infoNum, double fontSize) {
    return Container(
      alignment: Alignment.centerLeft,
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 15),
      child: Text(
        infoNum == 0
            ? convertString("${bankCardInfo[infoNum][infoType]}")
            : "${bankCardInfo[infoNum][infoType]}",
        style: TextStyle(
            color: Colors.white,
            fontSize: fontSize,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  bool EditName() {
    // Start Function for edit name validation
    var formNameData = formStateForName.currentState;

    if (formNameData!.validate()) {
      formNameData.save();

      return true;
    } else {
      return false;
    }
    // End Function for edit name validation
  }

  editName() {
    return showDialog(
        context: context,
        builder: (context) {
          return Form(
            key: formStateForName,
            child: AlertDialog(
                title: Row(
                  children: [
                    Container(
                        margin: EdgeInsets.only(right: 5),
                        child: Icon(
                          Icons.edit_note,
                          color: Color.fromARGB(255, 37, 179, 136),
                        )),
                    Text("Edit Name")
                  ],
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      initialValue: inital!,
                      autovalidateMode: AutovalidateMode.always,
                      validator: (value) {
                        if (value!.length < 2) {
                          return "Invalid input";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (first) {
                        firstName = first;
                      },
                      maxLength: 15,
                      keyboardType: TextInputType.name,
                      cursorColor: Color.fromARGB(255, 37, 179, 136),
                      decoration: InputDecoration(
                          labelText: "First Name",
                          labelStyle: TextStyle(
                              color: Color.fromARGB(255, 37, 179, 136)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 37, 179, 136)))),
                    ),
                    TextFormField(
                      initialValue: inital2,
                      autovalidateMode: AutovalidateMode.always,
                      validator: (value) {
                        if (value!.length < 2) {
                          return "Invalid input";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (last) {
                        lastName = last;
                      },
                      maxLength: 15,
                      keyboardType: TextInputType.name,
                      cursorColor: Color.fromARGB(255, 37, 179, 136),
                      decoration: InputDecoration(
                          labelText: "Last Name",
                          labelStyle: TextStyle(
                              color: Color.fromARGB(255, 37, 179, 136)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 37, 179, 136)))),
                    )
                  ],
                ),
                actions: [
                  MaterialButton(
                    color: Color.fromARGB(255, 37, 179, 136),
                    onPressed: () {
                      if (EditName()) {
                        setState(() {
                          updateUName();
                          Navigator.of(context).pop();
                          showSuccessSnackBarMSG();
                        });
                      } else {
                        Navigator.of(context).pop();
                        showFaildSnackBarMSG();
                      }
                    },
                    child: Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  TextButton(
                    child: Text(
                      "Cancel",
                      style:
                          TextStyle(color: Color.fromARGB(255, 37, 179, 136)),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ]),
          );
        });
  }

  showSuccessSnackBarMSG() {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Color.fromARGB(255, 37, 179, 136).withOpacity(0.7),
      content: Row(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Container(
            margin: EdgeInsets.only(right: 15),
            child: Icon(
              Icons.check_circle_rounded,
              color: Colors.white,
              size: 35,
            ),
          ),
          Text(
            "Saved",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )
        ],
      ),
      duration: Duration(seconds: 2),
      margin: EdgeInsets.all(20),
    ));
  }

  showFaildSnackBarMSG() {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.red.withOpacity(0.7),
      content: Row(
        // ignore: prefer_const_literals_to_create_immutables
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
            "Save Faild",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )
        ],
      ),
      duration: Duration(seconds: 2),
      margin: EdgeInsets.all(20),
    ));
  }

/************************************************ End Functions Section *********************************** */

}
