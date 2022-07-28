// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:fast_and_yummy/myStore/info.dart';
import 'package:fast_and_yummy/myStore/order.dart';
import 'package:flutter/material.dart';

import 'api/api.dart';
import 'api/linkapi.dart';
import 'main.dart';
import 'myStore/addpage.dart';

class MyStore extends StatefulWidget {
  const MyStore({Key? key}) : super(key: key);

  @override
  State<MyStore> createState() => _MyStoreState();
}

class _MyStoreState extends State<MyStore> {
  Color color = Color.fromARGB(255, 37, 179, 136);
  bool switchB = true;
  bool orderpage = true;
  dynamic lis;
  bool loading = false;
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

  changeHaveStore() async {
    var resp = await api.postReq(haveStore, {"id": sharedPref.getString("id")});

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
      appBar: AppBar(
        backgroundColor: color,
        toolbarHeight: 0,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: lis?['have_store'] == "no"
            ? SizedBox(
                width: size.width,
                height: size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Are you sure ?"),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      MaterialButton(
                                        color: color,
                                        onPressed: () {
                                          setState(() {
                                            changeHaveStore();
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Icon(Icons.check,
                                                color: Colors.white),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "Yes",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                      MaterialButton(
                                        color: Colors.red,
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Icon(Icons.close,
                                                color: Colors.white),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "No",
                                              style: TextStyle(
                                                  color: Colors.white),
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
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 75),
                        alignment: Alignment.center,
                        height: 60,
                        width: size.width,
                        decoration: BoxDecoration(
                            color: color,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Icons.store,
                              color: Colors.white,
                              size: 32,
                            ),
                            Text(
                              "Active Your Store",
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 200,
                        width: size.width,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("images/kfc.png"),
                              fit: BoxFit.cover),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromARGB(255, 133, 133, 133),
                                blurRadius: 8,
                                offset: Offset(0, 3))
                          ],
                        ),
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
                          "KFC",
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
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                      )
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
                              switchB = !switchB;
                              orderpage = !orderpage;
                            });
                          },
                          child: Text(
                            "INFO",
                            style: TextStyle(
                              color: switchB
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
                              orderpage = !orderpage;
                              switchB = !switchB;
                            });
                          },
                          child: Text(
                            "ORDER",
                            style: TextStyle(
                              color: !switchB
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
                  switchB ? InfoMyStore() : OrderMyStore(),
                ],
              ),
      ),
      floatingActionButton: Visibility(
        visible: orderpage,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddPage()),
            );
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
