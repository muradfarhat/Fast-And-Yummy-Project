// ignore_for_file: use_build_context_synchronously, must_be_immutable, curly_braces_in_flow_control_structures, prefer_const_constructors_in_immutables, avoid_print, unrelated_type_equality_checks

import 'package:email_auth/email_auth.dart';
import 'package:fast_and_yummy/HomePage/forget.dart';
import 'package:fast_and_yummy/api/api.dart';
import 'package:fast_and_yummy/api/linkapi.dart';
import 'package:fast_and_yummy/user%20page/basic_user.dart';
import 'package:flutter/material.dart';
import 'package:email_auth/email_auth.dart';

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
  TextEditingController valid = TextEditingController();
  bool check = false;
  bool bol = true;
  bool privcey = false;

  Color color = Color.fromARGB(255, 37, 179, 136);
  Icon ico = Icon(
    Icons.remove_red_eye,
    color: Color.fromARGB(255, 37, 179, 136),
  );
  Api api = Api();
  void send() {
    EmailAuth emailAuth = EmailAuth(
      sessionName: "Fast And Yummy",
    );
    emailAuth.sendOtp(recipientMail: email.text);
  }

  signUP() async {
    if (formstate.currentState!.validate() && !privcey) {
      var resp = await api.postReq(signUpLink, {
        "email": email.text,
        "first_name": firstname.text,
        "last_name": lastname.text,
        "phone": phone.text,
        "password": password.text,
        "have_store": "no"
      });

      if (resp == "suc") {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ForgetPass(false, email.text)),
        );
        send();
      }
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
            child: textFieldDesign((val) {
              return validInput(val!, 0, 0, "email");
            }, email, TextInputType.emailAddress, "Email", false),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(35, 25, 35, 0),
            child: Row(
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: textFieldDesign((val) {
                      return validInput(val!, 3, 12, "fn");
                    }, firstname, TextInputType.name, "First Name", false),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: textFieldDesign((val) {
                      return validInput(val!, 3, 12, "ln");
                    }, lastname, TextInputType.name, "Last Name", false),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(35, 25, 35, 0),
            child: textFieldDesign((val) {
              return validInput(val!, 0, 0, "");
            }, phone, TextInputType.phone, "Phone", false),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(35, 25, 35, 0),
            child: textFieldDesign((val) {
              return validInput(val!, 6, 20, "password");
            }, password, TextInputType.text, "Password", bol),
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
                            title: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Text("Privacy and Polices"),
                            ),
                            content: Container(
                              padding: EdgeInsets.all(10),
                              color: Color.fromARGB(255, 255, 255, 255),
                              height: 300,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  children: const [Text(policy)],
                                ),
                              ),
                            ),
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
                                      "Accept",
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
          Visibility(
            visible: privcey,
            child: Padding(
              padding: const EdgeInsets.only(left: 55),
              child: Text(
                "You don't accept privecy polices",
                style: TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Center(
              child: ElevatedButton(
                onPressed: () async {
                  setState(() {
                    if (check == false) {
                      privcey = true;
                    } else
                      privcey = false;
                  });
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

  TextFormField textFieldDesign(
      final String? Function(String?)? valid,
      TextEditingController cont,
      TextInputType inputType,
      String hint,
      bool obscureTextState) {
    return TextFormField(
      validator: valid,
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

  validInput(String val, int min, int max, String str) {
    if (val.isEmpty) {
      return "Can't be empty";
    }
    RegExp emailReg = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    switch (str) {
      case "email":
        {
          if (!emailReg.hasMatch(val)) {
            return "Invalid Email, please check it again";
          }
        }
        break;
      case "fn":
        {
          if (val.length < min) {
            return "$min letters at least";
          }
          if (val.length > max) {
            return "more than $max letters";
          }
        }
        break;
      case "ln":
        {
          if (val.length < min) {
            return "$min letters at least";
          }
          if (val.length > max) {
            return "more than $max letters";
          }
        }
        break;
      case "phone":
        {
          if (val.length != 10) {
            return "Invalid phone, please check it again";
          }
        }
        break;
      case "password":
        {
          if (val.length < min) {
            return "Should be $min letters at least";
          }
          if (val.length > max) {
            return "Should be less than $max letters";
          }
        }
        break;
    }
  }
}
