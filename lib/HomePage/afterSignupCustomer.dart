import 'package:fast_and_yummy/HomePage/insertCreditCard.dart';
import 'package:flutter/material.dart';

class afterChooseCustomer extends StatefulWidget {
  afterChooseCustomer({Key? key}) : super(key: key);

  @override
  State<afterChooseCustomer> createState() => _afterChooseCustomerState();
}

class _afterChooseCustomerState extends State<afterChooseCustomer> {
  Color basicColor = const Color.fromARGB(255, 37, 179, 136);
  String? radioChoiceValue;

  List<Map> chooseFav = [
    {"favName": "Sweet", "value": false},
    {"favName": "Drinks", "value": false},
    {"favName": "Traditional", "value": false}
  ];
  List<String> choosed = [];

  GlobalKey<ScaffoldState> scaffoldKey =
      new GlobalKey<ScaffoldState>(); // For snackBar

  /************************** Start Functions ******************************** */

  continueButton() {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 30),
        child: MaterialButton(
          padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
          onPressed: () {
            if (choosed.length < 2) {
              showFaildSnackBarMSG();
            } else {
              showSuccessSnackBarMSG();
              Navigator.of(context).push(MaterialPageRoute(builder: ((context) {
                return insertCreditCard();
              })));
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
            "You must choose at least 2 choices",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )
        ],
      ),
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(20),
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
          child: Column(
        children: [
          Container(
            margin:
                const EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 20),
            child: const Text(
              "Choose your favorite",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: double.infinity,
            height: 250,
            margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
            decoration: const BoxDecoration(
                image: DecorationImage(
              fit: BoxFit.contain,
              image: AssetImage("images/fav_food.png"),
            )),
          ),
          Container(
            margin: const EdgeInsets.only(left: 40, right: 40, bottom: 30),
            alignment: Alignment.center,
            child: const Text(
              "You must choose at least two of your favourites",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ),
          ...List.generate(
              chooseFav.length,
              (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    child: CheckboxListTile(
                        activeColor: basicColor,
                        title: Text("${chooseFav[index]['favName']}"),
                        value: chooseFav[index]['value'],
                        onChanged: (val) {
                          setState(() {
                            chooseFav[index]['value'] = val;
                            if (val == false && choosed.isNotEmpty) {
                              setState(() {
                                choosed.removeWhere((element) =>
                                    element == chooseFav[index]['favName']);
                              });
                            } else {
                              setState(() {
                                choosed.add(chooseFav[index]['favName']);
                              });
                            }
                          });
                        }),
                  )),
          continueButton()
        ],
      )),
    );
  }
}
