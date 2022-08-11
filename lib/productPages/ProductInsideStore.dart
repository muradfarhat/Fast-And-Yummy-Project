// ignore_for_file: prefer_const_constructors, slash_for_doc_comments, non_constant_identifier_names, must_be_immutable
import 'package:fast_and_yummy/api/linkapi.dart';
import 'package:fast_and_yummy/productPages/editProduct.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../main.dart';

class ProductInsideStore extends StatefulWidget {
  dynamic product;
  String cat;
  bool flag = false;
  ProductInsideStore(this.product, this.cat, {Key? key}) : super(key: key);

  @override
  State<ProductInsideStore> createState() => _ProductInsideStoreState();
}

class _ProductInsideStoreState extends State<ProductInsideStore> {
  @override
  void initState() {
    bringProduct();
    bringComments();
    super.initState();
  }

  dynamic list;
  bringProduct() async {
    setState(() {
      loading = true;
    });
    var resp = await api.postReq(bringProductLink, {
      "tableName": widget.cat,
      "productID": widget.product['productID'],
    });
    setState(() {
      loading = false;
    });
    if (resp['status'] == "suc") {
      setState(() {
        list = resp['data'];
      });
      if (!widget.flag) {
        setState(() {
          var arr = list[0]['content'].split(",");
          for (int i = 0; i < arr.length; i++) {
            content.add(arr[i]);
          }
          widget.flag = true;
        });
      }
    } else {}
  }

  editDescContentPrice(String reqName, String value) async {
    setState(() {
      loading = true;
    });

    var resp = await api.postReq(editInfo, {
      "tableName": widget.cat,
      "productID": widget.product['productID'],
      "reqName": reqName.toString(),
      "value": value
    });
    setState(() {
      loading = false;

      widget.flag = true;
    });
    if (resp['status'] == "suc") {
    } else {}
  }

  editContent() async {
    if (content.isEmpty) {
      showFaildSnackBarMSG("Should be at least have one content");
    } else {
      setState(() {
        loading = true;
      });
      String s = "";
      setState(() {
        for (int i = 0; i < content.length; i++) {
          s += content[i];
          if (i + 1 != content.length) {
            s += ",";
          }
        }
        setState(() {
          showContentSave = false;
          widget.flag = false;
        });
      });

      editDescContentPrice("content", s.toString());
    }
  }

  Color basicColor = Color.fromARGB(255, 37, 179, 136);

  List content = [];
  List contenttemp = [];
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

  List feedback = [];
  List feedback2 = [];
  GlobalKey<FormState> formStateForName =
      GlobalKey<FormState>(); // For Text Filed in name Info

  GlobalKey<FormState> formStateForDescription =
      GlobalKey<FormState>(); // For Text Filed in Description Info

  GlobalKey<FormState> formStateForContent =
      GlobalKey<FormState>(); // For Text Filed in Content Info

  GlobalKey<FormState> formStateForPrice =
      GlobalKey<FormState>(); // For Text Filed in Price Info

  GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>(); // For snackBar

/************************************** Start Functions for edit Name & Price *********************************** */
  bool EditNameData() {
    var formNameData = formStateForName.currentState;

    if (formNameData!.validate()) {
      formNameData.save();

      return true;
    } else {
      return false;
    }
  }

  bool loading2 = false;
  bringComments() async {
    setState(() {
      loading2 = true;
    });
    var resp = await api.postReq(bringCommentLink, {
      "productID": widget.product['productID'],
    });
    setState(() {
      loading2 = false;
    });
    if (resp['status'] == "suc") {
      setState(() {
        feedback2 = resp['data'];
        feedback = feedback2;
      });
    } else {}
  }

  bool EditDescriptionData() {
    var formDescData = formStateForDescription.currentState;

    if (formDescData!.validate()) {
      formDescData.save();

      editDescContentPrice("description", newDesc!);
      bringProduct();

      return true;
    } else {
      return false;
    }
  }

  bool EditPriceData() {
    var formPriceData = formStateForPrice.currentState;

    if (formPriceData!.validate()) {
      formPriceData.save();

      editDescContentPrice("price", newPrice.toString());
      bringProduct();
      return true;
    } else {
      return false;
    }
  }

  bool EditContentData() {
    var formContentData = formStateForContent.currentState;

    if (formContentData!.validate()) {
      formContentData.save();

      setState(() {
        content.add(newContent);
      });

      return true;
    } else {
      return false;
    }
  }

  bool loading = false;

/************************************** End Functions for edit Name & Price *********************************** */

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: basicColor,
      ),
      body: loading
          ? SizedBox(
              height: size.height,
              width: size.width,
              child: Center(
                child: CircularProgressIndicator(color: basicColor),
              ),
            )
          : SingleChildScrollView(
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
                                image: NetworkImage(
                                    "$imageRoot/${list[0]['image']}"))),
                        child: Text(
                          "${list[0]['productName']}",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 35),
                        ),
                      ),
                      IconButton(
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
                                      double.parse(list[0]['rate'])
                                          .toStringAsFixed(2),
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
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) =>
                                            EditProduct(list[0], widget.cat),
                                      ))
                                          .then((value) async {
                                        setState(() {
                                          bringProduct();
                                        });
                                      });
                                    },
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
                          margin:
                              EdgeInsets.only(right: 15, left: 15, bottom: 15),
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
                                initialValue: "${list[0]["description"]}",
                                decoration: InputDecoration(
                                    hintText: "Add Description"),
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
                                          onPressed: () async {
                                            if (EditDescriptionData()) {
                                              setState(() {
                                                showDescriptionSave = false;
                                                enableDescEdit = false;
                                              });

                                              showSuccessSnackBarMSG();
                                            } else {
                                              showFaildSnackBarMSG(
                                                  "Save Faild");
                                            }
                                          },
                                          child: Text(
                                            "Save",
                                            style:
                                                TextStyle(color: Colors.white),
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
                          ),
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
                              margin: EdgeInsets.symmetric(horizontal: 15),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Flexible(
                                        child: TextFormField(
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "must content";
                                            } else if (value.length <= 2) {
                                              return "Invalid input";
                                            } else {
                                              return null;
                                            }
                                          },
                                          onSaved: (value) {
                                            newContent = value;
                                          },
                                          maxLength: 20,
                                          decoration: InputDecoration(
                                              hintText: "Add Content"),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          EditContentData();
                                        },
                                        child: Icon(
                                          Icons.add,
                                          color: basicColor,
                                        ),
                                      )
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 10, right: 10, bottom: 10),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: MaterialButton(
                                            color: basicColor,
                                            onPressed: () async {
                                              editContent();
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
                                            onPressed: () {
                                              setState(() {
                                                showContentSave = false;
                                              });
                                            },
                                            child: Text(
                                              "Cancel",
                                              style:
                                                  TextStyle(color: basicColor),
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
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: Text(
                              "Feedback",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: RatingBarIndicator(
                              rating: double.parse(list[0]['rate']),
                              itemSize: 35,
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
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
                                      title: Text(
                                          "${feedback[index]["userName"]}"),
                                      subtitle:
                                          Text("${feedback[index]["comment"]}"),
                                      leading: Container(
                                        padding: EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
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
                            margin: EdgeInsets.only(
                                left: 10, right: 10, bottom: 10),
                            child: Row(
                              children: [
                                Expanded(child: Text("Price : ")),
                                Expanded(
                                    child: Container(
                                  margin: EdgeInsets.only(right: 10),
                                  child: TextFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      RegExp priceReg = RegExp(
                                          r"^[+-]?([0-9]+([.][0-9]*)?|[.][0-9]+)$");
                                      if (value!.isEmpty) {
                                        return "you must add price";
                                      }
                                      if (!priceReg.hasMatch(value)) {
                                        return "Price should\nhave only\n digits";
                                      }

                                      if (double.parse(value) > 200) {
                                        return "Should be\nless than \$200";
                                      }
                                    },
                                    onSaved: (value) {
                                      newPrice = double.parse(value!);
                                    },
                                    enabled: enableEdit,
                                    keyboardType: TextInputType.number,
                                    initialValue: "${list[0]["price"]}",
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
                                    onPressed: () async {
                                      if (EditPriceData()) {
                                        setState(() {
                                          showPriceSave = false;
                                          enableEdit = false;
                                        });
                                        showSuccessSnackBarMSG();
                                      } else {
                                        showFaildSnackBarMSG("Save Faild");
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
                        SizedBox(
                          height: 20,
                        )
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
    return List.generate(content.length, (index) {
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
                child: Text(
                  "${content[index]}", // ${favorite[index]['name']}
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 17),
                ),
              ),
              Expanded(
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          if (content.length - 1 != 0) {
                            content.removeAt(index);
                            editContent();
                          } else {
                            showFaildSnackBarMSG(
                                "Cann't delete, it should have at least on contetn");
                          }
                        });
                      },
                      icon: Icon(Icons.close),
                      splashColor: Colors.white))
            ],
          ));
    });
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

  showFaildSnackBarMSG(String text) {
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
          Flexible(
            child: Text(
              text,
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

  /******************************************** End Finctions Section ********************************** */
}
