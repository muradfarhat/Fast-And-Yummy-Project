// ignore_for_file: prefer_const_constructors
//ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:fast_and_yummy/api/linkapi.dart';
import 'package:fast_and_yummy/containter_design_for_store_page.dart';
import 'package:flutter/material.dart';

import 'api/api.dart';

class StoreProduct extends StatefulWidget {
  dynamic storeData;
  StoreProduct(this.storeData, {Key? key}) : super(key: key);

  @override
  State<StoreProduct> createState() => _StoreProductState();
}

class _StoreProductState extends State<StoreProduct> {
  @override
  void initState() {
    getCate();
    super.initState();
  }

  List<Map> categories = [
    {"image": "images/cat/CH.jpeg", "name": "Fried chicken"},
    {"image": "images/cat/bot.jpg", "name": "French fries"},
    {"image": "images/cat/des.jpeg", "name": "Desserts"},
    {"image": "images/cat/drink.jpg", "name": "Soft drinks"},
    {"image": "images/cat/drink.jpg", "name": "Soft drinks"},
  ];
  dynamic lis2;
  String? cateNAME;
  dynamic productList;
  Api api = Api();
  dynamic choice = [];
  bool loading = false;
  bool find = false;
  Color color = Color.fromARGB(255, 37, 179, 136);
  dynamic cateID;
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
        lis2 = resp['data'];
      });
    } else {}
  }

  bringProduct(String tabelName) async {
    setState(() {
      loading = true;
    });
    var resp = await api.postReq(bringProdectLink, {
      "tableName": tabelName,
      "userID": widget.storeData['storeID'],
    });
    setState(() {
      loading = false;
    });
    if (resp['status'] == "suc") {
      setState(() {
        find = false;
        productList = resp['data'];
        choice = productList;
      });
    } else {
      setState(() {
        find = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color,
        title: Container(
            margin: EdgeInsets.only(right: 50),
            child: Center(child: Text("${widget.storeData['storeName']}"))),
      ),
      body: loading
          ? SizedBox(
              height: size.height,
              width: size.width,
              child: Center(
                child: CircularProgressIndicator(color: color),
              ),
            )
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Container(
                    height: 200,
                    width: size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              "$imageRoot/${widget.storeData['storeImage']}"),
                          fit: BoxFit.cover),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromARGB(255, 133, 133, 133),
                            blurRadius: 8,
                            offset: Offset(0, 3))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  listTileDesign("Categories", context),
                  SizedBox(
                    height: 130,
                    width: double.infinity,
                    child: ListView.builder(
                        itemCount: lis2.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, i) {
                          return MaterialButton(
                            padding: EdgeInsets.all(8),
                            onPressed: () {
                              setState(() {
                                cateNAME = lis2?[i]["cateName"];
                                cateID = lis2?[i]["cateID"];
                              });
                              bringProduct(lis2?[i]["cateName"]);
                            },
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color.fromARGB(
                                                255, 197, 197, 197),
                                            blurRadius: 4)
                                      ],
                                      border: Border.all(
                                          color: Color.fromARGB(
                                              255, 197, 197, 197),
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
                                  "${lis2?[i]['cateName']}",
                                  style: TextStyle(fontSize: 12),
                                )
                              ],
                            ),
                          );
                        }),
                  ),
                  find
                      ? Container(
                          margin: EdgeInsets.only(top: 15),
                          child: Text(
                            "There is no proudcts for this category in this store",
                            style: TextStyle(
                                color: Color.fromARGB(255, 121, 121, 121),
                                fontSize: 13),
                          ),
                        )
                      : Column(
                          children: listGenerate(),
                        ),
                ],
              ),
            ),
    );
  }

  ListTile listTileDesign(String title, BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      trailing: Icon(
        Icons.category,
        color: color,
      ),
    );
  }

  listGenerate() {
    Size size = MediaQuery.of(context).size;
    return List.generate(choice.length, (index) {
      return Container(
        width: size.width,
        child: Column(
          children: [ContDFSP(productList[index], widget.storeData['storeID'],cateID)],
        ),
      );
    });
  }
}
