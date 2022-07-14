// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, list_remove_unrelated_type

import 'package:flutter/material.dart';

import '../ProductInsideStore.dart';

class InfoMyStore extends StatefulWidget {
  const InfoMyStore({Key? key}) : super(key: key);

  @override
  State<InfoMyStore> createState() => _InfoMyStoreState();
}

class _InfoMyStoreState extends State<InfoMyStore> {
  List<Map> categories = [
    {"image": "images/cat/CH.jpeg", "name": "Fried chicken"},
    {"image": "images/cat/bot.jpg", "name": "French fries"},
    {"image": "images/cat/des.jpeg", "name": "Desserts"},
    {"image": "images/cat/drink.jpg", "name": "Soft drinks"},
  ];

  List<Map> friedChicken = [
    {"image": "images/chk/fele.jpeg", "name": "Broasted fillet-fish"},
    {"image": "images/chk/cris.jpg", "name": "Crispy"},
    {"image": "images/chk/chf.jpg", "name": "Chicken Fingers"},
  ];
  List<Map> fries = [
    {"image": "images/fries/st.jpg", "name": "Standerd"},
    {"image": "images/fries/CP.jpg", "name": "Curly"},
    {"image": "images/fries/ck.jpg", "name": "Crinkle"},
    {"image": "images/fries/tat.jpg", "name": "Tater tots"},
  ];
  List<Map> desserts = [
    {"image": "images/sweets/cookie.jpeg", "name": "Cookies"},
    {"image": "images/sweets/creambrulee.jpeg", "name": "Cream Brulee"},
    {"image": "images/sweets/cup.jpeg", "name": "Cupcake"},
    {"image": "images/sweets/sundae.jpg", "name": "Sundae"},
    {"image": "images/sweets/donut.jpg", "name": "Donut"},
    {"image": "images/sweets/trifle.jpeg", "name": "Trifle"},
  ];
  List<Map> drinks = [
    {"image": "images/drinks/pep.jpg", "name": "Pepsi"},
    {"image": "images/drinks/cap.jpg", "name": "Cappy"},
    {"image": "images/drinks/coc.png", "name": "Coca Cola"},
    {"image": "images/drinks/dr.jpeg", "name": "Original"},
    {"image": "images/drinks/sp.png", "name": "Sprite"},
    {"image": "images/drinks/fan.jpg", "name": "Fanta"},
  ];
  List<Map> choice = [];
  @override
  Widget build(BuildContext context) {
    String toSend = "";
    double earings = 300;
    int myorder = 15;
    int orderFdeliver = 3;
    int orderInWait = 1;
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(20),
      color: Color.fromARGB(255, 247, 247, 247),
      width: size.width,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 218, 218, 218),
                        blurRadius: 5,
                        spreadRadius: 2,
                      )
                    ],
                  ),
                  height: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "My Orders : $myorder",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Order for delivery : $orderFdeliver",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Ordar in wait : $orderInWait",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                flex: 3,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 218, 218, 218),
                        blurRadius: 5,
                        spreadRadius: 2,
                      )
                    ],
                  ),
                  height: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Total Earings ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "$earings ₪",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Divider(
            color: Colors.black,
            height: 70,
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            alignment: Alignment.bottomLeft,
            child: Text(
              "Categories",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 130,
            width: double.infinity,
            child: ListView.builder(
                itemCount: categories.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, i) {
                  return MaterialButton(
                    padding: EdgeInsets.all(8),
                    onPressed: () {
                      setState(() {
                        toSend = categories[i]['name'];
                        switch (toSend) {
                          case "Soft drinks":
                            choice = drinks;
                            break;
                          case "French fries":
                            choice = fries;
                            break;
                          case "Fried chicken":
                            choice = friedChicken;
                            break;
                          case "Desserts":
                            choice = desserts;
                            break;
                        }
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
                                  color: Color.fromARGB(255, 197, 197, 197),
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
          Column(
            children: listGenerate(toSend),
          )
        ],
      ),
    );
  }

  listGenerate(String s) {
    return List.generate(choice.length, (index) {
      return Container(
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.only(bottom: 15),
        width: double.infinity,
        height: 120,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Color.fromARGB(255, 197, 197, 197), blurRadius: 4)
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
                      image: AssetImage(choice[index]['image']))),
            ),
            SizedBox(
              width: 10,
            ),
            SizedBox(
              width: 170,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    choice[index]['name'],
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    "98 ₪",
                    style: TextStyle(fontSize: 18),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 18,
                        color: Colors.amberAccent,
                      ),
                      Icon(
                        Icons.star,
                        size: 18,
                        color: Colors.amberAccent,
                      ),
                      Icon(
                        Icons.star,
                        size: 18,
                        color: Colors.amberAccent,
                      ),
                      Icon(
                        Icons.star,
                        size: 18,
                        color: Colors.amberAccent,
                      ),
                      Icon(
                        Icons.star_border_outlined,
                        size: 18,
                        color: Colors.amberAccent,
                      ),
                    ],
                  )
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductInsideStore(
                              choice[index]['name'], choice[index]['image'])),
                    );
                  },
                  child: Icon(
                    Icons.edit,
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      choice.removeAt(index);
                    });
                  },
                  child: Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                  ),
                ),
              ],
            )
          ],
        ),
      );
    });
  }
}
