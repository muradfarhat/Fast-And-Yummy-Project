// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class productInsideStore extends StatefulWidget {
  productInsideStore({Key? key}) : super(key: key);

  @override
  State<productInsideStore> createState() => _productInsideStoreState();
}

class _productInsideStoreState extends State<productInsideStore> {
  Color basicColor = Color.fromARGB(255, 37, 179, 136);

  List<Map> product = [
    {
      "image": "images/pizza.jpg",
      "name": "Pizza",
      "rate": "4.0",
      "price": 8.99,
      "description":
          "a dish made typically of flattened bread dough spread with a savory mixture usually including tomatoes and cheese and often other toppings and baked"
    }
  ];
  List<Map> productContent = [
    {"name": "mushroom"},
    {"name": "Onions"},
    {"name": "Cheese"},
  ];
  List<Map> feedback = [
    {"name": "Murad Farhat", "comment": "Good Pizza"},
    {"name": "Ra'ed Khwayreh", "comment": "Nice one"},
    {"name": "Murad Farhat", "comment": "Good Pizza"},
    {"name": "Ra'ed Khwayreh", "comment": "Nice one"},
    {"name": "Murad Farhat", "comment": "Good Pizza"},
    {"name": "Ra'ed Khwayreh", "comment": "Nice one"},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: basicColor,
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                        //color: Colors.black.withOpacity(0.5),
                        image: DecorationImage(
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.5),
                                BlendMode.darken),
                            fit: BoxFit.cover,
                            image: AssetImage("${product[0]["image"]}"))),
                    child: Text(
                      "${product[0]["name"]}",
                      // ignore: prefer_const_constructors
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 35),
                    ),
                  ),
                  IconButton(
                    // ignore: prefer_const_constructors
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () {},
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: 10, top: 150, right: 10, bottom: 10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 5),
                                child: Text(
                                  "${product[0]["rate"]}",
                                  // ignore: prefer_const_constructors
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow[600],
                              )
                            ],
                          ),
                          IconButton(
                              onPressed: () {},
                              // ignore: prefer_const_constructors
                              icon: Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 20,
                              ))
                        ]),
                  ),
                ],
              ),
              /************************************ Start Description Section ********************************* */
              Card(
                child: Column(children: [
                  listTileInfo("Description"),
                  Container(
                    margin: EdgeInsets.only(right: 15, left: 15, bottom: 15),
                    child: Text(
                      "${product[0]["description"]}",
                      style: TextStyle(fontSize: 17),
                    ),
                  )
                ]),
              ),
              /************************************ End Description Section ********************************* */
              /************************************ Start Content Section ********************************* */
              Card(
                child: Column(
                  children: [listTileInfo("Content"), wrapFavoriteContent()],
                ),
              ),
              /*********************************** End Content Section ********************************* */
              /************************************ Start Feedback Section ********************************* */
              Card(
                // ignore: prefer_const_literals_to_create_immutables
                child: Column(children: [
                  ListTile(
                    title: Text(
                      "Feedback",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        starIcon("${product[0]["rate"]}", 1.0),
                        starIcon("${product[0]["rate"]}", 2.0),
                        starIcon("${product[0]["rate"]}", 3.0),
                        starIcon("${product[0]["rate"]}", 4.0),
                        starIcon("${product[0]["rate"]}", 5.0),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 150,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: ListView.builder(
                        itemCount: feedback.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                              title: Text("${feedback[index]["name"]}"),
                              subtitle: Text("${feedback[index]["comment"]}"),
                              leading: Container(
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: basicColor),
                                child: Text("${index + 1}",
                                    style: TextStyle(
                                      color: Colors.white,
                                    )),
                              ));
                        }),
                  ),
                ]),
              ),
              /************************************ End Feedback Section ********************************* */
              /************************************ Start Price Section ********************************* */
              Card(
                child: Column(
                  children: [
                    listTileInfo("Price"),
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Row(
                        children: [
                          Expanded(child: Text("Price : ")),
                          Expanded(
                              child: TextFormField(
                            keyboardType: TextInputType.number,
                            initialValue:
                                "\$ ${product[0]["price"].toString()}",
                            decoration: InputDecoration(),
                          )),
                          Expanded(
                              child: Visibility(
                            visible: true,
                            child: MaterialButton(
                              color: basicColor,
                              onPressed: () {},
                              child: Text(
                                "Save",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )),
                          Expanded(
                              child: Visibility(
                            visible: true,
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                "Cancel",
                                style: TextStyle(color: basicColor),
                              ),
                            ),
                          ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              /************************************ End Price Section ********************************* */
            ],
          )),
    );
  }

  /******************************************** Start Finctions Section ********************************** */

  ListTile listTileInfo(String tileTitle) {
    return ListTile(
      title: Text(
        tileTitle,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      trailing: IconButton(
        splashColor: basicColor,
        alignment: Alignment.centerLeft,
        color: basicColor,
        icon: Icon(Icons.edit_note),
        onPressed: () {},
      ),
    );
  }

  Wrap wrapFavoriteContent() {
    return Wrap(
      direction: Axis.horizontal,
      children: listGenerate(),
    );
  }

  listGenerate() {
    return List.generate(productContent.length, (index) {
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
              Expanded(child: Icon(Icons.local_pizza)),
              Expanded(
                flex: 3,
                child: Container(
                  child: Text(
                    "${productContent[index]["name"]}", // ${favorite[index]['name']}
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ),
              Expanded(
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          productContent.removeAt(index);
                        });
                      },
                      icon: Icon(Icons.close),
                      splashColor: Colors.white))
            ],
          ));
    });
  }

  Icon starIcon(String rate, double num) {
    if (double.parse(rate) >= num) {
      return Icon(
        Icons.star,
        color: Colors.yellow[600],
        size: 30,
      );
    } else {
      return Icon(
        Icons.star_border,
        color: Colors.yellow[600],
        size: 30,
      );
    }
  }

  /******************************************** End Finctions Section ********************************** */
}
