// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math' as math;

class profile extends StatefulWidget {
  profile({Key? key}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  List<Map> favorite = [
    {"name": "Sweet"},
    {"name": "Meat"},
    {"name": "Drinks"},
    {"name": "Traditional"}
  ];
  List<Map> bankCardInfo = [
    {"cardNumber": 5555555555555555},
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
                        image: AssetImage("images/profile.jpg")),
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
                    ))
              ],
            ),
            Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Expanded(child: Container()),
                Expanded(
                  flex: 3,
                  child: Container(
                    child: Text("Customer Name",
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
                      onPressed: () {},
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
              listTileInfo('Personal Information'),
              Container(
                margin: EdgeInsets.only(left: 15, bottom: 15),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.email,
                            color: Color.fromARGB(255, 37, 179, 136)),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text("customer@email.com"),
                        )
                      ],
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    Row(
                      children: [
                        Icon(Icons.password,
                            color: Color.fromARGB(255, 37, 179, 136)),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                            "**********",
                            style: TextStyle(letterSpacing: 5),
                          ),
                        )
                      ],
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    Row(
                      children: [
                        Icon(Icons.phone,
                            color: Color.fromARGB(255, 37, 179, 136)),
                        Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text("+970-598-418-464"))
                      ],
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Icon(Icons.location_city,
                            color: Color.fromARGB(255, 37, 179, 136)),
                        Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text("Beita, Nablus"))
                      ],
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
              listTileInfo('Favorite Information'),
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
            listTileInfo('Credit Card Information'),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 15),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.blue[600],
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
  wrapFavoriteContent() {
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

  ListTile listTileInfo(String tileTitle) {
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
        onPressed: () {},
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

/************************************************ End Functions *********************************** */

}
