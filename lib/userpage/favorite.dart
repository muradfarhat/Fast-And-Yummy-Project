// ignore_for_file: prefer_const_constructors

import 'package:fast_and_yummy/api/api.dart';
import 'package:fast_and_yummy/api/linkapi.dart';
import 'package:fast_and_yummy/main.dart';
import 'package:flutter/material.dart';

class favorite extends StatefulWidget {
  favorite({Key? key}) : super(key: key);

  @override
  State<favorite> createState() => _favoriteState();
}

class _favoriteState extends State<favorite> {
  List<dynamic> myFav = [];
  List<dynamic> favList = [];
/********************** Start Api Functions ********************************* */
  Api api = Api(); // Create API SELECT SCOPE_IDENTITY()

  bringAllFavorites() async {
    var response = await api
        .postReq(bringUserFavProducts, {"id": sharedPref.getString("id")});
    if (response['status'] == "suc") {
      setState(() {
        favList = response['data'];
        // '2.35'
      });
      forLoopForProducts();
    }
  }

  bringProductFromCate(String cateID, String productID) async {
    var resp = await api.postReq(bringNameOfCate, {"cateID": cateID});

    String? cateName;
    if (resp['status'] == "suc") {
      cateName = resp['data'];
    }
    cateName = cateName!.toLowerCase();

    var response = await api
        .postReq(bringProducts, {"id": productID, "cateName": cateName});
    if (response['status'] == "suc") {
      setState(() {
        myFav.add({
          "productID": response['data'][0]['productID'],
          "foodName": response['data'][0]['productName'],
          "storeName": response['data'][0]['storeName'],
          "rate": response['data'][0]['rate'],
          "image": "php/images/${response['data'][0]['image']}",
          "userID": response['data'][0]['userID'],
          "price": response['data'][0]['price'],
          "totalBuy": response['data'][0]['totalBuy'],
          "fav": true
        });
      });
    }
  }

  forLoopForProducts() {
    for (int i = 0; i < favList.length; i++) {
      bringProductFromCate(favList[i]['cateID'], favList[i]['orderID']);
    }
  }

  deleteFavoriteFromFavTable(String id) async {
    var response = await api.postReq(deleteFromUserFavoriteTable, {"id": id});
  }

  addFavoriteToFavTable(String userID, String orderID, String cateID) async {
    var resp = await api.postReq(addToUserFavoriteTable,
        {"userID": userID, "orderID": orderID, "cateID": cateID});
  }

/********************** End Api Functions ********************************* */
  @override
  void initState() {
    bringAllFavorites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("images/favorite.jpg"))),
          ),
          Container(
            margin: EdgeInsets.only(top: 5, left: 5),
            child: IconButton(
                onPressed: () => Scaffold.of(context).openDrawer(),
                icon: Icon(
                  Icons.menu,
                  color: Colors.white,
                  size: 35,
                )),
          ),
          Container(
            margin: EdgeInsets.only(top: 150),
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: myFav.length,
                itemBuilder: (context, i) {
                  return MaterialButton(
                    onPressed: () {},
                    child: Container(
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.only(bottom: 10, top: 10),
                      width: double.infinity,
                      height: 110,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        // ignore: prefer_const_literals_to_create_immutables
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromARGB(255, 197, 197, 197),
                              blurRadius: 4)
                        ],
                        border: Border.all(
                            color: Color.fromARGB(255, 197, 197, 197),
                            width: 1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color.fromARGB(255, 197, 197, 197),
                                    width: 1),
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage("${myFav[i]['image']}"))),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${myFav[i]["foodName"]}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Container(
                                  //margin: EdgeInsets.only(top: 5, bottom: 5),
                                  child: Text("${myFav[i]["storeName"]}",
                                      style: TextStyle(color: Colors.grey)),
                                ),
                                Row(
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(right: 3),
                                        child: Text(
                                            "${myFav[i]["rate"].toString().substring(0, 3)}")),
                                    Icon(
                                      Icons.star,
                                      color: Colors.amberAccent,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: IconButton(
                              color: myFav[i]["fav"] == false
                                  ? Colors.black
                                  : Colors.red,
                              iconSize: 25,
                              icon: myFav[i]["fav"] == false
                                  ? Icon(Icons.favorite_border_outlined)
                                  : Icon(Icons.favorite),
                              onPressed: () {
                                setState(() {
                                  if (myFav[i]["fav"] == false) {
                                    myFav[i]["fav"] = true;
                                    addFavoriteToFavTable(
                                        favList[i]['userID'],
                                        favList[i]['orderID'],
                                        favList[i]['cateID']);
                                  } else {
                                    myFav[i]["fav"] = false;
                                    deleteFavoriteFromFavTable(
                                        favList[i]['id']);
                                  }
                                });
                              },
                            ),
                          ),
                        )
                      ]),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
