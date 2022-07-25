import 'package:fast_and_yummy/HomePage/afterSignupCustomer.dart';
import 'package:fast_and_yummy/HomePage/afterSignupDelivery.dart';
import 'package:fast_and_yummy/api/api.dart';
import 'package:fast_and_yummy/api/linkapi.dart';
import 'package:flutter/material.dart';

class afterSignup extends StatefulWidget {
  String userID;
  afterSignup(this.userID, {Key? key}) : super(key: key);

  @override
  State<afterSignup> createState() => _afterSignupState();
}

class _afterSignupState extends State<afterSignup> {
  Color basicColor = const Color.fromARGB(255, 37, 179, 136);
  String? radioChoiceValue;

  Api _api = Api(); // Create API SELECT SCOPE_IDENTITY()

  chooseDirection() async {
    var response = await _api.postReq(afterSignupPage,
        {"deliveryOrCustomer": radioChoiceValue, "id": widget.userID});
    if (response['status'] == "suc") {
      if (radioChoiceValue == "Delivery") {
        Navigator.of(context).push(MaterialPageRoute(builder: ((context) {
          return afterChooseDelivery();
        })));
      } else if (radioChoiceValue == "Customer") {
        Navigator.of(context).push(MaterialPageRoute(builder: ((context) {
<<<<<<< HEAD
          return afterChooseCustomer(widget.userID);
=======
          return afterChooseCustomer();
>>>>>>> parent of a40c14f (Back end)
        })));
      }
    } else {
      showFaildSnackBarMSG();
    }
  }

  GlobalKey<ScaffoldState> scaffoldKey =
      new GlobalKey<ScaffoldState>(); // For snackBar

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: basicColor,
      ),
      body: Column(
        children: [
          Expanded(
              flex: 4,
              child: Column(
                children: [
                  Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 40),
                      child: const Text(
                        "Choose your direction",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      )),
                  Container(
                    margin:
                        const EdgeInsets.only(left: 40, right: 40, bottom: 30),
                    child: Column(children: [
                      Container(
                        width: double.infinity,
                        height: 250,
                        margin: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 30),
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                          fit: BoxFit.contain,
                          image: AssetImage("images/chooseDirection.png"),
                        )),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: const Text(
                          "Choose whether you want to create a user and store account or a delivery operator account",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ]),
                  ),
                  /************************* Start radio buttons just for first page ************** */
                  radioButtons(),
                  /************************* Start radio buttons just for first page ************** */
                ],
              )),
          Expanded(
              flex: 1,
              child: Column(
                children: [
                  continueButton(),
                ],
              ))
        ],
      ),
    );
  }

  /*********************** Start Functions section ****************************** */
  continueButton() {
    return Container(
        margin: const EdgeInsets.only(top: 30),
        child: MaterialButton(
          padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
          onPressed: () async {
            if (radioChoiceValue == null) {
              showFaildSnackBarMSG();
            } else {
              await chooseDirection();
            }
            // else if (radioChoiceValue == "Delivery") {
            //   Navigator.of(context).push(MaterialPageRoute(builder: ((context) {
            //     return afterChooseDelivery();
            //   })));
            // } else if (radioChoiceValue == "Customer") {
            //   Navigator.of(context).push(MaterialPageRoute(builder: ((context) {
            //     return afterChooseCustomer();
            //   })));
            // }
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

  radioButtons() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 120),
          child: Row(
            children: [
              Radio(
                  autofocus: radioChoiceValue == "Customer" ? true : false,
                  activeColor: basicColor,
                  value: "Customer",
                  groupValue: radioChoiceValue,
                  onChanged: (val) {
                    setState(() {
                      radioChoiceValue = val as String?;
                    });
                  }),
              TextButton(
                onPressed: () {
                  setState(() {
                    radioChoiceValue = "Customer";
                  });
                },
                child: const Text("Customer",
                    style: TextStyle(color: Colors.grey)),
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 120),
          child: Row(
            children: [
              Radio(
                  autofocus: radioChoiceValue == "Delivery" ? true : false,
                  activeColor: basicColor,
                  value: "Delivery",
                  groupValue: radioChoiceValue,
                  onChanged: (val) {
                    setState(() {
                      radioChoiceValue = val as String?;
                    });
                  }),
              TextButton(
                onPressed: () {
                  setState(() {
                    radioChoiceValue = "Delivery";
                  });
                },
                child: const Text("Delivery",
                    style: TextStyle(color: Colors.grey)),
              )
            ],
          ),
        ),
      ],
    );
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
            "You must choose",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )
        ],
      ),
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(20),
    ));
  }
  /*********************** End Functions section ****************************** */
}
