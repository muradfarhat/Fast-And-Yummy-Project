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
                            width: double.infinity,
                            height: 250,
                            margin: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 30),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              fit: BoxFit.contain,
                              image:
                                  AssetImage("${onboardingList[index].image}"),
                            )),
                          ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ...List.generate(
                          onboardingList.length,
                          (index) => AnimatedContainer(
                                margin: const EdgeInsets.only(right: 5),
                                duration: const Duration(milliseconds: 900),
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                    color: basicColor,
                                    borderRadius: BorderRadius.circular(10)),
                              ))
                    ],
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 40),
                      child: MaterialButton(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 100, vertical: 10),
                        onPressed: () {},
                        color: basicColor,
                        textColor: Colors.white,
                        child: const Text(
                          "Continue",
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ))
                ],
              ))
        ],
      ),
    );
  }
}
