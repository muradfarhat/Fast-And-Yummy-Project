// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

class ProductInsideStore extends StatefulWidget {
  const ProductInsideStore({Key? key}) : super(key: key);

  @override
  State<ProductInsideStore> createState() => _ProductInsideStoreState();
}

class _ProductInsideStoreState extends State<ProductInsideStore> {
  Color basicColor = Color.fromARGB(255, 37, 179, 136);

// variables for name & price information
  String? newName;
  String? newDesc;
  String? newContent;
  double? newPrice;
// variables for boolean values
  bool showDescriptionSave = false;
  bool enableDescEdit = false;
  bool showContentSave = false;
  bool showPriceSave = false;
  bool enableEdit = false;

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

  GlobalKey<FormState> formStateForName =
      new GlobalKey<FormState>(); // For Text Filed in name Info

  GlobalKey<FormState> formStateForDescription =
      new GlobalKey<FormState>(); // For Text Filed in Description Info

  GlobalKey<FormState> formStateForContent =
      new GlobalKey<FormState>(); // For Text Filed in Content Info

  GlobalKey<FormState> formStateForPrice =
      new GlobalKey<FormState>(); // For Text Filed in Price Info

  GlobalKey<ScaffoldState> scaffoldKey =
      new GlobalKey<ScaffoldState>(); // For snackBar

/************************************** Start Functions for edit Name & Price *********************************** */
  bool EditNameData() {
    var formNameData = formStateForName.currentState;

    if (formNameData!.validate()) {
      formNameData.save();

      product[0]["name"] = newName;

      return true;
    } else {
      return false;
    }
  }

  bool EditDescriptionData() {
    var formDescData = formStateForDescription.currentState;

    if (formDescData!.validate()) {
      formDescData.save();

      product[0]["description"] = newDesc;

      return true;
    } else {
      return false;
    }
  }

  bool EditPriceData() {
    var formPriceData = formStateForPrice.currentState;

    if (formPriceData!.validate()) {
      formPriceData.save();

      product[0]["price"] = newPrice;

      return true;
    } else {
      return false;
    }
  }

  bool EditContentData() {
    var formContentData = formStateForContent.currentState;

    if (formContentData!.validate()) {
      formContentData.save();

      productContent.add({"name": newContent});

      return true;
    } else {
      return false;
    }
  }

/************************************** End Functions for edit Name & Price *********************************** */

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
                    onPressed: () {
                      Navigator.pop(context);
                    },
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
                          Form(
                            key: formStateForName,
                            child: IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: (context),
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text("Edit product name"),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              TextFormField(
                                                autovalidateMode:
                                                    AutovalidateMode.always,
                                                initialValue:
                                                    "${product[0]["name"]}",
                                                validator: (productName) {
                                                  if (productName!.length < 5) {
                                                    return "Invalid input";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                onSaved: (name) {
                                                  newName = name;
                                                },
                                                maxLength: 12,
                                                decoration: InputDecoration(
                                                    icon: Icon(
                                                      Icons.edit_note,
                                                      color: basicColor,
                                                    ),
                                                    labelText: "Name",
                                                    labelStyle: TextStyle(
                                                        color: basicColor)),
                                              )
                                            ],
                                          ),
                                          actions: [
                                            MaterialButton(
                                              color: basicColor,
                                              onPressed: () {
                                                if (EditNameData()) {
                                                  setState(() {
                                                    Navigator.of(context).pop();
                                                  });
                                                  showSuccessSnackBarMSG();
                                                } else {
                                                  Navigator.of(context).pop();
                                                  showFaildSnackBarMSG();
                                                }
                                              },
                                              child: Text(
                                                "Save",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text(
                                                "Cancel",
                                                style: TextStyle(
                                                    color: basicColor),
                                              ),
                                            )
                                          ],
                                        );
                                      });
                                },
                                // ignore: prefer_const_constructors
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 20,
                                )),
                          )
                        ]),
                  ),
                ],
              ),
              /************************************ Start Description Section ********************************* */
              Card(
                child: Form(
                  key: formStateForDescription,
                  child: Column(children: [
                    listTileInfo("Description", 1),
                    Container(
                      margin: EdgeInsets.only(right: 15, left: 15, bottom: 15),
                      child: Form(
                          //key: formStateForDescription,
                          child: Column(
                        children: [
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "must write description";
                              } else if (value.length < 25) {
                                return "Invalid input";
                              } else {
                                return null;
                              }
                            },
                            onSaved: (value) {
                              newDesc = value;
                            },
                            enabled: enableDescEdit,
                            maxLength: 150,
                            maxLines: 4,
                            initialValue: "${product[0]["description"]}",
                            decoration:
                                InputDecoration(hintText: "Add Description"),
                          ),
                          Visibility(
                            visible: showDescriptionSave,
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: MaterialButton(
                                      color: basicColor,
                                      onPressed: () {
                                        if (EditDescriptionData()) {
                                          setState(() {
                                            showDescriptionSave = false;
                                            enableDescEdit = false;
                                          });
                                          showSuccessSnackBarMSG();
                                        } else {
                                          showFaildSnackBarMSG();
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
                                      onPressed: () {
                                        setState(() {
                                          showDescriptionSave = false;
                                          enableDescEdit = false;
                                        });
                                      },
                                      child: Text(
                                        "Cancel",
                                        style: TextStyle(color: basicColor),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      )),
                    )
                  ]),
                ),
              ),
              /************************************ End Description Section ********************************* */
              /************************************ Start Content Section ********************************* */
              Card(
                child: Form(
                  key: formStateForContent,
                  child: Column(
                    children: [
                      listTileInfo("Content", 2),
                      wrapFavoriteContent(),
                      Visibility(
                        visible: showContentSave,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                              TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "must write description";
                                  } else if (value.length <= 2) {
                                    return "Invalid input";
                                  } else {
                                    return null;
                                  }
                                },
                                onSaved: (value) {
                                  newContent = value;
                                },
                                maxLength: 12,
                                decoration:
                                    InputDecoration(hintText: "Add Content"),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 10, right: 10, bottom: 10),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: MaterialButton(
                                        color: basicColor,
                                        onPressed: () {
                                          if (EditContentData()) {
                                            setState(() {
                                              showContentSave = false;
                                            });
                                            showSuccessSnackBarMSG();
                                          } else {
                                            showFaildSnackBarMSG();
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
                                        onPressed: () {
                                          setState(() {
                                            showContentSave = false;
                                          });
                                        },
                                        child: Text(
                                          "Cancel",
                                          style: TextStyle(color: basicColor),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
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
                    listTileInfo("Price", 3),
                    Form(
                      key: formStateForPrice,
                      child: Container(
                        margin:
                            EdgeInsets.only(left: 10, right: 10, bottom: 10),
                        child: Row(
                          children: [
                            Expanded(child: Text("Price : ")),
                            Expanded(
                                child: Container(
                              margin: EdgeInsets.only(right: 10),
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "you must add price";
                                  } else if (double.parse(value) <= 0.0 ||
                                      double.parse(value) > 150.0) {
                                    return "invalid input";
                                  } else {
                                    return null;
                                  }
                                },
                                onSaved: (value) {
                                  newPrice = double.parse(value!);
                                },
                                enabled: enableEdit,
                                keyboardType: TextInputType.number,
                                initialValue: product[0]["price"].toString(),
                                decoration: InputDecoration(
                                    prefix: Container(
                                        margin: EdgeInsets.only(right: 5),
                                        child: Text("\$"))),
                              ),
                            )),
                            Expanded(
                                child: Visibility(
                              visible: showPriceSave,
                              child: MaterialButton(
                                color: basicColor,
                                onPressed: () {
                                  if (EditPriceData()) {
                                    setState(() {
                                      showPriceSave = false;
                                      enableEdit = false;
                                    });
                                    showSuccessSnackBarMSG();
                                  } else {
                                    showFaildSnackBarMSG();
                                  }
                                },
                                child: Text(
                                  "Save",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            )),
                            Expanded(
                                child: Visibility(
                              visible: showPriceSave,
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    enableEdit = false;
                                    showPriceSave = false;
                                  });
                                },
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(color: basicColor),
                                ),
                              ),
                            ))
                          ],
                        ),
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

  ListTile listTileInfo(String tileTitle, int select) {
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
        onPressed: () {
          if (select == 1) {
            setState(() {
              showDescriptionSave = true;
              enableDescEdit = true;
            });
          } else if (select == 2) {
            setState(() {
              showContentSave = true;
            });
          } else if (select == 3) {
            setState(() {
              enableEdit = true;
              showPriceSave = true;
            });
          }
        },
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

  showSuccessSnackBarMSG() {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: basicColor.withOpacity(0.7),
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

  /******************************************** End Finctions Section ********************************** */
}
