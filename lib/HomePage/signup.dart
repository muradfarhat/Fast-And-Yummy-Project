import 'package:fast_and_yummy/HomePage/signin.dart';
import 'package:flutter/material.dart';

// ignore_for_file: prefer_const_constructors, sort_child_properties_last
class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);
  bool bol = true;
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(35, 45, 35, 0),
          child: textFieldDesign(
              TextInputType.emailAddress, "Email or Username", false),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(35, 25, 35, 0),
          child: Row(
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child:
                      textFieldDesign(TextInputType.name, "First Name", false),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child:
                      textFieldDesign(TextInputType.name, "Last Name", false),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(35, 25, 35, 0),
          child: textFieldDesign(TextInputType.phone, "Phone", false),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(35, 25, 35, 0),
          child: textFieldDesign(TextInputType.text, "Password", bol),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 35, top: 25),
          child: Row(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Checkbox(value: false, onChanged: null),
              Text(
                "Accept all privecy polices",
                style: TextStyle(
                  color: Color.fromARGB(255, 117, 117, 117),
                  fontFamily: "Prompt2",
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 25.0),
          child: Center(
            child: ElevatedButton(
              onPressed: () {},
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
