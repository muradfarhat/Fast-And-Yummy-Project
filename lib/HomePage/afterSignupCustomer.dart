import 'package:fast_and_yummy/HomePage/personalInfoAfterSignup.dart';
import 'package:fast_and_yummy/api/api.dart';
import 'package:fast_and_yummy/api/linkapi.dart';
import 'package:flutter/material.dart';

class afterChooseCustomer extends StatefulWidget {
  String userID;
  afterChooseCustomer(this.userID, {Key? key}) : super(key: key);

  @override
  State<afterChooseCustomer> createState() => _afterChooseCustomerState();
}

class _afterChooseCustomerState extends State<afterChooseCustomer> {
  Color basicColor = const Color.fromARGB(255, 37, 179, 136);
  String? radioChoiceValue;
  bool success = false;
  bool ifCall = false;

  List<Map> chooseFav = [];
  List<Map> choosed = [];

  Api _api = Api(); // Create API SELECT SCOPE_IDENTITY()

  bringAllCatergorys() async {
    var response = await _api.getReq(bringAllCate);
    if (response['status'] == "suc") {
      List<dynamic> values = response['data'];
      int lengthOfValue = values.length;
      for (int i = 0; i < lengthOfValue; i++) {
        setState(() {
          chooseFav.add({
            "id": "${values[i]["cateID"]}",
            "favName": "${values[i]['cateName']}",
            "value": false
          });
        });
        ifCall = true;
        if (i == lengthOfValue) {
          break;
        }
      }
    }
  }

  chooseDirection(String cate_id, String user_id, String cate_name) async {
    var response = await _api.postReq(afterSignupChooseFavorite,
        {"cateID": cate_id, "userID": user_id, "cateName": cate_name});
    if (response['status'] == "suc") {
      success = true;
    } else {
      success = false;
    }
  }

  GlobalKey<ScaffoldState> scaffoldKey =
      new GlobalKey<ScaffoldState>(); // For snackBar

  /************************** Start Functions ******************************** */

  continueButton() {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 30),
        child: MaterialButton(
          padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
          onPressed: () async {
            if (choosed.length < 2) {
              showFaildSnackBarMSG("You must choose at least 2 choises");
            } else {
              for (int i = 0; i < choosed.length; i++) {
                await chooseDirection(
                    choosed[i]['id'], widget.userID, choosed[i]['favName']);
              }
              showSuccessSnackBarMSG();
              Navigator.of(context).push(MaterialPageRoute(builder: ((context) {
                return personalInfo(widget.userID);
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

  showFaildSnackBarMSG(String msg) {
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
          Text(
            msg,
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
    if (ifCall == false) {
      bringAllCatergorys();
    }
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
                                    element['id'] == chooseFav[index]['id']);
                              });
                            } else {
                              setState(() {
                                choosed.add(chooseFav[index]);
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
