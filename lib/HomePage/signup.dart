// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:fast_and_yummy/HomePage/signin.dart';
import 'package:fast_and_yummy/api/api.dart';
import 'package:fast_and_yummy/api/linkapi.dart';
import 'package:fast_and_yummy/user%20page/basic_user.dart';
import 'package:flutter/material.dart';

// ignore_for_file: prefer_const_constructors, sort_child_properties_last
class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController email = TextEditingController();
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();

  bool check = false;
  bool bol = true;

  Color color = Color.fromARGB(255, 37, 179, 136);
  Icon ico = Icon(
    Icons.remove_red_eye,
    color: Color.fromARGB(255, 37, 179, 136),
  );
  Api api = Api();
  signUP() async {
    RegExp reg = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (reg.hasMatch(email.text)) {
      var resp = await api.postReq(signUpLink, {
        "email": email.text,
        "first_name": firstname.text,
        "last_name": lastname.text,
        "phone": email.text,
        "password": password.text,
        "have_store": "yes"
      });
      if (resp == "suc") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UserPage()),
        );
      }
    } else {
      print("INVALID EMAIL");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formstate,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(35, 45, 35, 0),
            child: textFieldDesign(
                email, TextInputType.emailAddress, "Email", false),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(35, 25, 35, 0),
            child: Row(
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: textFieldDesign(
                        firstname, TextInputType.name, "First Name", false),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: textFieldDesign(
                        lastname, TextInputType.name, "Last Name", false),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(35, 25, 35, 0),
            child: textFieldDesign(phone, TextInputType.phone, "Phone", false),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(35, 25, 35, 0),
            child:
                textFieldDesign(password, TextInputType.text, "Password", bol),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35, top: 25),
            child: Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Checkbox(
                    checkColor: Colors.white,
                    activeColor: color,
                    value: check,
                    onChanged: (val) {
                      setState(() {
                        check = val!;
                      });
                    }),
                InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                                "Our Privecy Polices fsafdgjdfoh\nsafjoidgjosg"),
                            backgroundColor: Color.fromARGB(255, 241, 241, 241),
                            actions: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                  setState(() {
                                    check = true;
                                  });
                                },
                                child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 14, vertical: 10),
                                    color: color,
                                    margin: EdgeInsets.all(14),
                                    child: Text(
                                      "Acept",
                                      style: TextStyle(color: Colors.white),
                                    )),
                              )
                            ],
                          );
                        });
                  },
                  child: Text(
                    "Accept all privecy polices",
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontFamily: "Prompt2",
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Center(
              child: ElevatedButton(
                onPressed: () async {
                  await signUP();
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
                  primary: color,
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
