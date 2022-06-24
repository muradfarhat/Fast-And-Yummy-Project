// ignore_for_file: prefer_const_constructors, sort_child_properties_last, must_be_immutable
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  SignIn({Key? key}) : super(key: key);
  bool bol = true;
  @override
  State<SignIn> createState() => _SignInState();
}

bool bol = true;

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
              TextInputType.emailAddress, "Email or Username", false),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(35, 25, 35, 0),
          child: textFieldDesign(TextInputType.emailAddress, "Password", bol),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 25.0),
          child: Center(
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  if (bol == true) {
                    bol = false;
                  } else {
                    bol = true;
                  }
                });
              },
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
                setState(() {});
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
        Image(
          image: AssetImage("images/colors.png"),
        ),
      ],
    );
  }
}

TextFormField textFieldDesign(
    TextInputType inputType, String hint, bool obscureTextState) {
  return TextFormField(
    cursorColor: Color.fromARGB(255, 21, 157, 117),
    keyboardType: inputType,
    obscureText: obscureTextState,
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
