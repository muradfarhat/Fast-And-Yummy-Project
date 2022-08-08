// ignore_for_file: prefer_const_constructors, use_build_context_synchronously
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'dart:io';
import 'package:fast_and_yummy/myStore/setStoreLocation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'api/api.dart';
import 'api/linkapi.dart';
import 'main.dart';
import 'myStore/myStorePage.dart';

class ActiveStore extends StatefulWidget {
  const ActiveStore({Key? key}) : super(key: key);

  @override
  State<ActiveStore> createState() => _ActiveStoreState();
}

class _ActiveStoreState extends State<ActiveStore> {
  Color color = Color.fromARGB(255, 37, 179, 136);
  bool switchB = true;
  bool orderpage = true;
  dynamic lis;
  dynamic lis2;
  bool loading = false;
  Api api = Api();
  File? file;
  String text = "Active My Store";
  String text1 = "Select location";
  IconData icon = Icons.store;
  IconData icon1 = Icons.location_on;
  changeHaveStore() async {
    var resp = await api.postReqImage(
        haveStore, {"id": sharedPref.getString("id")}, file!);

    if (resp['status'] == "suc") {
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
      });
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
          child: loading
              ? SizedBox(
                  height: size.height,
                  width: size.width,
                  child: Center(
                    child: CircularProgressIndicator(color: color),
                  ),
                )
              : SizedBox(
                  width: size.width,
                  height: size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () async {
                          if (lis?['have_store'] == "no") {
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
                                            onPressed: () async {
                                              XFile? xfile = await ImagePicker()
                                                  .pickImage(
                                                      source:
                                                          ImageSource.gallery);
                                              file = File(xfile!.path);
                                              if (file != null) {
                                                setState(() {
                                                  changeHaveStore();
                                                  lis?['have_store'] = "yes";
                                                  text = text1;
                                                  icon = icon1;
                                                });

                                                showSuccessSnackBarMSG(
                                                    "Store Activated",
                                                    color,
                                                    Icons.check_circle_rounded);
                                                Navigator.pop(context);
                                              }
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                          } else {
                            /////////////////////////go to select location///////////////////////////
                            //StoreLocation
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: ((context) {
                              return StoreLocation();
                            })));
                            showSuccessSnackBarMSG("Select location",
                                Colors.orange, Icons.location_on);
                          }
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
                                lis?['have_store'] == "no" ? icon : icon1,
                                color: Colors.white,
                                size: 32,
                              ),
                              Text(
                                lis?['have_store'] == "no" ? text : text1,
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
                )),
    );
  }

  showSuccessSnackBarMSG(String text, Color color, IconData icon) {
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
          Text(
            text,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )
        ],
      ),
      duration: Duration(seconds: 1),
      margin: EdgeInsets.all(20),
    ));
  }
}
