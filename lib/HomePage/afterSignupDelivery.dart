import 'package:flutter/material.dart';

class afterChooseDelivery extends StatefulWidget {
  afterChooseDelivery({Key? key}) : super(key: key);

  @override
  State<afterChooseDelivery> createState() => _afterChooseDeliveryState();
}

class _afterChooseDeliveryState extends State<afterChooseDelivery> {
  Color basicColor = const Color.fromARGB(255, 37, 179, 136);
  String? carModel;
  String? carNumber;
  String? idNumber;

  GlobalKey<ScaffoldState> scaffoldKey =
      new GlobalKey<ScaffoldState>(); // For snackBar

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formStateForData =
        new GlobalKey<FormState>(); // For Text Filed in data Info

    List<Map> data = [
      {"carNum": "12345678", "carModel": "Fiat", "idNum": "123456789"}
    ];

    /*********************** Start Functions section ****************************** */
    bool EditData() {
      var formData = formStateForData.currentState;

      if (formData!.validate()) {
        formData.save();

        data[0]['carNum'] = carNumber;
        data[0]['carModel'] = carModel;
        data[0]['idNum'] = idNumber;

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
            onPressed: () {
              if (EditData()) {
                showSuccessSnackBarMSG();
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

    /*********************** End Functions section ****************************** */

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: basicColor,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formStateForData,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 40),
                child: const Text(
                  "Fill your data",
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
                  image: AssetImage("images/deliveryImage.png"),
                )),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "The must not be empty";
                    } else if (value.length < 3 || value.length > 15) {
                      return "Invalid input";
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    carModel = value;
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      label: const Text("Your car model"),
                      labelStyle: TextStyle(color: basicColor)),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "The must not be empty";
                    } else if (value.length < 7 || value.length > 10) {
                      return "Invalid input";
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    carNumber = value;
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      label: const Text("Your car number"),
                      labelStyle: TextStyle(color: basicColor)),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "The must not be empty";
                    } else if (value.length != 9) {
                      return "Invalid input";
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    idNumber = value;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      label: const Text("Your ID number"),
                      labelStyle: TextStyle(color: basicColor)),
                ),
              ),
              continueButton(),
            ],
          ),
        ),
      ),
    );
  }

/*********************** Start Functions section ****************************** */
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
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          )
        ],
      ),
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(20),
    ));
  }
  /*********************** End Functions section ****************************** */
}
