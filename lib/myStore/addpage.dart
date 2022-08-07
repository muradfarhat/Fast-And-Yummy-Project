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
  GlobalKey<FormState> formstate2 = GlobalKey();
  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController image = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController addC = TextEditingController();
  bool info = false;
  bool cont = false;
  File? file;
  bool visible = false;
  Color color = Color.fromARGB(255, 37, 179, 136);
  var selected = 0;
  var category = [''];
  List content = [];
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
      showFaildSnackBarMSG("Please chose image");
    } else {
      if (content.isEmpty) {
        showFaildSnackBarMSG("You should add at least one content");
      } else if (formstate.currentState!.validate()) {
        String s = "";
        setState(() {
          for (int i = 0; i < content.length; i++) {
            s += content[i];
            if (i + 1 != content.length) {
              s += " ";
            }
          }
        });
        var resp = await api.postReqImage(
            addproductLink,
            {
              "tableName": dropdownvalue,
              "productName": name.text,
              "storeName": widget.storeName,
              "userID": sharedPref.getString("id"),
              "price": price.text,
              "description": description.text,
              "content": s.toString()
            },
            file!);
        content.clear();
        if (resp['status'] == "suc") {
          showSuccessSnackBarMSG();
          setState(() {
            skip = true;
          });
        } else {}
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
                          InkWell(
                            onTap: () {
                              setState(() {
                                info = !info;
                              });
                            },
                            child: ListTile(
                              title: Text(
                                "Product Information",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              trailing: Icon(
                                Icons.edit_note_sharp,
                                size: 30,
                                color: Color.fromARGB(255, 37, 179, 136),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: info,
                            child: Container(
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
                                              print(dropdownvalue);
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
                                          color: Color.fromARGB(
                                              255, 179, 179, 189),
                                          onPressed: () async {
                                            XFile? xfile = await ImagePicker()
                                                .pickImage(
                                                    source:
                                                        ImageSource.gallery);
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
                                          color: Color.fromARGB(
                                              255, 179, 179, 189),
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
                                  TextFormField(
                                    controller: description,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: ((value) {
                                      if (value!.isEmpty) {
                                        return "Cannot be empty !";
                                      } else if (value.length < 10) {
                                        return "Mustn't be less than 10 letter!";
                                      } else {
                                        return null;
                                      }
                                    }),
                                    maxLines: 5,
                                    maxLength: 150,
                                    decoration: InputDecoration(
                                      icon: Icon(
                                        Icons.description,
                                        color: color,
                                      ),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: color)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: color)),
                                      labelText: "Description",
                                      labelStyle: TextStyle(color: color),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                cont = !cont;
                              });
                            },
                            child: ListTile(
                              title: Text(
                                "Product Content",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              trailing: Icon(
                                Icons.edit_note_sharp,
                                size: 30,
                                color: Color.fromARGB(255, 37, 179, 136),
                              ),
                            ),
                          ),
                          Form(
                            key: formstate2,
                            child: Visibility(
                              visible: cont,
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 15),
                                width: size.width,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Flexible(
                                          child: SizedBox(
                                            width: size.width / 2,
                                            child: TextFormField(
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Can't be empty";
                                                }
                                              },
                                              maxLength: 10,
                                              controller: addC,
                                              cursorColor: Color.fromARGB(
                                                  255, 21, 157, 117),
                                              //controller: cont,
                                              // validator: valid,
                                              decoration: InputDecoration(
                                                //  enabled: en,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color.fromARGB(
                                                          255, 21, 157, 117)),
                                                ),
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color.fromARGB(
                                                          255, 21, 157, 117)),
                                                ),
                                                //   hintText: hint,
                                                fillColor: Colors.black,
                                                hintStyle: TextStyle(
                                                  fontFamily: "Prompt2",
                                                ),
                                                icon: Icon(
                                                  Icons.content_paste_rounded,
                                                  color: Color.fromARGB(
                                                      255, 21, 157, 117),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                if (formstate2.currentState!
                                                    .validate()) {
                                                  content.add(addC.text);
                                                  addC.clear();
                                                }
                                              });
                                            },
                                            child: Icon(
                                              Icons.add,
                                              color: color,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    content.isEmpty
                                        ? Center(
                                            child: Text(
                                            "No content added",
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ))
                                        : Wrap(
                                            direction: Axis.horizontal,
                                            children: listGenerate(),
                                          ),
                                    SizedBox(
                                      height: 15,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
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
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 40,
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

  listGenerate() {
    return List.generate(content.length, (index) {
      return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Color.fromARGB(255, 197, 197, 197), blurRadius: 4)
            ],
            borderRadius: BorderRadius.circular(30),
          ),
          padding: EdgeInsets.symmetric(horizontal: 10),
          margin: EdgeInsets.only(left: 5, bottom: 15, right: 5),
          alignment: Alignment.center,
          width: 150,
          height: 40,
          child: Row(
            children: [
              Expanded(child: Icon(Icons.fastfood)),
              SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 3,
                child: Text(
                  "${content[index]}", // ${favorite[index]['name']}
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 17),
                ),
              ),
              Expanded(
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          content.removeAt(index);
                        });
                      },
                      icon: Icon(Icons.close),
                      splashColor: Colors.white))
            ],
          ));
    });
  }

  validInput(String val, int min, int max, String str) {
    if (str == "image") {
      return;
    }
    if (val.isEmpty) {
      return "Can't be empty";
    }
    RegExp priceReg = RegExp(r"^[+-]?([0-9]+([.][0-9]*)?|[.][0-9]+)$");
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

          if (double.parse(val) > max) {
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
      autovalidateMode: AutovalidateMode.onUserInteraction,
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

  showFaildSnackBarMSG(String text) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.red.withOpacity(0.7),
      content: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 15),
            child: const Icon(
              Icons.close,
              color: Colors.white,
              size: 35,
            ),
          ),
          Text(
            "$text",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )
        ],
      ),
      duration: const Duration(seconds: 1),
      margin: const EdgeInsets.all(20),
    ));
  }
}
