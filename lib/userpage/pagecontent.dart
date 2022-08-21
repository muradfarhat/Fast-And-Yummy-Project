// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'package:fast_and_yummy/userpage/cateAllProducts.dart';
import 'package:fast_and_yummy/userpage/viewAll.dart';
import 'package:fast_and_yummy/userpage/viewAllSugg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../api/api.dart';
import '../api/linkapi.dart';
import '../detialscreen.dart';
import '../main.dart';

class PageContent extends StatefulWidget {
  const PageContent({Key? key}) : super(key: key);

  @override
  State<PageContent> createState() => _PageContentState();
}

class _PageContentState extends State<PageContent> {
  bool loading = false;
  dynamic lis;
  Api api = Api();
  getData() async {
    setState(() {
      loading = true;
    });
    var resp =
        await api.postReq(getInfoLink, {"id": sharedPref.getString("id")});

    if (resp['status'] == "suc") {
      setState(() {
        lis = resp['data'];
        loading = false;
      });
    } else {}
  }

  dynamic recommended = [];
  recommend() async {
    setState(() {
      loading = true;
    });
    var resp = await api
        .postReq(recommendedULink, {"userID": sharedPref.getString("id")});
    setState(() {
      loading = false;
    });
    recommended = resp['Recommendation'];
  }

  dynamic populerList = [];
  populer() async {
    setState(() {
      loading = true;
    });
    var resp = await api.getReq(populerLink);
    setState(() {
      loading = false;
    });
    populerList = resp['populer'];
  }

  dynamic likedList = [];
  liked() async {
    setState(() {
      loading = true;
    });
    var resp =
        await api.postReq(likedLink, {"userID": sharedPref.getString("id")});
    setState(() {
      loading = false;
    });
    likedList = resp['Liked'];
  }

  dynamic last = [];
  lastPurchase() async {
    setState(() {
      loading = true;
    });
    var resp =
        await api.postReq(lastLink, {"userID": sharedPref.getString("id")});
    setState(() {
      loading = false;
    });
    last = resp;
  }

  @override
  void initState() {
    getData();
    getCate();
    recommend();
    populer();
    liked();
    lastPurchase();
    super.initState();
  }

  List<Map> categories = [
    {"image": "images/food.jpg", "name": "Cate. Name"},
    {"image": "images/food.jpg", "name": "Cate. Name"},
    {"image": "images/food.jpg", "name": "Cate. Name"},
    {"image": "images/food.jpg", "name": "Cate. Name"},
    {"image": "images/food.jpg", "name": "Cate. Name"}
  ];
  dynamic cate = [];
  getCate() async {
    setState(() {
      loading = true;
    });
    var resp = await api.postReq(bringAllCate, {});
    setState(() {
      loading = false;
    });
    if (resp['status'] == "suc") {
      setState(() {
        cate = resp['data'];
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          /*********************************** Start Categories Section ******************************* */
          ListTile(
            title: Text(
              "Categories",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            height: 130,
            width: double.infinity,
            child: loading
                ? Center(
                    child: CircularProgressIndicator(
                        color: Color.fromARGB(255, 37, 179, 136)),
                  )
                : ListView.builder(
                    itemCount: cate.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, i) {
                      return MaterialButton(
                        padding: EdgeInsets.all(8),
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return CateProducts(cate[i]['cateName']);
                          }));
                        },
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  // ignore: prefer_const_literals_to_create_immutables
                                  boxShadow: [
                                    BoxShadow(
                                        color:
                                            Color.fromARGB(255, 197, 197, 197),
                                        blurRadius: 4)
                                  ],
                                  border: Border.all(
                                      color: Color.fromARGB(255, 197, 197, 197),
                                      width: 1),
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                          "${categories[i]['image']}"))),
                              margin: EdgeInsets.only(bottom: 8),
                              width: 80,
                              height: 80,
                            ),
                            Text(
                              "${cate[i]['cateName']}",
                              style: TextStyle(fontSize: 12),
                            )
                          ],
                        ),
                      );
                    }),
          ),
          /*********************************** End Categories Section ******************************* */
          /************************************* Start Offers Section **************************** */
          ListTile(
            title: Text(
              "Populer",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            trailing: TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return ViewAll(populerList);
                  }));
                },
                child: Text(
                  "View All",
                  style: TextStyle(
                      color: Color.fromARGB(255, 37, 179, 136), fontSize: 12),
                )),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            //color: Colors.red,
            height: 140,
            width: double.infinity,
            child: ListView.builder(
                itemCount: populerList.length > 4 ? 4 : populerList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, i) {
                  return MaterialButton(
                    padding: EdgeInsets.all(8),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Detialscreen(
                              populerList[i],
                              populerList[i]['userID'],
                              populerList[i]['cateID']),
                        ),
                      );
                    },
                    child: Container(
                        padding: EdgeInsets.all(5),
                        width: 300,
                        height: 120,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromARGB(255, 197, 197, 197),
                                blurRadius: 4)
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 120,
                              height: 110,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          "$imageRoot/${populerList[i]['image']}"))),
                            ),
                            Container(
                              width: 170,
                              padding:
                                  EdgeInsets.only(top: 15, left: 10, right: 10),
                              child: Column(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    child: Text(
                                      "${populerList[i]['productName']}",
                                      overflow:
                                          TextOverflow.clip, // For text wraping
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 5),
                                    width: double.infinity,
                                    child: Text(
                                      "${populerList[i]['storeName']}",
                                      overflow:
                                          TextOverflow.clip, // For text wraping
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.white,
                                  ),
                                  Row(
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: [
                                      Text(
                                        "${populerList[i]['price']} \$",
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 37, 179, 136),
                                          fontSize: 18,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            double.parse(populerList[i]["rate"])
                                                .toStringAsFixed(2),
                                            style: TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: Colors.yellow[600],
                                            size: 18,
                                          )
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        )),
                  );
                }),
          ),
          /************************************* End Offers Section **************************** */
          /************************************* Start Suggestions Section **************************** */
          ListTile(
            title: Text(
              "Recommended for you",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            trailing: TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return ViewAll(recommended);
                  }));
                },
                child: Text(
                  "View All",
                  style: TextStyle(
                      color: Color.fromARGB(255, 37, 179, 136), fontSize: 12),
                )),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            //color: Colors.red,
            height: 210,
            width: double.infinity,
            child: ListView.builder(
                itemCount: recommended.length > 4 ? 4 : recommended.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, i) {
                  return MaterialButton(
                    padding: EdgeInsets.all(8),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Detialscreen(
                              recommended[i],
                              recommended[i]['userID'],
                              recommended[i]['cateID']),
                        ),
                      );
                    },
                    child: Container(
                        padding: EdgeInsets.all(5),
                        width: 300,
                        height: 190,
                        decoration: BoxDecoration(
                          // ignore: prefer_const_literals_to_create_immutables
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromARGB(255, 197, 197, 197),
                                blurRadius: 4)
                          ],
                          color: Colors.white,

                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 170,
                              height: 180,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          "$imageRoot/${recommended[i]['image']}"))),
                            ),
                            Container(
                              width: 120,
                              padding:
                                  EdgeInsets.only(top: 15, left: 10, right: 10),
                              child: Column(
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  Container(
                                    width: double.infinity,
                                    child: Text(
                                      "${recommended[i]['productName']}",
                                      overflow:
                                          TextOverflow.clip, // For text wraping
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 5),
                                    width: double.infinity,
                                    child: Text(
                                      "${recommended[i]['storeName']}",
                                      overflow:
                                          TextOverflow.clip, // For text wraping
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.white,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    child: Text(
                                      "${recommended[i]['price']} \$",
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 37, 179, 136),
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.white,
                                  ),
                                  Container(
                                      width: double.infinity,
                                      child: RatingBarIndicator(
                                        rating: double.parse(
                                            recommended[i]['rate']),
                                        itemSize: 20,
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                      ))
                                ],
                              ),
                            )
                          ],
                        )),
                  );
                }),
          ),
          /************************************* End Suggestions Section **************************** */
          Visibility(
            visible: likedList.isEmpty ? false : true,
            child: ListTile(
              title: Text(
                "Products we notice you liked it",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              subtitle: Text(
                "We suggest it, because maybe you want to buy it again",
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
          ),
          Visibility(
            visible: likedList.isEmpty ? false : true,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              //color: Colors.red,
              height: 140,
              width: double.infinity,
              child: ListView.builder(
                  itemCount: likedList.length > 4 ? 4 : likedList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, i) {
                    return MaterialButton(
                      padding: EdgeInsets.all(8),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Detialscreen(likedList[i],
                                likedList[i]['userID'], likedList[i]['cateID']),
                          ),
                        );
                      },
                      child: Container(
                          padding: EdgeInsets.all(5),
                          width: 300,
                          height: 120,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromARGB(255, 197, 197, 197),
                                  blurRadius: 4)
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 120,
                                height: 110,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            "$imageRoot/${likedList[i]['image']}"))),
                              ),
                              Container(
                                width: 170,
                                padding: EdgeInsets.only(
                                    top: 15, left: 10, right: 10),
                                child: Column(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      child: Text(
                                        "${likedList[i]['productName']}",
                                        overflow: TextOverflow
                                            .clip, // For text wraping
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 5),
                                      width: double.infinity,
                                      child: Text(
                                        "${likedList[i]['storeName']}",
                                        overflow: TextOverflow
                                            .clip, // For text wraping
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    Divider(
                                      color: Colors.white,
                                    ),
                                    Row(
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                        Text(
                                          "${likedList[i]['price']} \$",
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 37, 179, 136),
                                            fontSize: 18,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              double.parse(likedList[i]["rate"])
                                                  .toStringAsFixed(2),
                                              style: TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                            Icon(
                                              Icons.star,
                                              color: Colors.yellow[600],
                                              size: 18,
                                            )
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          )),
                    );
                  }),
            ),
          ),
          Visibility(
            visible: last.isEmpty ? false : true,
            child: ListTile(
              title: Text(
                "Last product you bought",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              subtitle: Text(
                "We suggest it, because maybe you want to buy it again",
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
          ),
          Visibility(
            visible: last.isEmpty ? false : true,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              //color: Colors.red,
              height: 140,
              width: double.infinity,
              child: ListView.builder(
                  itemCount: 1,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, i) {
                    return MaterialButton(
                      padding: EdgeInsets.all(8),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Detialscreen(
                                last, last['userID'], last['cateID']),
                          ),
                        );
                      },
                      child: Container(
                          padding: EdgeInsets.all(5),
                          width: 300,
                          height: 120,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromARGB(255, 197, 197, 197),
                                  blurRadius: 4)
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 120,
                                height: 110,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            "$imageRoot/${last['image']}"))),
                              ),
                              Container(
                                width: 170,
                                padding: EdgeInsets.only(
                                    top: 15, left: 10, right: 10),
                                child: Column(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      child: Text(
                                        "${last['productName']}",
                                        overflow: TextOverflow
                                            .clip, // For text wraping
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 5),
                                      width: double.infinity,
                                      child: Text(
                                        "${last['storeName']}",
                                        overflow: TextOverflow
                                            .clip, // For text wraping
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    Divider(
                                      color: Colors.white,
                                    ),
                                    Row(
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                        Text(
                                          "${last['price']} \$",
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 37, 179, 136),
                                            fontSize: 18,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              double.parse(last["rate"])
                                                  .toStringAsFixed(2),
                                              style: TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                            Icon(
                                              Icons.star,
                                              color: Colors.yellow[600],
                                              size: 18,
                                            )
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          )),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
