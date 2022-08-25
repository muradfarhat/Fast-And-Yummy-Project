// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';

import '../api/api.dart';
import '../api/linkapi.dart';
import '../detialscreen.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  Color color = Color.fromARGB(255, 37, 179, 136);
  dynamic lis2;
  Api api = Api();
  bool loading = false;
  List<dynamic> cate = [];
  String? cateName;
  getCate() async {
    setState(() {
      loading = true;
    });
    var resp = await api.postReq(bringAllCate, {});
    setState(() {
      loading = false;
    });
    if (resp['status'] == "suc") {
      setState(() {
        lis2 = resp['data'];
        for (int i = 0; i < lis2.length; i++) {
          cate.add({
            "cateName": lis2[i]['cateName'],
            "color": Colors.white,
          });
        }
      });
    } else {}
  }

  List productList = [];

  List productListDisplay = [];
  void updateList(String value) {
    setState(() {
      productListDisplay = productList
          .where((element) => element['productName']
              .toLowerCase()
              .contains(value.toLowerCase()))
          .toList();
    });
  }

  bringProducts() async {
    var resp = await api.postReq(selectCateLink, {
      "tableName": cateName,
    });

    if (resp['status'] == "suc") {
      setState(() {
        productList = resp['data'];
        productListDisplay = List.from(productList);
      });
    } else {}
  }

  @override
  void initState() {
    getCate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        title: TextFormField(
          autofocus: true,
          onChanged: (value) {
            updateList(value);
          },
          // controller:
          //     searchValue, // take text value and store it in searchValue variable
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
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.fromLTRB(15, 15, 15, 5),
            child: Text(
              "Select category you want search in :",
              style: TextStyle(fontSize: 16),
            ),
          ),
          loading
              ? Center(
                  child: CircularProgressIndicator(
                      color: Color.fromARGB(255, 37, 179, 136)),
                )
              : Container(
                  margin: EdgeInsets.fromLTRB(15, 15, 15, 5),
                  child: Wrap(
                    direction: Axis.horizontal,
                    children: listGenerate(),
                  ),
                ),
          Divider(
            thickness: 1,
            indent: 10,
            endIndent: 10,
          ),
          Expanded(
              child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [...listGenerateProduct()],
            ),
          ))
        ],
      ),
    );
  }

  OutlineInputBorder outLDesign() {
    return OutlineInputBorder(
        gapPadding: 10,
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Colors.white, width: 1));
  }

  listGenerate() {
    return List.generate(cate.length, (index) {
      return Container(
        margin: EdgeInsets.all(5),
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              for (int i = 0; i < cate.length; i++) {
                cate[i]['color'] = Colors.white;
              }
              cate[index]['color'] = Color.fromARGB(255, 212, 212, 212);
              cateName = cate[index]['cateName'];

              productListDisplay.clear();
              bringProducts();
            });
          },
          child: Text(
            "${cate[index]['cateName']}", // ${favorite[index]['name']}
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 17, color: Colors.black),
          ),
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            primary: cate[index]['color'],
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          ),
        ),
      );
    });
  }

  listGenerateProduct() {
    return List.generate(productListDisplay.length, (index) {
      return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Detialscreen(
                  productListDisplay[index],
                  productListDisplay[index]['userID'],
                  productListDisplay[index]['cateID']),
            ),
          );
        },
        child: Container(
            margin: EdgeInsets.fromLTRB(15, 15, 15, 6),
            padding: EdgeInsets.all(5),
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
              // ignore: prefer_const_literals_to_create_immutables
              boxShadow: [
                BoxShadow(
                    color: Color.fromARGB(255, 197, 197, 197), blurRadius: 4)
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
                              "$imageRoot/${productListDisplay[index]['image']}"))),
                ),
                Container(
                  width: 120,
                  padding: EdgeInsets.only(top: 15, left: 10, right: 10),
                  child: Column(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          "${productListDisplay[index]['productName']}",
                          overflow: TextOverflow.clip, // For text wraping
                          // ignore: prefer_const_constructors
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        width: double.infinity,
                        child: Text(
                          "${productListDisplay[index]['storeName']}",
                          overflow: TextOverflow.clip, // For text wraping
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Divider(
                        color: Colors.white,
                      ),
                      Row(children: [
                        Container(
                          margin: EdgeInsets.only(right: 5),
                          child: Text(
                              double.parse(productListDisplay[index]["rate"])
                                  .toStringAsFixed(2)),
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow[600],
                        )
                      ])
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: 20),
                    alignment: Alignment.centerRight,
                    child: Text(
                      "${productListDisplay[index]['price']} \$",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                )
              ],
            )),
      );
    });
  }
}
