import 'package:fast_and_yummy/HomePage/homepage.dart';
import 'package:fast_and_yummy/api/api.dart';
import 'package:fast_and_yummy/api/linkapi.dart';
import 'package:fast_and_yummy/userpage/basic_user.dart';
import 'package:flutter/material.dart';

class personalInfo extends StatefulWidget {
  String userID;
  personalInfo(this.userID, {Key? key}) : super(key: key);

  @override
  State<personalInfo> createState() => _personalInfoState();
}

class _personalInfoState extends State<personalInfo> {
  Color basicColor = const Color.fromARGB(255, 37, 179, 136);

  String? city;
  String? town;
  String? street;

  List<String> address = [];

  Api _api = Api(); // Create API SELECT SCOPE_IDENTITY()

  AddPersonal() async {
    var response = await _api.postReq(personalDataAfterSignup, {
      "city": address[0],
      "town": address[1],
      "street": address[2],
      "id": widget.userID
    });
    if (response['status'] == "suc") {
      showSuccessSnackBarMSG();
      Navigator.of(context).push(MaterialPageRoute(builder: ((context) {
        return HomePage();
      })));
    }
  }

  GlobalKey<FormState> formStateForPrsonData =
      new GlobalKey<FormState>(); // For Text Filed in data Info

  /************************** Start Functions ******************************** */

  bool EditAddressData() {
    var formData = formStateForPrsonData.currentState;

    if (formData!.validate()) {
      formData.save();

      address.add(city!);
      address.add(town!);
      address.add(street!);

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
            if (EditAddressData()) {
              await AddPersonal();
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
              key: formStateForPrsonData,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 40),
                    child: const Text(
                      "Add your address information",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 250,
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                      fit: BoxFit.contain,
                      image: AssetImage("images/addPersonalData.png"),
                    )),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.only(left: 40, right: 40, bottom: 30),
                    alignment: Alignment.center,
                    child: const Text(
                      "(Optional) The last step, fill in your address",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "must not be empty";
                        } else if (value.length < 3 || value.length > 25) {
                          return "Invalid input";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        city = value;
                      },
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          label: const Text("City"),
                          labelStyle: TextStyle(color: basicColor)),
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "must not be empty";
                        } else if (value.length < 3 || value.length > 25) {
                          return "Invalid input";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        town = value;
                      },
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          label: const Text("Town"),
                          labelStyle: TextStyle(color: basicColor)),
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "must not be empty";
                        } else if (value.length < 3 || value.length > 25) {
                          return "Invalid input";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        street = value;
                      },
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          label: const Text("Street"),
                          labelStyle: TextStyle(color: basicColor)),
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
              ))),
    );
  }
}
