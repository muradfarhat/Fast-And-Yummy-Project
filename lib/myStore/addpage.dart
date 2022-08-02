// ignore_for_file: prefer_const_constructors, must_be_immutable

// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:fast_and_yummy/api/api.dart';
import 'package:flutter/material.dart';

import '../api/linkapi.dart';
import '../main.dart';

class AddPage extends StatefulWidget {
  String storeName;
  AddPage(this.storeName, {Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController image = TextEditingController();
  late bool bol = false;
  late bool bol2 = false;
  Color color = Color.fromARGB(255, 37, 179, 136);
  var selected = 0;
  var category = [''];
  dynamic lis;
  Api api = Api();
  bool loading = false;
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
        lis = resp['data'];
        int x = lis.length;

        category.clear();
        for (int i = 0; i < x; i++) {
          category.add(lis[i]['cateName']);
        }
        dropdownvalue = category[0];
      });
    } else {}
  }

  addProduct() async {
    var resp = await api.postReq(addproductLink, {
      "tableName": dropdownvalue,
      "productName": name.text,
      "storeName": widget.storeName,
      "userID": sharedPref.getString("id"),
      "price": price.text,
    });
    if (resp['status'] == "suc") {
    } else {}
  }

  @override
  void initState() {
    getCate();
    super.initState();
  }

  String? dropdownvalue;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color,
        toolbarHeight: 0,
      ),
      body: loading
          ? SizedBox(
              height: size.height,
              width: size.width,
              child: Center(
                child: CircularProgressIndicator(color: color),
              ),
            )
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 200,
                        width: size.width,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("images/photo.jpg"),
                              fit: BoxFit.cover),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromARGB(255, 78, 78, 78),
                                blurRadius: 15,
                                spreadRadius: 5,
                                offset: Offset(0, 3))
                          ],
                        ),
                      ),
                      Container(
                        height: 200,
                        width: size.width,
                        decoration:
                            BoxDecoration(color: Colors.black.withOpacity(0.3)),
                      ),
                      Positioned(
                        left: 10,
                        top: 10,
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: size.width,
                    child: Form(
                      key: formstate,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            onTap: () {
                              setState(() {
                                bol2 = !bol2;
                              });
                            },
                            title: Text(
                              "New Item",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            trailing: Icon(
                              Icons.edit_note_sharp,
                              size: 30,
                              color: Color.fromARGB(255, 37, 179, 136),
                            ),
                          ),
                          Visibility(
                            visible: bol2,
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 15),
                              width: size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  textFieldDesign("Item Name",
                                      Icons.food_bank_outlined, true, name),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(
                                        Icons.food_bank,
                                        color: color,
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Flexible(
                                        child: DropdownButton(
                                          isExpanded: true,
                                          value: dropdownvalue,
                                          items: category.map((String items) {
                                            return DropdownMenuItem(
                                              value: items,
                                              child: Text(
                                                items,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (String? value) {
                                            setState(() {
                                              dropdownvalue = value!;
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  textFieldDesign(
                                      "Price", Icons.price_change, true, price),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  textFieldDesign(
                                      "Image Path", Icons.image, false, image),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      addProduct();
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 40,
                                      width: 100,
                                      color: color,
                                      child: Text(
                                        "Save",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  TextFormField textFieldDesign(
      String hint, IconData icon, bool en, TextEditingController cont) {
    return TextFormField(
      cursorColor: Color.fromARGB(255, 21, 157, 117),
      controller: cont,
      decoration: InputDecoration(
        enabled: en,
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 21, 157, 117)),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 21, 157, 117)),
        ),
        hintText: hint,
        fillColor: Colors.black,
        hintStyle: TextStyle(
          fontFamily: "Prompt2",
        ),
        icon: InkWell(
          child: Icon(
            icon,
            color: Color.fromARGB(255, 21, 157, 117),
          ),
        ),
      ),
    );
  }
}
