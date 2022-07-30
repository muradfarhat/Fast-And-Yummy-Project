import 'package:flutter/material.dart';

class aboutPage extends StatelessWidget {
  const aboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color basicColor = const Color.fromARGB(255, 37, 179, 136);
    String MSG =
        "Fast & Yummy is an application created with the aim of facilitating the process of buying foods from different stores and having them delivered in the shortest possible time.\nThe application also allows users to open their own stores that sell or deliver food through the application, as the application provides delivery service and order tracking.\nThe work is done through the application based on a subscription to the application, as the subscription is through a profit percentage that goes to the application on each sale or delivery, as every sale made through the store goes to the application with a profit rate of 10% of the process and every order that is delivered goes to the application from it 5% profit rate.";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: basicColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 150,
              margin: const EdgeInsets.symmetric(horizontal: 80, vertical: 20),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.contain,
                      image: AssetImage("images/logo.png"))),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                MSG,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
