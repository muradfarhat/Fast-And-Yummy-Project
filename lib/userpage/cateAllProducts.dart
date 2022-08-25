// ignore_for_file: prefer_const_constructors, sort_child_properties_last, must_be_immutable

import 'package:flutter/material.dart';

import '../api/api.dart';
import '../api/linkapi.dart';
import '../detialscreen.dart';

class CateProducts extends StatefulWidget {
  String cateName;
  CateProducts(this.cateName, {Key? key}) : super(key: key);

  @override
  State<CateProducts> createState() => _CateProductsState();
}

class _CateProductsState extends State<CateProducts> {
  bringProducts() async {
    setState(() {
      loading = true;
    });
    var resp = await api.postReq(selectCateLink, {
      "tableName": widget.cateName,
    });
    setState(() {
      loading = false;
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
    bringProducts();
    super.initState();
  }

  Color color = Color.fromARGB(255, 37, 179, 136);
  dynamic lis2;
  Api api = Api();
  bool loading = false;
  List<dynamic> cate = [];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        title: TextFormField(
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
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        width: double.infinity,
                        child: Text(
                          "${productListDisplay[index]['storeName']}",
                          overflow: TextOverflow.clip, // For text wraping
                          // ignore: prefer_const_constructors
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      // igno
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
