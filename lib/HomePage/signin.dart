// ignore_for_file: prefer_const_constructors, sort_child_properties_last, must_be_immutable

import 'package:flutter/material.dart';

import '../api/api.dart';
import '../user page/basic_user.dart';

class SignIn extends StatefulWidget {
  SignIn({Key? key}) : super(key: key);
  bool bol = true;
  @override
  State<SignIn> createState() => _SignInState();
}

bool bol = true;

Color color = Color.fromARGB(255, 37, 179, 136);
Icon ico = Icon(
  Icons.remove_red_eye,
  color: Color.fromARGB(255, 37, 179, 136),
);

class _SignInState extends State<SignIn> {
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  Api api = Api();
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 220,
              margin: EdgeInsets.only(top: 45),
              child: Image(
                image: AssetImage("images/logo.png"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(35, 45, 35, 0),
            child: textFieldDesign(
                email, TextInputType.emailAddress, "Email or Username", false),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(35, 25, 35, 0),
            child:
                textFieldDesign(password, TextInputType.text, "Password", bol),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Center(
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  "Forget My Password !",
                  style: TextStyle(
                    color: Color.fromARGB(255, 117, 117, 117),
                    fontFamily: "Prompt2",
                    fontSize: 15,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  primary: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UserPage()),
                    );
                  });
                },
                child: Text(
                  "Sign in",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: "Prompt",
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  primary: Color.fromARGB(255, 37, 179, 136),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 70),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextFormField textFieldDesign(TextEditingController cont,
      TextInputType inputType, String hint, bool obscureTextState) {
    return TextFormField(
      controller: cont,
      cursorColor: Color.fromARGB(255, 21, 157, 117),
      keyboardType: inputType,
      obscureText: obscureTextState,
      decoration: InputDecoration(
        suffix: hint == "Password"
            ? InkWell(
                onTap: () {
                  setState(() {
                    if (bol == true) {
                      ico = Icon(
                        Icons.remove_red_eye_outlined,
                        color: color,
                      );
                      bol = false;
                    } else {
                      ico = Icon(
                        Icons.remove_red_eye,
                        color: color,
                      );
                      bol = true;
                    }
                  });
                },
                child: ico,
              )
            : InkWell(
                child: Text(""),
              ),
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
