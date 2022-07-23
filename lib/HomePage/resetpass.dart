// ignore_for_file: prefer_const_constructors, sort_child_properties_last, avoid_print, use_build_context_synchronously, unrelated_type_equality_checks, must_be_immutable

import 'dart:ffi';

import 'package:fast_and_yummy/HomePage/homepage.dart';
import 'package:fast_and_yummy/api/api.dart';
import 'package:fast_and_yummy/api/linkapi.dart';
import 'package:flutter/material.dart';

class ResetPass extends StatefulWidget {
  String s;
  ResetPass(this.s, {Key? key}) : super(key: key);

  @override
  State<ResetPass> createState() => _ResetPassState();
}

class _ResetPassState extends State<ResetPass> {
  GlobalKey<FormState> formstate = GlobalKey();
  Color color = Color.fromARGB(255, 37, 179, 136);
  TextEditingController reset = TextEditingController();
  TextEditingController confirm = TextEditingController();
  Api api = Api();
  bool match = false;
  resetp() async {
    var resp = await api.postReq(
      resetLink,
      {
        "password": reset.text,
        "email": widget.s,
      },
    );
    if (resp == "suc") {
      print("done");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Can't reset"),
              backgroundColor: Color.fromARGB(255, 241, 241, 241),
              actions: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      color: color,
                      margin: EdgeInsets.all(14),
                      child: Text(
                        "Ok",
                        style: TextStyle(color: Colors.white),
                      )),
                )
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: color,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              logo("images/reset.png"),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 35),
                child: Form(
                  key: formstate,
                  child: Column(
                    children: [
                      txtD(
                        reset,
                        "New password",
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      txtD(confirm, "Confirm new password"),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Visibility(
                visible: match,
                child: Text(
                  "Didn't match",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                    fontFamily: "Prompt",
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              elvD(),
            ],
          ),
        ));
  }

  ElevatedButton elvD() {
    return ElevatedButton(
      onPressed: () async {
        if (reset.text == confirm.text) {
          await resetp();
        } else {
          setState(() {
            match = !match;
          });
        }
      },
      child: Text(
        "Reset",
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontFamily: "Prompt",
        ),
      ),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        primary: color,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 35),
      ),
    );
  }

  Center logo(String s) {
    return Center(
      child: Container(
        width: 300,
        margin: EdgeInsets.only(top: 45),
        child: Image(
          image: AssetImage(s),
        ),
      ),
    );
  }

  TextFormField txtD(TextEditingController cont, String hint) {
    return TextFormField(
      controller: cont,
      cursorColor: Color.fromARGB(255, 21, 157, 117),
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
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
      ),
    );
  }
}
