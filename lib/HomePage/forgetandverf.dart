// ignore_for_file: prefer_const_constructors, sort_child_properties_last, avoid_print, use_build_context_synchronously, unrelated_type_equality_checks

import 'package:email_auth/email_auth.dart';
import 'package:fast_and_yummy/HomePage/resetpass.dart';
import 'package:fast_and_yummy/HomePage/signUpInformation.dart';
import 'package:fast_and_yummy/api/api.dart';
import 'package:fast_and_yummy/user%20page/basic_user.dart';
import 'package:flutter/material.dart';

import '../api/linkapi.dart';

class ForgetPassAndVerf extends StatefulWidget {
  bool sign;
  String ema;
  ForgetPassAndVerf(this.sign, this.ema, {Key? key}) : super(key: key);

  @override
  State<ForgetPassAndVerf> createState() => _ForgetPassAndVerfState();
}

class _ForgetPassAndVerfState extends State<ForgetPassAndVerf> {
  GlobalKey<FormState> formstate = GlobalKey();
  Color color = Color.fromARGB(255, 37, 179, 136);
  bool show = false;
  bool chose = false;
  String userIDNumber = "";
  TextEditingController email = TextEditingController();
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  TextEditingController t3 = TextEditingController();
  TextEditingController t4 = TextEditingController();
  TextEditingController t5 = TextEditingController();
  TextEditingController t6 = TextEditingController();
  void send(String s) {
    EmailAuth emailAuth = EmailAuth(
      sessionName: "Fast And Yummy",
    );
    emailAuth.sendOtp(recipientMail: chose ? email.text : widget.ema);
  }

  void verifyOtp(String str) async {
    /********************************************** */
    var response = await api.postReq(
      forgetLink,
      {
        "email": widget.ema,
      },
    );
    print(response);
    userIDNumber = response['data'][0]['id'];
    print(userIDNumber);
    /***************************************** */
    EmailAuth emailAuth = EmailAuth(
      sessionName: "Fast And Yummy",
    );

    var res = emailAuth.validateOtp(
        recipientMail: chose ? email.text : widget.ema, userOtp: str);
    if (res == true) {
      widget.sign || chose
          ? Navigator.push(context,
              MaterialPageRoute(builder: (context) => ResetPass(email.text)))
          : Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => afterSignup(userIDNumber)));
    } else {
      setState(() {
        show = true;
      });
    }
  }

  Api api = Api();
  checkEmail() async {
    var resp = await api.postReq(
      forgetLink,
      {
        "email": email.text,
      },
    );

    if (resp['status'] == "suc") {
      setState(() {
        widget.sign = !widget.sign;
        chose = !chose;
        userIDNumber = resp['data'][0]['id'];
        print("we are inside map murad farhat");
      });
      send(email.text);
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Email not found"),
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
            logo(widget.sign ? "images/forget.png" : "images/otp.png"),
            SizedBox(
              height: 40,
            ),
            widget.sign ? pad1() : pad2(),
            SizedBox(
              height: 10,
            ),
            Visibility(
              visible: show && !widget.sign,
              child: Text(
                "Wrong OTP, please check it again",
                style: TextStyle(color: Colors.red),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Visibility(
              visible: !widget.sign,
              child: InkWell(
                onTap: () {
                  send(widget.sign ? email.text : widget.ema);
                },
                child: Text(
                  "Didn't receive code, send it again",
                  style: TextStyle(
                    color: Color.fromARGB(255, 71, 71, 71),
                    fontFamily: "Prompt2",
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            elvD(
                widget.sign ? "Send" : "Check",
                widget.sign
                    ? () async {
                        await checkEmail();
                      }
                    : () {
                        String s = t1.text +
                            t2.text +
                            t3.text +
                            t4.text +
                            t5.text +
                            t6.text;
                        setState(() {
                          verifyOtp(s);
                        });
                      }),
          ],
        ),
      ),
    );
  }

  Padding pad1() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 35),
      child: Form(
        key: formstate,
        child: TextFormField(
          controller: email,
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
            hintText: "Email addres or phone number",
            fillColor: Colors.black,
            hintStyle: TextStyle(
              fontFamily: "Prompt2",
            ),
          ),
        ),
      ),
    );
  }

  Padding pad2() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Form(
        key: formstate,
        child: SizedBox(
          height: 70,
          child: Row(
            children: [
              Flexible(
                child: textD(t1, true, false),
              ),
              SizedBox(
                width: 14,
              ),
              Flexible(
                child: textD(t2, false, false),
              ),
              SizedBox(
                width: 14,
              ),
              Flexible(
                child: textD(t3, false, false),
              ),
              SizedBox(
                width: 14,
              ),
              Flexible(
                child: textD(t4, false, false),
              ),
              SizedBox(
                width: 14,
              ),
              Flexible(
                child: textD(t5, false, false),
              ),
              SizedBox(
                width: 14,
              ),
              Flexible(
                child: textD(t6, false, true),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextField textD(TextEditingController cont, bool first, bool last) {
    return TextField(
      autofocus: true,
      onChanged: (value) {
        if (value.length == 1 && last == false) {
          FocusScope.of(context).nextFocus();
        }
        if (value.isEmpty && first == false) {
          FocusScope.of(context).previousFocus();
        }
      },
      controller: cont,
      showCursor: false,
      readOnly: false,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      keyboardType: TextInputType.number,
      maxLength: 1,
      decoration: InputDecoration(
        counter: Offstage(),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.black12),
            borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: color),
            borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  ElevatedButton elvD(text, void Function()? onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        text,
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
}
