import 'package:flutter/material.dart';

class continueButton extends StatefulWidget {
  continueButton({Key? key}) : super(key: key);

  @override
  State<continueButton> createState() => _continueButtonState();
}

class _continueButtonState extends State<continueButton> {
  Color basicColor = const Color.fromARGB(255, 37, 179, 136);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 40),
        child: MaterialButton(
          padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
          onPressed: () {},
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
}
