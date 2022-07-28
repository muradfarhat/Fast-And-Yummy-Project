import 'package:fast_and_yummy/HomePage/insertCreditCard.dart';
import 'package:fast_and_yummy/api/api.dart';
import 'package:fast_and_yummy/api/linkapi.dart';
import 'package:flutter/material.dart';

class afterChooseDelivery extends StatefulWidget {
  String userID;
  afterChooseDelivery(this.userID, {Key? key}) : super(key: key);

  @override
  State<afterChooseDelivery> createState() => _afterChooseDeliveryState();
}

class _afterChooseDeliveryState extends State<afterChooseDelivery> {
  Color basicColor = const Color.fromARGB(255, 37, 179, 136);
  String? carModel;
  String? carNumber;
  String? idNumber;
  String? driverCity;

  List<String> data = [];

  GlobalKey<ScaffoldState> scaffoldKey =
      new GlobalKey<ScaffoldState>(); // For snackBar

  Api _api = Api(); // Create API SELECT SCOPE_IDENTITY()

  AddDeliveryPersonal() async {
    var response = await _api.postReq(deliveryPersonalDataAfterSignup, {
      "city": data[3],
      "carModel": data[1],
      "carNumber": data[0],
      "deliveryID": data[2],
      "id": widget.userID
    });
    print(response['status']);
    if (response['status'] == "suc") {
      showSuccessSnackBarMSG();
      Navigator.of(context).push(MaterialPageRoute(builder: ((context) {
        return insertCreditCard(widget.userID);
      })));
    }
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formStateForData =
        new GlobalKey<FormState>(); // For Text Filed in data Info

    /*********************** Start Functions section ****************************** */
    bool EditData() {
      var formData = formStateForData.currentState;

      if (formData!.validate()) {
        formData.save();

        data.add(carNumber!);
        data.add(carModel!);
        data.add(idNumber!);
        data.add(driverCity!);

        return true;
      } else {
        return false;
      }
    }

    continueButton() {
      return Container(
          margin: const EdgeInsets.symmetric(vertical: 30),
          child: MaterialButton(
            padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
            onPressed: () async {
              if (EditData()) {
                await AddDeliveryPersonal();
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
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "The must not be empty";
                    } else if (value.length < 3 || value.length > 25) {
                      return "Invalid input";
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    driverCity = value;
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      label: const Text("Your City"),
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
