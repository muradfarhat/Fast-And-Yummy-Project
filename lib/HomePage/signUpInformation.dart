import 'package:fast_and_yummy/HomePage/signupInfoWidgets/continueButton.dart';
import 'package:fast_and_yummy/HomePage/signupInfoWidgets/slider.dart';
import 'package:fast_and_yummy/HomePage/staticData.dart';
import 'package:flutter/material.dart';

class afterSignup extends StatefulWidget {
  afterSignup({Key? key}) : super(key: key);

  @override
  State<afterSignup> createState() => _afterSignupState();
}

class _afterSignupState extends State<afterSignup> {
  Color basicColor = const Color.fromARGB(255, 37, 179, 136);

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
              flex: 3,
              child: PageView.builder(
                  itemCount: onboardingList.length,
                  itemBuilder: ((context, index) => Column(
                        children: [
                          Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 40),
                              child: Text(
                                "${onboardingList[index].title}",
                                style: const TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              )),
                          Container(
                            margin: const EdgeInsets.only(
                                left: 40, right: 40, bottom: 30),
                            child: onboardingList[index].body,
                          ),
                        ],
                      )))),
          Expanded(
              flex: 1,
              child: Column(
                children: [
                  slider(),
                  continueButton(),
                ],
              ))
        ],
      ),
    );
  }
}
