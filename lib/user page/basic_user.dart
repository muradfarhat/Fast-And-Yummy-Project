// ignore_for_file: prefer_const_constructors, unnecessary_new, slash_for_doc_comments, duplicate_ignore

import 'package:fast_and_yummy/HomePage/homepage.dart';
import 'package:fast_and_yummy/detialscreen.dart';
import 'package:fast_and_yummy/myStore.dart';
import 'package:fast_and_yummy/splash.dart';
import 'package:fast_and_yummy/stores.dart';
import 'package:fast_and_yummy/user%20page/pagecontent.dart';
import 'package:fast_and_yummy/user%20page/profile.dart';
import 'package:fast_and_yummy/user%20page/favorite.dart';
import 'package:fast_and_yummy/user%20page/cart.dart';
import 'package:fast_and_yummy/user%20page/myOrders.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  bool showAppBar = true;
/********************************* Start Appbar ******************************* */
  appBarDesign() {
    if (showAppBar) {
      return AppBar(
        toolbarHeight: 65,
        title: TextFormField(
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
    profile(),
    favorite(),
    PageContent(),
    MyOrders(),
    Cart(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        /********************************* Start Appbar ******************************* */
        appBar: appBarDesign(),
        /********************************* End Appbar ******************************* */
        /******************************* Start Drawer ******************************* */
        drawer: Drawer(
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 37, 179, 136),
                  ),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Text(
                      "UN",
                      style:
                          TextStyle(color: Color.fromARGB(255, 37, 179, 136)),
                    ),
                  ),
                  accountName: Text("User Name"),
                  accountEmail: Text("User Email")),
              InkWell(
                  child: listTileDesgin("My Store", Icons.store, MyStore())),
              InkWell(child: listTileDesgin("Stores", Icons.store, Stores())),
              InkWell(child: listTileDesgin("About", Icons.info, HomePage())),
              InkWell(
                  child:
                      listTileDesgin("Support", Icons.support, PageContent())),
              InkWell(
                  child: listTileDesgin("Logout", Icons.exit_to_app, Splash())),
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

  ListTile listTileDesgin(String name, IconData ic, Widget ob) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ob),
        );
      },
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
