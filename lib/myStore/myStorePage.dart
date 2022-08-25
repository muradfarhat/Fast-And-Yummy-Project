// ignore_for_file: prefer_const_constructors, use_build_context_synchronously
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'dart:io';

import 'package:fast_and_yummy/myStore/info.dart';
import 'package:fast_and_yummy/myStore/order.dart';
import 'package:fast_and_yummy/myStore/productPromotion.dart';
import 'package:fast_and_yummy/myStore/readyOrder.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../api/api.dart';
import '../api/linkapi.dart';
import '../main.dart';
import 'addpage.dart';
import 'editStore.dart';

class MyStorePage extends StatefulWidget {
  const MyStorePage({Key? key}) : super(key: key);

  @override
  State<MyStorePage> createState() => _MyStorePageState();
}

class _MyStorePageState extends State<MyStorePage> {
  Color color = Color.fromARGB(255, 37, 179, 136);
  String switchB = "info";
  bool orderpage = true;
  dynamic lis;
  dynamic lis2;
  bool loading = false;
  Api api = Api();
  File? file;
  bool pay = false;
  getStoreData() async {
    setState(() {
      loading = true;
    });
    var resp = await api.postReq(storeInfo, {"id": sharedPref.getString("id")});
    setState(() {
      loading = false;
    });
    if (resp['status'] == "suc") {
      setState(() {
        lis2 = resp['data'];
      });
    } else {}
  }

  getData() async {
    setState(() {
      loading = true;
    });
    var resp =
        await api.postReq(getInfoLink, {"id": sharedPref.getString("id")});
    setState(() {
      loading = false;
    });
    if (resp['status'] == "suc") {
      setState(() {
        lis = resp['data'];
        if (lis?['have_store'] == "yes") {
          getStoreData();
        }
      });
    } else {}
  }

  changeHaveStore() async {
    var resp = await api.postReqImage(
        haveStore, {"id": sharedPref.getString("id")}, file!);

    if (resp['status'] == "suc") {
      getData();
    } else {}
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: color,
        toolbarHeight: 0,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: loading
            ? SizedBox(
                height: size.height,
                width: size.width,
                child: Center(
                  child: CircularProgressIndicator(color: color),
                ),
              )
            : Column(
                children: [
                  Stack(
                    children: [
                      Image.network(
                        "$imageRoot/${lis2?['storeImage']}",
                        width: size.width,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        height: 200,
                        width: size.width,
                        decoration:
                            BoxDecoration(color: Colors.black.withOpacity(0.6)),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 200,
                        width: size.width,
                        child: Text(
                          "${lis2?["storeName"]}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 35,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Positioned(
                        left: 10,
                        top: 10,
                        child: InkWell(
                          onTap: () {
                            Navigator.popUntil(
                                context, (route) => route.isFirst);
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 10,
                        top: 10,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(
                              builder: (context) => EditStore(),
                            ))
                                .then((value) async {
                              await getStoreData();
                              getData();
                            });
                          },
                          child: Icon(
                            Icons.edit_note_sharp,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              switchB = "info";
                              orderpage = true;
                            });
                          },
                          child: Text(
                            "INFO",
                            style: TextStyle(
                              color: switchB == "info"
                                  ? Color.fromARGB(255, 37, 179, 136)
                                  : Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              orderpage = false;
                              switchB = "order";
                            });
                          },
                          child: Text(
                            "ORDERS",
                            style: TextStyle(
                              color: switchB == "order"
                                  ? Color.fromARGB(255, 37, 179, 136)
                                  : Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              orderpage = false;
                              switchB = "Rorder";
                            });
                          },
                          child: Text(
                            "Deliverd Orders",
                            style: TextStyle(
                              color: switchB == "Rorder"
                                  ? Color.fromARGB(255, 37, 179, 136)
                                  : Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  if (switchB == "info")
                    InfoMyStore(lis2)
                  else if (switchB == "order")
                    OrderMyStore()
                  else if (switchB == "Rorder")
                    ReadyOrder(),
                ],
              ),
      ),
      floatingActionButton: Visibility(
        visible: orderpage && lis?['have_store'] == "yes",
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddPage(lis2?['storeName'])),
            ).then((value) => () {
                  getStoreData();
                });
          },
          backgroundColor: color,
          child: Icon(
            Icons.add,
            size: 35,
          ),
        ),
      ),
    );
  }

  ListTile listTileDesign(String title, BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Visibility(
            visible: true,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                boxShadow: [BoxShadow(color: Colors.red)],
              ),
              height: 25,
              width: 25,
              child: Center(
                  child: Text(
                "1",
                style: TextStyle(color: Colors.white, fontSize: 16),
              )),
            ),
          )
        ],
      ),
      trailing: TextButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(title),
                  actions: [Text("Exit")],
                );
              });
        },
        child: Text(
          "View All",
          style:
              TextStyle(color: Color.fromARGB(255, 37, 179, 136), fontSize: 12),
        ),
      ),
    );
  }
}
