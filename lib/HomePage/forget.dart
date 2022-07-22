// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';

class ForgetPass extends StatefulWidget {
  const ForgetPass({Key? key}) : super(key: key);

  @override
  State<ForgetPass> createState() => _ForgetPassState();
}

class _ForgetPassState extends State<ForgetPass> {
  GlobalKey<FormState> formstate = GlobalKey();
  Color color = Color.fromARGB(255, 37, 179, 136);
  bool chose = true;
  TextEditingController email = TextEditingController();
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  TextEditingController t3 = TextEditingController();
  TextEditingController t4 = TextEditingController();
  TextEditingController t5 = TextEditingController();
  TextEditingController t6 = TextEditingController();

  void verifyOtp() async {
    EmailAuth emailAuth = EmailAuth(
      sessionName: "Fast And Yummy",
    );
    var res =
        emailAuth.validateOtp(recipientMail: email.text, userOtp: t1.text);
    if (res) {
      print(("done"));
    }
  }

  void send() {
    EmailAuth emailAuth = EmailAuth(
      sessionName: "Fast And Yummy",
    );
    var res = emailAuth.sendOtp(recipientMail: email.text);
    if (res == true) {
      print(("done"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ourLogo(),
          SizedBox(
            height: 40,
          ),
          chose ? pad1() : pad2(),
          SizedBox(
            height: 40,
          ),
          elvD(chose ? "Send" : "Check"),
        ],
      ),
    );
  }

  Padding pad1() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 35),
      child: TextFormField(
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
                child: textD(t2, true, false),
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

  ElevatedButton elvD(text) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          String s = t1.text + t2.text + t3.text + t4.text + t5.text + t6.text;
          print(s);
          chose = !chose;
        });
      },
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

  Center ourLogo() {
    return Center(
      child: Container(
        width: 220,
        margin: EdgeInsets.only(top: 45),
        child: Image(
          image: AssetImage("images/logo.png"),
        ),
      ),
    );
  }
}
