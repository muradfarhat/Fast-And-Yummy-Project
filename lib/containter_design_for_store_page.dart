// ignore_for_file: prefer_const_constructors, must_be_immutable
//ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:fast_and_yummy/detialscreen.dart';
import 'package:flutter/material.dart';

class ContDFSP extends StatelessWidget {
  late String imags;
  late String name;
  late String price;
  ContDFSP(this.imags, this.name, this.price, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Detialscreen(""),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: EdgeInsets.all(5),
        width: size.width,
        height: 120,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Color.fromARGB(255, 197, 197, 197), blurRadius: 4)
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Container(
              width: 120,
              height: 110,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                      fit: BoxFit.cover, image: NetworkImage(imags))),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            name,
                            overflow: TextOverflow.clip, // For text wraping
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              iconDesign(1),
                              iconDesign(1),
                              iconDesign(1),
                              iconDesign(0),
                              iconDesign(0),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    Text(
                      "$price\$",
                      style: TextStyle(
                        color: Color.fromARGB(255, 37, 179, 136),
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Icon iconDesign(int i) {
    return Icon(
      i == 1 ? Icons.star : Icons.star_border_outlined,
      size: 18,
      color: Colors.amberAccent,
    );
  }
}
