// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class profile extends StatefulWidget {
  profile({Key? key}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
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
                    boxShadow: [BoxShadow(color: Colors.white, blurRadius: 4)],
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
              ListTile(
                title: Text(
                  'Personal Information',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                trailing: IconButton(
                  splashColor: Colors.white,
                  alignment: Alignment.centerLeft,
                  color: Color.fromARGB(255, 37, 179, 136),
                  iconSize: 20,
                  icon: Icon(Icons.edit),
                  onPressed: () {},
                ),
              ),
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
              ListTile(
                title: Text(
                  'Favorite Information',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                trailing: IconButton(
                  splashColor: Colors.white,
                  alignment: Alignment.centerLeft,
                  color: Color.fromARGB(255, 37, 179, 136),
                  iconSize: 20,
                  icon: Icon(Icons.edit),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
        /*************************************** End Favorite Information ********************************** */
      ]),
    );
  }
}
