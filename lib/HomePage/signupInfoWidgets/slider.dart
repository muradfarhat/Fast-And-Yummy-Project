import 'package:fast_and_yummy/HomePage/staticData.dart';
import 'package:flutter/material.dart';

class slider extends StatefulWidget {
  slider({Key? key}) : super(key: key);

  @override
  State<slider> createState() => _sliderState();
}

class _sliderState extends State<slider> {
  Color basicColor = const Color.fromARGB(255, 37, 179, 136);
  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
