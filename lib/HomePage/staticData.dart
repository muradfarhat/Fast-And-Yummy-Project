import 'package:fast_and_yummy/HomePage/onboardingModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// bool boxOneChecked = false;
// bool boxTwoChecked = false;

// Color basicColor = const Color.fromARGB(255, 37, 179, 136);

List<onboardingModel> onboardingList = [
  onboardingModel(
    title: "Choose your direction",
    image: "images/chooseDirection.png",
    body: Container(
      child: Column(children: [
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
    image: "images/burger.jpg",
    body: Container(
      child: const Text("favorite"),
    ),
  ),
];
/*
InkWell(
          onTap: () {
            boxOneChecked = true;
            boxTwoChecked = false;
          },
          child: Container(
            margin: const EdgeInsets.only(left: 75, right: 75, bottom: 40),
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                    width: 3,
                    color: boxOneChecked == true ? basicColor : Colors.black),
                image: const DecorationImage(
                    fit: BoxFit.cover, image: AssetImage("images/store.jpg"))),
          ),
        ),
        InkWell(
          onTap: () {
            boxOneChecked = false;
            boxTwoChecked = true;
          },
          child: Container(
            margin: const EdgeInsets.only(left: 75, right: 75, bottom: 40),
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                    width: 3,
                    color: boxTwoChecked == true ? basicColor : Colors.black),
                image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("images/delivery.jpg"))),
          ),
        ),
 */
