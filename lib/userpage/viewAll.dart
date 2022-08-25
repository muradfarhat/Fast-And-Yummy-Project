// ignore_for_file: prefer_const_constructors

import 'package:fast_and_yummy/api/linkapi.dart';
import 'package:flutter/material.dart';

import '../detialscreen.dart';

class ViewAll extends StatefulWidget {
  dynamic list;
  ViewAll(this.list, {Key? key}) : super(key: key);

  @override
  State<ViewAll> createState() => _ViewAllState();
}

class _ViewAllState extends State<ViewAll> {
  List productList = [];

  List productListDisplay = [];
  @override
  void initState() {
    productList = widget.list;
    productListDisplay = List.from(productList);
    super.initState();
  }

  void updateList(String value) {
    setState(() {
      productListDisplay = productList
          .where((element) => element['productName']
              .toLowerCase()
              .contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        title: TextFormField(
          onChanged: (value) {
            updateList(value);
          },
          // take text value and store it in searchValue variable
          textInputAction: TextInputAction.go,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 1),
            // ignore: prefer_const_constructors
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
      ),
      body: ListView.builder(
          itemCount: productListDisplay.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, i) {
            return MaterialButton(
              padding: EdgeInsets.all(8),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Detialscreen(
                        productListDisplay[i],
                        productListDisplay[i]['userID'],
                        productListDisplay[i]['cateID']),
                  ),
                );
              },
              child: Container(
                  padding: EdgeInsets.all(5),
                  width: double.infinity,
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
                                image: NetworkImage(
                                    "$imageRoot/${productListDisplay[i]['image']}"))),
                      ),
                      Container(
                        width: 120,
                        // ignore: prefer_const_constructors
                        padding: EdgeInsets.only(top: 15, left: 10, right: 10),
                        child: Column(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Container(
                              width: double.infinity,
                              child: Text(
                                "${productListDisplay[i]['productName']}",
                                overflow: TextOverflow.clip, // For text wraping
                                // ignore: prefer_const_constructors
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              width: double.infinity,
                              child: Text(
                                "${productListDisplay[i]['storeName']}",
                                overflow: TextOverflow.clip, // For text wraping
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            // ignore: prefer_const_constructors
                            Divider(
                              color: Colors.white,
                            ),
                            Container(
                              child: Row(children: [
                                Container(
                                  margin: EdgeInsets.only(right: 5),
                                  child: Text(
                                      double.parse(widget.list[i]["rate"])
                                          .toStringAsFixed(2)),
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow[600],
                                )
                              ]),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Text(
                                "${productListDisplay[i]['price']} \$",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 37, 179, 136),
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Number of buyers: ${productListDisplay[i]['totalBuy']}",
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
            );
          }),
    );
  }

  /************************ Start Functions Section ************************************* */
  OutlineInputBorder outLDesign() {
    return OutlineInputBorder(
        gapPadding: 10,
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Colors.white, width: 1));
  }
  /************************ End Functions Section ************************************* */
}
