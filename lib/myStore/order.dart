// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class OrderMyStore extends StatefulWidget {
  const OrderMyStore({Key? key}) : super(key: key);

  @override
  State<OrderMyStore> createState() => _OrderMyStoreState();
}

class _OrderMyStoreState extends State<OrderMyStore> {
  List<Map> myOrder = [
    {
      "name": "Chicken Fingers",
      "image": "images/chk/chf.jpg",
      "price": 8.99,
      "number": 1,
      "time": "1-2 PM,Wen",
      "ready": false,
    },
    {
      "name": "Crispy",
      "image": "images/chk/cris.jpg",
      "price": 10.99,
      "number": 2,
      "time": "6-7 PM,Today",
      "ready": false,
    },
    {
      "name": "Broasted fillet-fish",
      "image": "images/chk/fele.jpeg",
      "price": 7.99,
      "number": 3,
      "time": "Now",
      "ready": false,
    }
  ];

  bool delevState = false;
  Color color = Colors.black;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
        padding: EdgeInsets.all(20),
        color: Color.fromARGB(255, 247, 247, 247),
        width: size.width,
        height: 500,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: listGenerate(),
          ),
        ));
  }

  listGenerate() {
    return List.generate(myOrder.length, (index) {
      return Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(myOrder[index]['image'])),
              border: Border.all(
                  color: Color.fromARGB(255, 197, 197, 197), width: 1),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    myOrder.removeAt(index);
                  });
                },
                child: Container(
                    margin: EdgeInsets.only(left: 40, top: 15),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      "Reject",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    myOrder[index]['ready'] = true;
                  });
                },
                child: Container(
                    margin: EdgeInsets.only(right: 40, top: 15),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: myOrder[index]['ready']
                              ? Colors.green
                              : Colors.black,
                        ),
                        Visibility(
                          visible: myOrder[index]['ready'],
                          child: Container(
                              margin: EdgeInsets.only(left: 5),
                              child: Text(
                                "Ready to deliver",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                        )
                      ],
                    )),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            height: 120,
            margin: EdgeInsets.only(top: 150, right: 50, left: 50, bottom: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Color.fromARGB(255, 197, 197, 197), blurRadius: 4)
              ],
              border: Border.all(color: Colors.white, width: 1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          myOrder[index]['name'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ],
                    )),
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: VerticalDivider(
                      color: Colors.grey,
                      width: 2,
                    ),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: Text(
                              "${myOrder[index]['price']} ₪",
                              style: TextStyle(fontSize: 22),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("Quantity : "),
                              Text("${myOrder[index]['number']}"),
                            ],
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "Order Time",
                                  style: TextStyle(color: Colors.green[800]),
                                ),
                                Text("${myOrder[index]['time']}",
                                    style: TextStyle(color: Colors.green[800]))
                              ],
                            ),
                          )
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ],
      );
    });
  }
}
