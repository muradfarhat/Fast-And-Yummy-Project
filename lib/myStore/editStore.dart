// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../api/api.dart';
import '../api/linkapi.dart';
import '../main.dart';

class EditStore extends StatefulWidget {
  const EditStore({Key? key}) : super(key: key);

  @override
  State<EditStore> createState() => _EditStoreState();
}

class _EditStoreState extends State<EditStore> {
  GlobalKey<FormState> formStateForName = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  File? file;
  File? _image;
  dynamic lis;
  bool change = false;
  bool loading = false;
  Api api = Api();
  String? text;
  String? storeName;
  bool visible = false;
  bool notEnable = false;
  getStoreData() async {
    setState(() {
      loading = true;
    });

    var resp = await api.postReq(storeInfo, {"id": sharedPref.getString("id")});
    setState(() {
      loading = false;
    });
    if (resp['status'] == "suc") {
      setState(() {
        lis = resp['data'];
      });
    } else {}
  }

  storeNameU() async {
    setState(() {
      loading = true;
    });

    var resp = await api.postReq(storeNameLink, {
      "id": sharedPref.getString("id"),
      "storeName": storeName,
    });
    setState(() {
      loading = false;
    });
    if (resp['status1'] == "suc") {
      setState(() {
        lis = resp['data'];
      });
    } else {}
  }

  @override
  void initState() {
    getStoreData();
    super.initState();
  }

  Future getImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    final temp = File(image.path);

    setState(() {
      _image = temp;
      file = File(image.path);
    });
  }

  uploadImageF() async {
    if (file == null) {
    } else {
      var resp = await api.postReqImage(
          storeImageLink,
          {
            "id": sharedPref.getString("id"),
          },
          _image!);
      if (resp['status'] == "suc") {
        getStoreData();
        return true;
      }
    }
  }

  deleteStore() async {
    var resp = await api.postReq(
      deleteStoreLink,
      {
        "storeID": sharedPref.getString("id"),
        "imagename": lis?['storeImage'],
      },
    );
    if (resp['status'] == "suc") {}
  }

  Color color = Color.fromARGB(255, 37, 179, 136);
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
                  SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    title: Text(
                      "Edit store",
                      style: TextStyle(
                          color: color,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(
                      Icons.edit_note_sharp,
                      size: 35,
                      color: color,
                    ),
                  ),
                  Container(
                    width: size.width,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 235, 235, 235),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromARGB(255, 133, 133, 133),
                            blurRadius: 8,
                            offset: Offset(0, 3))
                      ],
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child: Form(
                      key: formStateForName,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 226, 226, 226),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    blurRadius: 2,
                                    offset: Offset(0, 0))
                              ],
                            ),
                            margin: EdgeInsets.all(10),
                            child: Stack(
                              children: [
                                _image != null
                                    ? Image.file(
                                        _image!,
                                        width: size.width,
                                        height: 230,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.network(
                                        "$imageRoot/${lis?['storeImage']}",
                                        width: size.width,
                                        height: 230,
                                        fit: BoxFit.cover,
                                      ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                visible = !visible;
                              });
                            },
                            child: ListTile(
                              title: Text(
                                "Change Image",
                                style: TextStyle(
                                    color: color,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                              trailing: Icon(
                                Icons.image_outlined,
                                size: 35,
                                color: color,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: visible,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                MaterialButton(
                                  color: Color.fromARGB(255, 179, 179, 189),
                                  onPressed: () {
                                    getImage(ImageSource.gallery);
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(Icons.photo_camera_front_outlined,
                                          color: Colors.white),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Gallery",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                MaterialButton(
                                  color: Color.fromARGB(255, 179, 179, 189),
                                  onPressed: () {
                                    getImage(ImageSource.camera);
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
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              children: [
                                TextFormField(
                                  autovalidateMode: AutovalidateMode.always,
                                  validator: (storeName) {
                                    if (storeName!.length > 20 ||
                                        storeName.length < 3) {
                                      return "Invalid input";
                                    } else {
                                      return null;
                                    }
                                  },
                                  onSaved: (text) {
                                    storeName = text;
                                  },
                                  initialValue: "${lis?['storeName']}",
                                  decoration: InputDecoration(
                                    labelText: "Store name",
                                    labelStyle: TextStyle(color: color),
                                  ),
                                ),
                                Container(
                                    margin: EdgeInsets.only(top: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        MaterialButton(
                                          minWidth: 10,
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Icon(Icons.cancel, color: color),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "Cancel",
                                                style: TextStyle(color: color),
                                              ),
                                            ],
                                          ),
                                        ),
                                        MaterialButton(
                                          minWidth: 10,
                                          color: color,
                                          onPressed: () {
                                            var state =
                                                formStateForName.currentState;
                                            state!.save();
                                            uploadImageF();
                                            storeNameU();
                                            Navigator.pop(context);
                                            _image = null;
                                          },
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Icon(Icons.save,
                                                  color: Colors.white),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "Save",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Column(
                              children: [
                                Text("Are you sure to deactivate your store ?"),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.warning_amber_rounded,
                                      size: 20,
                                      color: Colors.yellow,
                                    ),
                                    SizedBox(width: 10),
                                    Flexible(
                                      child: Text(
                                        "All proudcts and info will be deleted",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    MaterialButton(
                                      color: color,
                                      onPressed: () {
                                        setState(() {
                                          deleteStore();
                                          Navigator.popUntil(context,
                                              (route) => route.isFirst);
                                        });
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(Icons.check,
                                              color: Colors.white),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Yes",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                    MaterialButton(
                                      color: Colors.red,
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Icon(Icons.close,
                                              color: Colors.white),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "No",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromARGB(255, 133, 133, 133),
                              blurRadius: 8,
                              offset: Offset(0, 3))
                        ],
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      width: size.width,
                      height: 52,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.cancel_presentation,
                              size: 30, color: Colors.white),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Deactivate my store",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20),
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
}
