// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class profile extends StatefulWidget {
  profile({Key? key}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  bool hidePass = true;
  bool hidePass2 = true;
  bool notEnable = false;
  bool showSaveInfo = false;

  List<Map> personalInfo = [
    {"name": "Customer Name"},
    {"email": "customer@email.com"},
    {"password": "12345678"},
    {"phone": "+970 598 418 464"},
    {"address": "Bieta, Nablus"},
    {"image": "images/profile.jpg"}
  ];

  List<Map> favorite = [
    {"name": "Sweet"},
    {"name": "Meat"},
    {"name": "Drinks"},
    {"name": "Traditional"},
    {"name": "Traditional"}
  ];
  List<Map> bankCardInfo = [
    {"cardNumber": "5555 XXXX XXXX XXXX"},
    {"name": "Person Name"},
    {"expDate": '10/23'},
    {"cvv": 999}
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        /*************************************** Start header => User image and name *************************** */
        Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 37, 179, 136),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(100),
                bottomRight: Radius.circular(100)),
          ),
          padding: EdgeInsets.only(bottom: 10),
          child: Column(children: [
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 30, bottom: 20),
                  height: 150,
                  width: 150,

                  // ignore: prefer_const_constructors
                  decoration: BoxDecoration(
                    // ignore: prefer_const_literals_to_create_immutables
                    boxShadow: [BoxShadow(color: Colors.white, blurRadius: 10)],
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("${personalInfo[5]['image']}")),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                Positioned(
                  bottom: 15,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100)),
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
                    child: Text("${personalInfo[0]['name']}",
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
        ),
        /*************************************** End header => User image and name *************************** */

        /*************************************** Start Personal Information ********************************** */
        Card(
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              listTileInfo('Personal Information', 0),
              Container(
                margin: EdgeInsets.only(left: 15, bottom: 15, right: 15),
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: "${personalInfo[1]['email']}",
                      enabled: false,
                      decoration: InputDecoration(
                        icon: Icon(Icons.email,
                            color: Color.fromARGB(255, 37, 179, 136)),
                      ),
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    TextFormField(
                      initialValue: "${personalInfo[2]['password']}",
                      enabled: notEnable,
                      obscureText: hidePass,
                      decoration: InputDecoration(
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
                                color: Color.fromARGB(255, 37, 179, 136),
                              )),
                        ),
                        icon: Icon(Icons.password,
                            color: Color.fromARGB(255, 37, 179, 136)),
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
                              //initialValue: "${personalInfo[2]['password']}",
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
                                          : Icons.visibility_off_sharp,
                                      color: Color.fromARGB(255, 37, 179, 136),
                                    )),
                                hintText: "Confirm Password",
                                icon: Icon(Icons.password,
                                    color: Color.fromARGB(255, 37, 179, 136)),
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
                      initialValue: "${personalInfo[3]['phone']}",
                      keyboardType: TextInputType.number,
                      enabled: notEnable,
                      decoration: InputDecoration(
                        icon: Icon(Icons.phone,
                            color: Color.fromARGB(255, 37, 179, 136)),
                      ),
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    TextFormField(
                      initialValue: "${personalInfo[4]['address']}",
                      enabled: notEnable,
                      decoration: InputDecoration(
                        icon: Icon(Icons.edit_location,
                            color: Color.fromARGB(255, 37, 179, 136)),
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
                              color: Color.fromARGB(255, 37, 179, 136),
                              onPressed: () {},
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
                                setState(() {
                                  notEnable = false;
                                  showSaveInfo = false;
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
        /*************************************** End Personal Information ********************************** */

        /*************************************** Start Favorite Information ********************************** */
        Card(
          child: Column(
            children: [
              listTileInfo('Favorite Information', 1),
              Container(
                //margin: EdgeInsets.only(left: 15, bottom: 15),
                child: wrapFavoriteContent(), // Wrap Function
              ),
            ],
          ),
        ),
        /*************************************** End Favorite Information ********************************** */

        /*************************************** Satrt Visa Card Information ********************************** */
        Card(
          child: Column(children: [
            listTileInfo('Credit Card Information', 2),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 15),
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ),
                          Text(
                            "${bankCardInfo[2]['expDate']}",
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ),
                          Text(
                            "${bankCardInfo[3]['cvv']}",
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
            )
          ]),
        ),
        /*************************************** End Visa Card Information ********************************** */
      ]),
    );
  }

/************************************************ Start Functions *********************************** */
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
                      onPressed: () {},
                      icon: Icon(Icons.close),
                      splashColor: Colors.white))
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
        splashColor: Colors.white,
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
            editFavoreiteInfo();
          } else if (whichInfo == 2) {
            editCreditCardInfo();
          }
        },
      ),
    );
  }

  Container cardInfo(String infoType, int infoNum, double fontSize) {
    return Container(
      alignment: Alignment.centerLeft,
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 15),
      child: Text(
        "${bankCardInfo[infoNum][infoType]}",
        style: TextStyle(
            color: Colors.white,
            fontSize: fontSize,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  editName() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
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
              content: TextFormField(
                keyboardType: TextInputType.name,
                cursorColor: Color.fromARGB(255, 37, 179, 136),
                decoration: InputDecoration(
                    hintText: "New Name",
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 37, 179, 136)))),
              ),
              actions: [
                MaterialButton(
                  color: Color.fromARGB(255, 37, 179, 136),
                  onPressed: () {},
                  child: Text(
                    "Save",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                TextButton(
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: Color.fromARGB(255, 37, 179, 136)),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ]);
        });
  }

  editFavoreiteInfo() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Edit Favorite Information"),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(),
                ],
              ),
            ),
            actions: [
              MaterialButton(
                color: Color.fromARGB(255, 37, 179, 136),
                onPressed: () {},
                child: Text(
                  "Save",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              TextButton(
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Color.fromARGB(255, 37, 179, 136)),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  editCreditCardInfo() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Edit Credit Card Information"),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(),
                ],
              ),
            ),
            actions: [
              MaterialButton(
                color: Color.fromARGB(255, 37, 179, 136),
                onPressed: () {},
                child: Text(
                  "Save",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              TextButton(
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Color.fromARGB(255, 37, 179, 136)),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

/************************************************ End Functions *********************************** */

}
