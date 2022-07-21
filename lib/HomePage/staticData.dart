import 'package:fast_and_yummy/HomePage/onboardingModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// bool boxOneChecked = false;
// bool boxTwoChecked = false;

// Color basicColor = const Color.fromARGB(255, 37, 179, 136);

List<onboardingModel> onboardingList = [
  onboardingModel(
    title: "Choose your direction",
    //image: "images/chooseDirection.png",
    body: Container(
      child: Column(children: [
        Container(
          width: double.infinity,
          height: 250,
          margin: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
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
        )
      ]),
    ),
  ),
  onboardingModel(
    title: "Choose your favorite",
    body: Container(
      child: const Text("favorite"),
    ),
  ),
];
