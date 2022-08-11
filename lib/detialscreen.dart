// ignore_for_file: prefer_const_constructors, must_be_immutable, no_logic_in_create_state
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:fast_and_yummy/api/api.dart';
import 'package:fast_and_yummy/userpage/oneOrader.dart';
import 'package:fast_and_yummy/userpage/orderMapChoose.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'api/linkapi.dart';
import 'main.dart';

class Detialscreen extends StatefulWidget {
  dynamic list;
  bool flag = false;
  dynamic storeID;
  dynamic cateID;
  Detialscreen(this.list, this.storeID, this.cateID, {Key? key})
      : super(key: key);

  @override
  State<Detialscreen> createState() => _DetialscreenState();
}

class _DetialscreenState extends State<Detialscreen> {
  double count = 1.00;
  double total = 1.00;
  bool comment = false;

  List feedback = [];
  bool enableRating = true;
  double rate = 0.0;
  double initalRate = 0.0;
  dynamic feedBackList = [];
  double? productRate;
  bool? fav;

  dynamic orderDetail = [];
  @override
  void initState() {
    total = double.parse(widget.list['price']) * count;
    bringComments();
    bringRate();
    favourite();
    if (!widget.flag) {
      setState(() {
        var arr = widget.list['content'].split(",");
        for (int i = 0; i < arr.length; i++) {
          content.add(arr[i]);
        }
        widget.flag = true;
      });
    }
    setState(() {
      orderDetail.add({
        "userID": sharedPref.getString('id'),
        "storeID": widget.storeID,
        "cateID": widget.cateID,
        "orderID": widget.list['productID'],
        "quantity": count.toString()
      });
    });
    super.initState();
  }

  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController commentField = TextEditingController();
  Api api = Api();
  addComment() async {
    if (formstate.currentState!.validate()) {
      String fullName =
          "${sharedPref.getString("first_name")} ${sharedPref.getString("last_name")}";

      var resp = await api.postReq(commentLink, {
        "storeID": widget.storeID.toString(),
        "userID": sharedPref.getString("id"),
        "productID": widget.list['productID'],
        "userName": fullName,
        "comment": commentField.text,
        "cateID": widget.cateID.toString(),
      });

      if (resp['status'] == "suc") {
        setState(() {
          commentField.clear();
          comment = !comment;
        });
        bringComments();
        snackBarMSG(
            "Comment added,Thank you", color, Icons.check_circle_outline, 2);
      } else {}
    }
  }

  setFav() async {
    var resp = await api.postReq(setfavLink, {
      "userID": sharedPref.getString("id"),
      "orderID": widget.list['productID'],
      "cateID": widget.cateID.toString(),
    });

    favourite();
  }

  favourite() async {
    setState(() {
      loading2 = true;
    });
    var resp = await api.postReq(favLink, {
      "userID": sharedPref.getString("id"),
      "orderID": widget.list['productID'],
      "cateID": widget.cateID.toString(),
    });
    setState(() {
      loading2 = false;
    });
    if (resp['status'] == "suc") {
      setState(() {
        fav = true;
      });
    } else {
      setState(() {
        fav = false;
      });
    }
  }

  rating() async {
    var resp = await api.postReq(rateLink, {
      "storeID": widget.storeID.toString(),
      "userID": sharedPref.getString("id"),
      "productID": widget.list['productID'],
      "cateID": widget.cateID.toString(),
      "rate": rate.toString(),
      "oldrate": initalRate.toString()
    });

    bringRate();
  }

  bringRate() async {
    setState(() {
      loading4 = true;
    });
    var resp = await api.postReq(bringRateLink, {
      "userID": sharedPref.getString("id"),
      "cateID": widget.cateID.toString(),
      "productID": widget.list['productID'],
    });
    setState(() {
      loading4 = false;
    });
    if (resp['status'] == "suc") {
      setState(() {
        initalRate = double.parse(resp['data']['rate']);
        productRate = double.parse(resp["rate"]["rate"]);
        String inString = productRate!.toStringAsFixed(2); // '2.35'
        productRate = double.parse(inString);
      });
    } else {
      productRate = double.parse(resp["rate"]["rate"]);
      String inString = productRate!.toStringAsFixed(2); // '2.35'
      productRate = double.parse(inString);
    }
  }

  bringComments() async {
    setState(() {
      loading3 = true;
    });
    var resp = await api.postReq(bringCommentLink, {
      "productID": widget.list['productID'],
    });
    setState(() {
      loading3 = false;
    });
    if (resp['status'] == "suc") {
      setState(() {
        feedBackList = resp['data'];
        feedback = feedBackList;
      });
    } else {}
  }

  addToCart() async {
    var resp = await api.postReq(addToCartLink, {
      "userID": sharedPref.getString("id"),
      "cateID": widget.cateID.toString(),
      "orderID": widget.list['productID'],
      "storeID": widget.storeID.toString(),
      "quantity": count.toString()
    });
    if (resp['status'] == "suc") {
      snackBarMSG(
          "This product already in cart,you can change quantity in your Cart Page",
          Colors.orange,
          Icons.cancel_outlined,
          4);
    } else {
      snackBarMSG("Product added to your,Thank you", color,
          Icons.check_circle_outline, 2);
    }
  }

  List content = [];
  bool visable = true;
  bool love = false;
  Color color = Color.fromARGB(255, 37, 179, 136);
  IconData icon = Icons.rate_review;
  bool loading2 = false;
  bool loading3 = false;
  bool loading4 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: color,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                              Colors.black.withOpacity(0.5), BlendMode.darken),
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              "$imageRoot/${widget.list['image']}"))),
                  child: Text(
                    "${widget.list['productName']}",
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
                Positioned(
                  left: 20,
                  bottom: 15,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 5),
                              child: Text(
                                "$productRate",
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
                      ]),
                ),
                Positioned(
                    right: 20,
                    bottom: 15,
                    child: loading2
                        ? Center(
                            child: CircularProgressIndicator(color: color),
                          )
                        : Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100))),
                            child: InkWell(
                              onTap: () {
                                setFav();
                              },
                              child: Icon(
                                fav!
                                    ? Icons.favorite
                                    : Icons.favorite_border_outlined,
                                color: fav! ? Colors.red : Colors.black,
                                size: 30,
                              ),
                            ),
                          ))
              ],
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text(
                            "Description",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          trailing: Icon(
                            Icons.description_outlined,
                            color: color,
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
                            child: Text(widget.list['description']))
                      ],
                    ),
                  ),
                  Card(
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: Text(
                              "Content",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            trailing: Icon(
                              Icons.content_paste,
                              color: color,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
                            child: Wrap(
                              children: listGenerate(),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Column(children: [
                      ListTile(
                        title: Text(
                          "Feedback",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            loading4
                                ? Center(
                                    child:
                                        CircularProgressIndicator(color: color),
                                  )
                                : RatingBar.builder(
                                    ignoreGestures: enableRating,
                                    minRating: 0,
                                    glow: false,
                                    itemSize: 35,
                                    initialRating: initalRate,
                                    allowHalfRating: true,
                                    itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                    onRatingUpdate: (rating) {
                                      rate = rating;
                                    }),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  enableRating
                                      ? {enableRating = !enableRating}
                                      : {
                                          rating(),
                                          enableRating = !enableRating
                                        };
                                });
                              },
                              child: Icon(
                                enableRating ? Icons.rate_review : Icons.check,
                                size: 30,
                                color: color,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 150,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: feedback.isEmpty
                            ? Center(
                                child: Text(
                                  "No comment",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey),
                                ),
                              )
                            : loading3
                                ? Center(
                                    child:
                                        CircularProgressIndicator(color: color),
                                  )
                                : ListView.builder(
                                    itemCount: feedback.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                          title: Text(
                                              "${feedBackList[index]["userName"]}"),
                                          subtitle: Text(
                                              "${feedBackList[index]["comment"]}"),
                                          leading: Container(
                                            padding: EdgeInsets.all(15),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                color: color),
                                            child: Text("${index + 1}",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                )),
                                          ));
                                    }),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 0, 15, 20),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  comment = !comment;
                                });
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.comment,
                                    color: color,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Visibility(
                                    visible: !comment,
                                    child: Text("Add comment",
                                        style: TextStyle(
                                            color: color,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Form(
                              key: formstate,
                              child: Visibility(
                                visible: comment,
                                child: Flexible(
                                  child: TextFormField(
                                    controller: commentField,
                                    validator: (valid) {
                                      if (valid!.isEmpty) {
                                        return "Can't be empty";
                                      }
                                      if (valid.length < 4) {
                                        return "Must be more than 3 letter";
                                      }
                                    },
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    cursorColor:
                                        Color.fromARGB(255, 21, 157, 117),
                                    decoration: InputDecoration(
                                      hintText: "Add comment",
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 21, 157, 117)),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 21, 157, 117)),
                                      ),
                                      fillColor: Colors.black,
                                      hintStyle: TextStyle(
                                        fontFamily: "Prompt2",
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: comment,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        addComment();
                                      });
                                    },
                                    child: Icon(
                                      Icons.send,
                                      color: color,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ]),
                  ),
                  Card(
                    child: Container(
                      padding: EdgeInsets.all(18),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Quantity",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
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
                                        total =
                                            double.parse(widget.list['price']) *
                                                count;
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
                                        if (count != 1) {
                                          count--;
                                          total = double.parse(
                                                  widget.list['price']) *
                                              count;
                                        }
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
            SizedBox(
              height: 30,
            )
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
                "Total:  ${total.toStringAsFixed(2)} \$",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  primary: Colors.amber,
                ),
                onPressed: () {
                  setState(() {
                    orderDetail.clear();
                    orderDetail.add({
                      "userID": sharedPref.getString('id'),
                      "storeID": widget.storeID,
                      "cateID": widget.cateID,
                      "orderID": widget.list['productID'],
                      "quantity": count.toString()
                    });
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChooseLocation(
                          widget.list, orderDetail[0]), //OneOrder(),
                    ),
                  );
                },
                icon: Icon(
                  Icons.shopify,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Add to cart ?"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        MaterialButton(
                          color: Colors.amber,
                          onPressed: () {
                            addToCart();
                            Navigator.pop(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.check, color: Colors.black),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Yes",
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        MaterialButton(
                          elevation: 0,
                          color: Colors.white,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(Icons.close, color: Colors.black),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "No",
                                style: TextStyle(color: Colors.black),
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
        },
        backgroundColor: Colors.amber,
        child: Icon(
          Icons.shopping_cart_outlined,
          color: Colors.black,
          size: 30,
        ),
      ),
    );
  }

  listGenerate() {
    return List.generate(content.length, (index) {
      return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Color.fromARGB(255, 197, 197, 197), blurRadius: 4)
            ],
            borderRadius: BorderRadius.circular(30),
          ),
          padding: EdgeInsets.symmetric(horizontal: 10),
          margin: EdgeInsets.only(left: 5, bottom: 15, right: 5),
          alignment: Alignment.center,
          width: 150,
          height: 40,
          child: Row(
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
            ],
          ));
    });
  }

  Icon iconDesign(int i) {
    return Icon(
      i == 1 ? Icons.star : Icons.star_border_outlined,
      size: 28,
      color: Colors.amberAccent,
    );
  }

  snackBarMSG(String text, Color color, IconData icon, int duration) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: color.withOpacity(0.7),
      content: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 15),
            child: Icon(
              icon,
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
      duration: Duration(seconds: duration),
      margin: EdgeInsets.all(20),
    ));
  }
}
