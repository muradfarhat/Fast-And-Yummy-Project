// ignore_for_file: prefer_const_constructors, sort_child_properties_last, must_be_immutable, use_build_context_synchronously

import 'package:fast_and_yummy/HomePage/forgetandverf.dart';
import 'package:flutter/material.dart';
import '../api/api.dart';
import '../api/linkapi.dart';
import '../main.dart';
import '../userpage/basic_user.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool bol = true;
  Color color = Color.fromARGB(255, 37, 179, 136);
  Icon ico = Icon(
    Icons.remove_red_eye,
    color: Color.fromARGB(255, 37, 179, 136),
  );
  Api api = Api();

  bool loading = false;
  login() async {
    if (formstate.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      var resp = await api.postReq(
        loginLink,
        {"email": email.text, "password": password.text},
      );
      if (resp['status'] == "suc") {
        setState(() {
          loading = false;
        });
        sharedPref.setString("id", resp['data']['id'].toString());
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => UserPage()),
        );
      } else {
        setState(() {
          loading = false;
        });
        showFaildSnackBarMSG();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: formstate,
      child: loading
          ? SizedBox(
              height: size.height,
              width: size.width,
              child: Center(
                child: CircularProgressIndicator(
                    color: Color.fromARGB(255, 37, 179, 136)),
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                  child: textFieldDesign((val) {
                    return validInput(val!, 0, 0, "email");
                  }, email, TextInputType.emailAddress, "Email", false),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(35, 25, 35, 0),
                  child: textFieldDesign((val) {
                    return validInput(val!, 6, 20, "password");
                  }, password, TextInputType.text, "Password", bol),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ForgetPassAndVerf(true, email.text)),
                      );
                    },
                    child: Text(
                      "Forget Password! ",
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontFamily: "Prompt2",
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        await login();
                      },
                      child: Text(
                        "Log in",
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
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 70),
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
    RegExp phoneReg = RegExp(r"[5][2345690][23456789][0-9]{6}$");
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
          if (!phoneReg.hasMatch(val)) {
            return "Invalid phone number,\nplease check that number start with 59[2:9],56[2:9] \nand have only digits";
          }
          if (val.length > 9) {
            return "Invalid phone number, please check that have 9 digits";
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
            "Wrong Email or Password",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )
        ],
      ),
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(20),
    ));
  }
}
