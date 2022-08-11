// ignore_for_file: prefer_const_constructors, must_be_immutable
//ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:fast_and_yummy/api/linkapi.dart';
import 'package:fast_and_yummy/detialscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ContDFSP extends StatelessWidget {
  dynamic product;
  dynamic storeID;
  dynamic cateID;
  ContDFSP(this.product, this.storeID, this.cateID, {Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Detialscreen(product, storeID, cateID),
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
                      fit: BoxFit.cover,
                      image: NetworkImage("$imageRoot/${product['image']}"))),
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
                            product['productName'],
                            overflow: TextOverflow.clip, // For text wraping
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          RatingBarIndicator(
                            rating: double.parse(product['rate']),
                            itemSize: 20,
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                          )
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    Text(
                      "${product['price']} \$",
                      style: TextStyle(
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
}
