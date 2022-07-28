import 'package:fast_and_yummy/HomePage/homepage.dart';
import 'package:fast_and_yummy/api/api.dart';
import 'package:fast_and_yummy/api/linkapi.dart';
import 'package:flutter/material.dart';

class insertCreditCard extends StatefulWidget {
  String userID;
  insertCreditCard(this.userID, {Key? key}) : super(key: key);

  @override
  State<insertCreditCard> createState() => _insertCreditCardState();
}

class _insertCreditCardState extends State<insertCreditCard> {
  Color basicColor = const Color.fromARGB(255, 37, 179, 136);

  String? cardName;
  String? cardNum;
  String? date;
  String? cvv;

  List<String> cardDataInfo = [];

  Api _api = Api(); // Create API SELECT SCOPE_IDENTITY()

  AddCreditCard() async {
    var response = await _api.postReq(insertCreditCardInfo, {
      "visaName": cardDataInfo[0],
      "visaNumber": cardDataInfo[1],
      "visaDate": cardDataInfo[2],
      "CVV": cardDataInfo[3],
      "id": widget.userID
    });
    if (response['status'] == "suc") {
      showSuccessSnackBarMSG();
      Navigator.of(context).push(MaterialPageRoute(builder: ((context) {
        return HomePage();
      })));
    }
  }

  GlobalKey<FormState> formStateForCardData =
      new GlobalKey<FormState>(); // For Text Filed in data Info

/************************** Start Functions ******************************** */

  bool EditData() {
    var formData = formStateForCardData.currentState;

    if (formData!.validate()) {
      formData.save();

      cardDataInfo.add(cardName!);
      cardDataInfo.add(cardNum!);
      cardDataInfo.add(date!);
      cardDataInfo.add(cvv!);

      return true;
    } else {
      return false;
    }
  }

  continueButton() {
    return Container(
        margin: const EdgeInsets.only(top: 30),
        child: MaterialButton(
          padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
          onPressed: () async {
            if (EditData()) {
              await AddCreditCard();
            }
          },
          color: basicColor,
          textColor: Colors.white,
          child: const Text(
            "Continue",
            style: TextStyle(
              fontSize: 17,
            ),
          ),
        ));
  }

  showSuccessSnackBarMSG() {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: const Color.fromARGB(255, 37, 179, 136).withOpacity(0.7),
      content: Row(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Container(
            margin: const EdgeInsets.only(right: 15),
            child: const Icon(
              Icons.check_circle_rounded,
              color: Colors.white,
              size: 35,
            ),
          ),
          const Text(
            "Saved",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )
        ],
      ),
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(20),
    ));
  }

/************************** End Functions ******************************** */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: basicColor,
      ),
      body: SingleChildScrollView(
          child: Form(
        key: formStateForCardData,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 40),
              child: const Text(
                "Add your credit card inforamtion",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              width: double.infinity,
              height: 250,
              margin: const EdgeInsets.only(left: 20, right: 20),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage("images/addCardImage.png"),
              )),
            ),
            Container(
              margin: const EdgeInsets.only(left: 40, right: 40, bottom: 30),
              alignment: Alignment.center,
              child: const Text(
                "(Optional) You can add it through your profile page later",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "This Filed must not be empty";
                  } else if (value.length < 5 || value.length > 25) {
                    return "Invalid Input";
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  cardName = value;
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    label: const Text("Credit Card Name"),
                    labelStyle: TextStyle(color: basicColor)),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "This Filed must not be empty";
                  } else if (value.length < 16) {
                    return "This Filed must be 16 number";
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  cardNum = value;
                },
                keyboardType: TextInputType.number,
                maxLength: 16,
                decoration: InputDecoration(
                    label: const Text("Credit Card Number"),
                    labelStyle: TextStyle(color: basicColor)),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Empty Filed";
                        } else if (value.length < 5) {
                          return "Invalid Date";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        date = value;
                      },
                      keyboardType: TextInputType.number,
                      maxLength: 5,
                      decoration: InputDecoration(
                          label: const Text("Exp. Date"),
                          labelStyle: TextStyle(color: basicColor)),
                    ),
                  )),
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Empty Filed";
                        } else if (value.length < 3) {
                          return "Invalid cvv number";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        cvv = value;
                      },
                      keyboardType: TextInputType.number,
                      maxLength: 3,
                      decoration: InputDecoration(
                          label: const Text("CVV"),
                          labelStyle: TextStyle(color: basicColor)),
                    ),
                  ))
                ],
              ),
            ),
            continueButton(),
            Container(
                margin: const EdgeInsets.only(bottom: 30),
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: ((context) {
                        return HomePage();
                      })));
                    },
                    child: Text("Skip",
                        style: TextStyle(
                          color: basicColor,
                          fontSize: 17,
                        )))),
          ],
        ),
      )),
    );
  }
}
