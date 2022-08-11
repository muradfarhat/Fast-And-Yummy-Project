import 'package:fast_and_yummy/api/api.dart';
import 'package:fast_and_yummy/api/linkapi.dart';
import 'package:fast_and_yummy/main.dart';
import 'package:flutter/material.dart';

class disActive extends StatefulWidget {
  disActive({Key? key}) : super(key: key);

  @override
  State<disActive> createState() => _disActiveState();
}

class _disActiveState extends State<disActive> {
  Color color = const Color.fromARGB(255, 37, 179, 136);
  Api api = Api();
  setDeliveryActive(String active) async {
    var resp = await api.postReq(
        setDeliverActive, {"id": sharedPref.getString("id"), "active": active});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: color),
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            margin: const EdgeInsets.all(20),
            child: const Text(
                "Here you can disactive your account and active it later.",
                style: TextStyle(fontSize: 20, color: Colors.grey),
                textAlign: TextAlign.center),
          ),
          MaterialButton(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            onPressed: () {
              setDeliveryActive("no");
              setState(() {});
            },
            color: color,
            child: const Text(
              "Disactive My Account",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
