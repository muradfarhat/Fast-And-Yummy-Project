// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class user_page extends StatefulWidget {
  user_page({Key? key}) : super(key: key);

  @override
  State<user_page> createState() => _user_pageState();
}

class _user_pageState extends State<user_page> {
  TextEditingController searchValue =
      new TextEditingController(); // variable to store text field value in it
  int selectedNavBarItem = 2;

  // ignore: slash_for_doc_comments
  /*************************************** Widget List For Pages ************************** */
  List<Widget> content = [
    Text("Profile"),
    Text("Favorite"),
    pageContent(),
    Text("My Orders"),
    Text("Cart"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        /********************************* Start Appbar ******************************* */
        appBar: AppBar(
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
              focusedBorder: OutlineInputBorder(
                  gapPadding: 10,
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.white, width: 1)),
              enabledBorder: OutlineInputBorder(
                  gapPadding: 10,
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.white, width: 1)),
              disabledBorder: OutlineInputBorder(
                  gapPadding: 10,
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.white, width: 1)),
            ),
          ),
          backgroundColor: Color.fromARGB(255, 93, 194, 158),
        ),
        /********************************* End Appbar ******************************* */
        /******************************* Start Drawer ******************************* */
        drawer: Drawer(
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 93, 194, 158),
                  ),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Text(
                      "UN",
                      style:
                          TextStyle(color: Color.fromARGB(255, 93, 194, 158)),
                    ),
                  ),
                  accountName: Text("User Name"),
                  accountEmail: Text("User Email")),
              ListTile(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Stores"),
                        );
                      });
                },
                title: Text("Stores"),
                leading: Icon(
                  Icons.store,
                  color: Color.fromARGB(255, 93, 194, 158),
                ),
              ),
              ListTile(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("About"),
                        );
                      });
                },
                title: Text("About"),
                leading: Icon(
                  Icons.info,
                  color: Color.fromARGB(255, 93, 194, 158),
                ),
              ),
              ListTile(
                title: Text("Support"),
                leading: Icon(
                  Icons.support,
                  color: Color.fromARGB(255, 93, 194, 158),
                ),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Support"),
                        );
                      });
                },
              ),
              ListTile(
                title: Text("Log out"),
                leading: Icon(
                  Icons.exit_to_app,
                  color: Color.fromARGB(255, 93, 194, 158),
                ),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Log out"),
                        );
                      });
                },
              ),
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
            },
            currentIndex: selectedNavBarItem,
            type: BottomNavigationBarType.fixed,
            selectedIconTheme: IconThemeData(
                color: Color.fromARGB(255, 93, 194, 158), size: 45),
            selectedItemColor: Color.fromARGB(255, 93, 194, 158),
            unselectedItemColor: Color.fromARGB(255, 157, 157, 157),
            iconSize: 30,
            // ignore: prefer_const_literals_to_create_immutables
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person_outline,
                    //color: Color.fromARGB(255, 93, 194, 158),
                  ),
                  label: "Profile"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite_outline,
                    //color: Color.fromARGB(255, 93, 194, 158),
                  ),
                  label: "Favorite"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home_outlined,
                    //color: Color.fromARGB(255, 93, 194, 158),
                  ),
                  label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.map_outlined,
                    //color: Color.fromARGB(255, 93, 194, 158),
                  ),
                  label: "My Orders"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.shopping_cart_outlined,
                    //color: Color.fromARGB(255, 93, 194, 158),
                  ),
                  label: "Cart"),
            ]),
        /********************************* End Bottom Navegation bar **************************** */
        body: content.elementAt(selectedNavBarItem));
  }
}

// ignore: slash_for_doc_comments
/********************************** Home Page Content ******************************** */

class pageContent extends StatefulWidget {
  pageContent({Key? key}) : super(key: key);

  @override
  State<pageContent> createState() => _pageContentState();
}

class _pageContentState extends State<pageContent> {
  List<Map> categories = [
    {"image": "images/food.jpg", "name": "Cate. Name"},
    {"image": "images/food.jpg", "name": "Cate. Name"},
    {"image": "images/food.jpg", "name": "Cate. Name"},
    {"image": "images/food.jpg", "name": "Cate. Name"},
    {"image": "images/food.jpg", "name": "Cate. Name"}
  ];
  List<Map> offers = [
    {
      "image": "images/burger.jpg",
      "name": "Food Name",
      "store": "Store Name",
      "newPrice": "\$ 8.99",
      "oldPrice": "\$ 10.00"
    },
    {
      "image": "images/burger.jpg",
      "name": "Food Name",
      "store": "Store Name",
      "newPrice": "\$ 8.99",
      "oldPrice": "\$ 10.00"
    },
    {
      "image": "images/burger.jpg",
      "name": "Food Name",
      "store": "Store Name",
      "newPrice": "\$ 8.99",
      "oldPrice": "\$ 10.00"
    },
    {
      "image": "images/burger.jpg",
      "name": "Food Name",
      "store": "Store Name",
      "newPrice": "\$ 8.99",
      "oldPrice": "\$ 10.00"
    }
  ];
  List<Map> sugg = [
    {
      "image": "images/pizza.jpg",
      "name": "Food Name",
      "store": "Store Name",
      "price": "\$ 8.99",
      "star1": 1,
      "star2": 1,
      "star3": 1,
      "star4": 1,
      "star5": 1
    },
    {
      "image": "images/pizza.jpg",
      "name": "Food Name",
      "store": "Store Name",
      "price": "\$ 8.99",
      "star1": 1,
      "star2": 0,
      "star3": 0,
      "star4": 0,
      "star5": 0
    },
    {
      "image": "images/pizza.jpg",
      "name": "Food Name",
      "store": "Store Name",
      "price": "\$ 8.99",
      "star1": 1,
      "star2": 1,
      "star3": 1,
      "star4": 0,
      "star5": 0
    }
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      // color: Colors
      //     .white, // Color.fromARGB(255, 243, 242, 242), // All page background color
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
            child: ListView.builder(
                itemCount: categories.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, i) {
                  return MaterialButton(
                    padding: EdgeInsets.all(8),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Test text"),
                              actions: [Text("data")],
                            );
                          });
                    },
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              // ignore: prefer_const_literals_to_create_immutables
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromARGB(255, 197, 197, 197),
                                    blurRadius: 4)
                              ],
                              border: Border.all(
                                  color: Color.fromARGB(255, 93, 194, 158),
                                  width: 1),
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image:
                                      AssetImage("${categories[i]['image']}"))),
                          margin: EdgeInsets.only(bottom: 8),
                          width: 80,
                          height: 80,
                        ),
                        Text(
                          "${categories[i]['name']}",
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
              "Offers",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            trailing: TextButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Test text"),
                          actions: [Text("data")],
                        );
                      });
                },
                child: Text(
                  "View All",
                  style: TextStyle(
                      color: Color.fromARGB(255, 93, 194, 158), fontSize: 12),
                )),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            //color: Colors.red,
            height: 140,
            width: double.infinity,
            child: ListView.builder(
                itemCount: 4,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, i) {
                  return MaterialButton(
                    padding: EdgeInsets.all(8),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Test text"),
                              actions: [Text("data")],
                            );
                          });
                    },
                    child: Container(
                        padding: EdgeInsets.all(5),
                        width: 250,
                        height: 120,
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
                              width: 120,
                              height: 110,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image:
                                          AssetImage("${offers[i]['image']}"))),
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
                                      "${offers[i]['name']}",
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
                                      "${offers[i]['store']}",
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
                                        "${offers[i]['newPrice']}  ",
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 93, 194, 158),
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        "${offers[i]['oldPrice']}",
                                        style: TextStyle(
                                          decoration:
                                              TextDecoration.lineThrough,
                                          color:
                                              Color.fromARGB(255, 93, 194, 158),
                                          fontSize: 10,
                                        ),
                                      )
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
              "Suggestions you may like",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            trailing: TextButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Test text"),
                          actions: [Text("data")],
                        );
                      });
                },
                child: Text(
                  "View All",
                  style: TextStyle(
                      color: Color.fromARGB(255, 93, 194, 158), fontSize: 12),
                )),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            //color: Colors.red,
            height: 210,
            width: double.infinity,
            child: ListView.builder(
                itemCount: 3,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, i) {
                  return MaterialButton(
                    padding: EdgeInsets.all(8),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Test text"),
                              actions: [Text("data")],
                            );
                          });
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
                                      image:
                                          AssetImage("${sugg[i]['image']}"))),
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
                                      "${sugg[i]['name']}",
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
                                      "${sugg[i]['store']}",
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
                                      "${sugg[i]['price']}  ",
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 93, 194, 158),
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.white,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    child: Row(
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                        Icon(
                                          this.sugg[i]['star1'] == 1
                                              ? Icons.star
                                              : Icons.star_border_outlined,
                                          //Icons.star,
                                          size: 20,
                                          color: Colors.amberAccent,
                                        ),
                                        Icon(
                                          this.sugg[i]['star2'] == 1
                                              ? Icons.star
                                              : Icons.star_border_outlined,
                                          //Icons.star,
                                          size: 20,
                                          color: Colors.amberAccent,
                                        ),
                                        Icon(
                                          this.sugg[i]['star3'] == 1
                                              ? Icons.star
                                              : Icons.star_border_outlined,
                                          //Icons.star,
                                          size: 20,
                                          color: Colors.amberAccent,
                                        ),
                                        Icon(
                                          this.sugg[i]['star4'] == 1
                                              ? Icons.star
                                              : Icons.star_border_outlined,
                                          //Icons.star,
                                          size: 20,
                                          color: Colors.amberAccent,
                                        ),
                                        Icon(
                                          this.sugg[i]['star5'] == 1
                                              ? Icons.star
                                              : Icons.star_border_outlined,
                                          //Icons.star,
                                          size: 20,
                                          color: Colors.amberAccent,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        )),
                  );
                }),
          ),
          /************************************* End Suggestions Section **************************** */
        ],
      ),
    );
  }
}
