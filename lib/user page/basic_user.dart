// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class user_page extends StatefulWidget {
  user_page({Key? key}) : super(key: key);

  @override
  State<user_page> createState() => _user_pageState();
}

class _user_pageState extends State<user_page> {
  int selectedNavBarItem = 2;
  List<Widget> content = [
    Text("hello1"),
    Text("hello2"),
    pageContent(),
    Text("hello3"),
    Text("hello4"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 93, 194, 158),
        ),
        drawer: Drawer(),
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
/********************************** Page Content ******************************** */

class pageContent extends StatefulWidget {
  pageContent({Key? key}) : super(key: key);

  @override
  State<pageContent> createState() => _pageContentState();
}

class _pageContentState extends State<pageContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 243, 242, 242), // All page background color
      child: Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          /*********************************** Categories Section ******************************* */
          ListTile(
            title: Text(
              "Categories",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            //color: Colors.red,
            height: 130,
            width: double.infinity,
            child: ListView.builder(
                itemCount: 5,
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
                                  image: AssetImage("images/food.jpg"))),
                          margin: EdgeInsets.only(bottom: 8),
                          width: 80,
                          height: 80,
                        ),
                        Text(
                          "Cate. Name",
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                  );
                }),
          ),
          /************************************* Offers Section **************************** */
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
                                      image: AssetImage("images/burger.jpg"))),
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
                                      "Food Name",
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
                                      "Store Name",
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
                                        "\$ 8.99  ",
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 93, 194, 158),
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        "\$ 10.00",
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
          /************************************* Suggestions Section **************************** */
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
                                      image: AssetImage("images/pizza.jpg"))),
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
                                      "Food Name",
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
                                      "Store Name",
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
                                      "\$ 8.99  ",
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
                                          Icons.star,
                                          size: 20,
                                        ),
                                        Icon(
                                          Icons.star,
                                          size: 20,
                                        ),
                                        Icon(
                                          Icons.star,
                                          size: 20,
                                        ),
                                        Icon(
                                          Icons.star,
                                          size: 20,
                                        ),
                                        Icon(
                                          Icons.star,
                                          size: 20,
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
        ],
      ),
    );
  }
}
