// ignore_for_file: prefer_const_constructors, unnecessary_new, slash_for_doc_comments, duplicate_ignore, use_build_context_synchronously

import 'package:fast_and_yummy/HomePage/homepage.dart';
import 'package:fast_and_yummy/main.dart';
import 'package:fast_and_yummy/activeStore.dart';
import 'package:fast_and_yummy/stores.dart';
import 'package:fast_and_yummy/userpage/AboutPgae.dart';

import 'package:fast_and_yummy/userpage/pagecontent.dart';
import 'package:fast_and_yummy/userpage/profile.dart';
import 'package:fast_and_yummy/userpage/favorite.dart';
import 'package:fast_and_yummy/userpage/cart.dart';
import 'package:fast_and_yummy/userpage/myOrders.dart';
import 'package:fast_and_yummy/userpage/search.dart';
import 'package:fast_and_yummy/userpage/supportPage.dart';
import 'package:flutter/material.dart';

import '../api/api.dart';
import '../api/linkapi.dart';
import '../myStore/myStorePage.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  dynamic lis;
  dynamic lis2;
  dynamic lis3;
  bool loading = false;
  Api api = Api();
  List<dynamic> cate = [];

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

  @override
  void initState() {
    getData();
    super.initState();
  }

  bool boolx = false;
  bool showAppBar = true;
/********************************* Start Appbar ******************************* */
  appBarDesign() {
    if (showAppBar) {
      return AppBar(
        toolbarHeight: 65,
        title: InkWell(
          onTap: () {
            setState(() {
              boolx = true;
              Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Search()))
                  .then((value) {
                setState(() {
                  boolx = false;
                });
              });
            });
          },
          child: TextFormField(
            enabled: boolx,

            onEditingComplete: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(searchValue.text),
                    );
                  });
            },

            controller:
                searchValue, // take text value and store it in searchValue variable
            textInputAction: TextInputAction.go,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 1),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.grey,
              ),
              filled: true,
              fillColor: Colors.white,
              hintText: "Search",
              focusedBorder: outLDesign(),
              enabledBorder: outLDesign(),
              disabledBorder: outLDesign(),
            ),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 37, 179, 136),
      );
    } else {
      return AppBar(
        toolbarHeight: 0,
        backgroundColor: Color.fromARGB(255, 37, 179, 136),
      );
    }
  }
  /********************************* End Appbar ******************************* */

  TextEditingController searchValue =
      new TextEditingController(); // variable to store text field value in it
  int selectedNavBarItem = 2;

  // ignore: slash_for_doc_comments
  /*************************************** Widget List For Pages ************************** */
  List<Widget> content = [
    Profile("customer"),
    favorite(),
    PageContent(),
    MyOrders(),
    Cart(),
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        /********************************* Start Appbar ******************************* */
        appBar: appBarDesign(),
        /********************************* End Appbar ******************************* */
        /******************************* Start Drawer ******************************* */
        drawer: Drawer(
          width: 280,
          child: loading
              ? SizedBox(
                  height: size.height,
                  width: size.width,
                  child: Center(
                    child: CircularProgressIndicator(
                        color: Color.fromARGB(255, 37, 179, 136)),
                  ),
                )
              : Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    UserAccountsDrawerHeader(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 37, 179, 136),
                        ),
                        currentAccountPicture: CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage: lis?['image'] == ""
                              ? NetworkImage(
                                  "https://i.stack.imgur.com/l60Hf.png")
                              : NetworkImage("$imageRoot/${lis?['image']}"),
                        ),
                        accountName:
                            Text(lis?['first_name'] + " " + lis?['last_name']),
                        accountEmail: Text(lis?['email'])),
                    InkWell(
                        onTap: () async {
                          await getData();
                          Future.delayed(Duration(seconds: 2));
                          if (lis?['have_store'] == "yes") {
                            getStoreData();
                            if (lis2?['latitude'] == "") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ActiveStore()),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyStorePage()),
                              );
                            }
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ActiveStore()),
                            );
                          }
                        },
                        child: listTileDesgin(
                          "My Store",
                          Icons.store,
                        )),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Stores()));
                        },
                        child: listTileDesgin(
                          "Stores",
                          Icons.store,
                        )),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => aboutPage()));
                        },
                        child: listTileDesgin(
                          "About",
                          Icons.info,
                        )),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => support()));
                        },
                        child: listTileDesgin(
                          "Support",
                          Icons.support,
                        )),
                    InkWell(
                        onTap: () {
                          sharedPref.clear();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        },
                        child: listTileDesgin(
                          "Logout",
                          Icons.exit_to_app,
                        )),
                  ],
                ),
        ),
        /******************************* End Drawer ******************************* */
        /********************************* Start Bottom Navegation bar **************************** */
        // ignore: prefer_const_literals_to_create_immutables
        bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              setState(() {
                selectedNavBarItem = index;
              });
              if (index != 2) {
                setState(() {
                  showAppBar = false;
                });
              } else {
                setState(() {
                  showAppBar = true;
                });
              }
            },
            currentIndex: selectedNavBarItem,
            type: BottomNavigationBarType.fixed,
            selectedIconTheme: IconThemeData(
                color: Color.fromARGB(255, 37, 179, 136), size: 45),
            selectedItemColor: Color.fromARGB(255, 37, 179, 136),
            unselectedItemColor: Color.fromARGB(255, 157, 157, 157),
            iconSize: 30,
            // ignore: prefer_const_literals_to_create_immutables
            items: [
              bottomNDesign("Profile", Icons.person_outline),
              bottomNDesign("Favorite", Icons.favorite_outline),
              bottomNDesign("Home", Icons.home_outlined),
              bottomNDesign("My Orders", Icons.map_outlined),
              bottomNDesign("Cart", Icons.shopping_cart_outlined),
            ]),
        /********************************* End Bottom Navegation bar **************************** */
        body: content.elementAt(selectedNavBarItem));
  }

  ListTile listTileDesgin(String name, IconData ic) {
    return ListTile(
      title: Text(name),
      leading: Icon(
        ic,
        color: Color.fromARGB(255, 37, 179, 136),
      ),
    );
  }

  BottomNavigationBarItem bottomNDesign(String name, IconData ic) {
    return BottomNavigationBarItem(
        icon: Icon(
          ic,
        ),
        label: name);
  }

  OutlineInputBorder outLDesign() {
    return OutlineInputBorder(
        gapPadding: 10,
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Colors.white, width: 1));
  }
}
