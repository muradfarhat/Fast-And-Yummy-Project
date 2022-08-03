// ignore_for_file: prefer_const_constructors, must_be_immutable, use_build_context_synchronously

// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:fast_and_yummy/api/api.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
  File? file;
  bool visible = false;
  Color color = Color.fromARGB(255, 37, 179, 136);
  var selected = 0;
  var category = [''];
  dynamic lis;
  bool skip = false;
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
    if (file == null) {
      print("hello");
    } else {
      if (formstate.currentState!.validate()) {
        if (price.text.startsWith("0")) {
          price.text = price.text.substring(1);
        }
        var resp = await api.postReqImage(
            addproductLink,
            {
              "tableName": dropdownvalue,
              "productName": name.text,
              "storeName": widget.storeName,
              "userID": sharedPref.getString("id"),
              "price": price.text,
            },
            file!);
        if (resp['status'] == "suc") {
          showSuccessSnackBarMSG();
          setState(() {
            skip = true;
          });
        } else {
          print("faild");
        }
      }
    }
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
      backgroundColor: Colors.white,
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
                            title: Text(
                              "Add new product",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            trailing: Icon(
                              Icons.edit_note_sharp,
                              size: 30,
                              color: Color.fromARGB(255, 37, 179, 136),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 15),
                            width: size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                textFieldDesign(
                                    "Item product",
                                    Icons.food_bank_outlined,
                                    true,
                                    name, (val) {
                                  return validInput(val!, 4, 20, "ItemN");
                                }),
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
                                    "Price", Icons.price_change, true, price,
                                    (val) {
                                  return validInput(val!, 3, 200, "price");
                                }),
                                SizedBox(
                                  height: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      visible = !visible;
                                    });
                                  },
                                  child: textFieldDesign(
                                      "Image Path", Icons.image, false, image,
                                      (val) {
                                    return validInput(val!, 0, 0, "image");
                                  }),
                                ),
                                Visibility(
                                  visible: visible,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      MaterialButton(
                                        color:
                                            Color.fromARGB(255, 179, 179, 189),
                                        onPressed: () async {
                                          XFile? xfile = await ImagePicker()
                                              .pickImage(
                                                  source: ImageSource.gallery);
                                          file = File(xfile!.path);
                                          setState(() {
                                            image.text = xfile.path;
                                          });
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Icon(
                                                Icons
                                                    .photo_camera_front_outlined,
                                                color: Colors.white),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "Gallery",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                      MaterialButton(
                                        color:
                                            Color.fromARGB(255, 179, 179, 189),
                                        onPressed: () async {
                                          XFile? xfile = await ImagePicker()
                                              .pickImage(
                                                  source: ImageSource.camera);

                                          file = File(xfile!.path);
                                          setState(() {
                                            image.text = xfile.path;
                                          });
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Icon(Icons.camera_alt_outlined,
                                                color: Colors.white),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "Camera",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 40,
                                        width: 100,
                                        color: Colors.white,
                                        child: Text(
                                          "Cancel",
                                          style: TextStyle(color: color),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        await addProduct();
                                        if (skip) {
                                          setState(() {
                                            skip = false;
                                          });

                                          Navigator.pop(context);
                                        } else {
                                          showFaildSnackBarMSG();
                                        }
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
                                )
                              ],
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

  validInput(String val, int min, int max, String str) {
    if (str == "image") {
      return;
    }
    if (val.isEmpty) {
      return "Can't be empty";
    }
    RegExp priceReg = RegExp(r"^\d+(,\d{1,2})?$");
    switch (str) {
      case "ItemN":
        {
          {
            if (val.length < min) {
              return "$min letters at least";
            }
            if (val.length > max) {
              return "more than $max letters";
            }
          }
        }
        break;
      case "price":
        {
          if (!priceReg.hasMatch(val)) {
            return "Price should have only digits";
          }
          if (val.length > min) {
            return "Should be only 2 digits, please check it again";
          }

          if (int.parse(val) > max) {
            return "Should be less than \$$max";
          }
        }
    }
  }

  TextFormField textFieldDesign(
    String hint,
    IconData icon,
    bool en,
    TextEditingController cont,
    final String? Function(String?)? valid,
  ) {
    return TextFormField(
      cursorColor: Color.fromARGB(255, 21, 157, 117),
      controller: cont,
      validator: valid,
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

  showSuccessSnackBarMSG() {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: color.withOpacity(0.7),
      content: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 15),
            child: Icon(
              Icons.check_circle_rounded,
              color: Colors.white,
              size: 35,
            ),
          ),
          Text(
            "The Product added",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )
        ],
      ),
      duration: Duration(milliseconds: 400),
      margin: EdgeInsets.all(20),
    ));
  }

  showFaildSnackBarMSG() {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.red.withOpacity(0.7),
      content: Row(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Container(
            margin: const EdgeInsets.only(right: 15),
            child: const Icon(
              Icons.close,
              color: Colors.white,
              size: 35,
            ),
          ),
          const Text(
            "Please chose image",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )
        ],
      ),
      duration: const Duration(milliseconds: 400),
      margin: const EdgeInsets.all(20),
    ));
  }
}
