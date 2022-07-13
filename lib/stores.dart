// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:fast_and_yummy/store_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Stores extends StatefulWidget {
  const Stores({Key? key}) : super(key: key);

  @override
  State<Stores> createState() => _StoresState();
}

class _StoresState extends State<Stores> {
  TextEditingController searchValue =
      TextEditingController(); // variable to store text field value in it
  int selectedNavBarItem = 2;
  bool showAppBar = true;
  Color color = Colors.black;
  List<Map> stores = [
    {
      "image": "images/90.jpg",
      "store": "90-s Burgar",
      "product": "19 Product",
      "feedback": "58 Feed Back",
      "fav": false,
      "icon": Icon(Icons.favorite_border_outlined),
    },
    {
      "image": "images/kfc.png",
      "store": "KFC",
      "product": "22 Product",
      "feedback": "130 Feed Back",
      "fav": false,
      "icon": Icon(Icons.favorite_border_outlined),
    },
    {
      "image": "images/macdonald.png",
      "store": "Macdonald",
      "product": "29 Product",
      "feedback": "105 Feed Back",
      "fav": false,
      "icon": Icon(Icons.favorite_border_outlined),
    },
    {
      "image": "images/Starbucks.jpg",
      "store": "Starbucks",
      "product": "15 Product",
      "feedback": "97 Feed Back",
      "fav": false,
      "icon": Icon(Icons.favorite_border_outlined),
    }
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: appBarDesign(),
      body: ListView.builder(
          itemCount: 4,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, i) {
            return MaterialButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StoreProduct(),
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.all(10),
                width: size.width,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(255, 179, 179, 179),
                        blurRadius: 4)
                  ],
                  color: Color.fromARGB(255, 240, 240, 240),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 37, 179, 136),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15)),
                      ),
                      child: Stack(
                        children: [
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15)),
                                image: DecorationImage(
                                    image: AssetImage("${stores[i]['image']}"),
                                    fit: BoxFit.cover)),
                          ),
                          Positioned(
                            bottom: 5,
                            right: 5,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(100),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromARGB(255, 133, 133, 133),
                                      blurRadius: 4)
                                ],
                              ),
                              child: IconButton(
                                color: stores[i]["fav"] == false
                                    ? Colors.black
                                    : Colors.red,
                                iconSize: 40,
                                icon: stores[i]["icon"],
                                onPressed: () {
                                  setState(() {
                                    if (stores[i]["fav"] == false) {
                                      stores[i]["fav"] = true;
                                      stores[i]["icon"] = Icon(Icons.favorite);
                                    } else {
                                      stores[i]["fav"] = false;
                                      stores[i]["icon"] =
                                          Icon(Icons.favorite_border_outlined);
                                    }
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${stores[i]['store']}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                          Row(
                            children: [
                              iconDesign(1),
                              iconDesign(1),
                              iconDesign(1),
                              iconDesign(1),
                              iconDesign(0),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${stores[i]['product']}",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            "${stores[i]['feedback']}",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  Icon iconDesign(int i) {
    return Icon(
      i == 1 ? Icons.star : Icons.star_border_outlined,
      size: 25,
      color: Colors.amberAccent,
    );
  }

  appBarDesign() {
    if (showAppBar) {
      return AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        toolbarHeight: 65,
        title: TextFormField(
          onEditingComplete: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(searchValue.text),
                  );
                });
          },

          controller:
              searchValue, // take text value and store it in searchValue variable
          textInputAction: TextInputAction.go,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 1),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.grey,
            ),
            filled: true,
            fillColor: Color.fromARGB(255, 231, 231, 231),
            hintText: "Search",
            focusedBorder: outLDesign(),
            enabledBorder: outLDesign(),
            disabledBorder: outLDesign(),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 37, 179, 136),
        elevation: 0,
      );
    } else {
      return AppBar(
        toolbarHeight: 0,
        backgroundColor: Color.fromARGB(255, 37, 179, 136),
      );
    }
  }

  OutlineInputBorder outLDesign() {
    return OutlineInputBorder(
        gapPadding: 10,
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Colors.white, width: 1));
  }
}