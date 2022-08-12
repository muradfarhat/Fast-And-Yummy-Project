// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:fast_and_yummy/store_product.dart';
import 'package:flutter/material.dart';

import 'api/api.dart';
import 'api/linkapi.dart';

class Stores extends StatefulWidget {
  const Stores({Key? key}) : super(key: key);

  @override
  State<Stores> createState() => _StoresState();
}

class _StoresState extends State<Stores> {
  TextEditingController searchValue =
      TextEditingController(); // variable to store text field value in it
  int selectedNavBarItem = 2;
  bool showAppBar = true;
  Color color = Colors.black;
  List<Map> stores = [
    {
      "image": "images/90.jpg",
      "store": "90-s Burgar",
      "product": "19 Product",
      "feedback": "58 Feed Back",
      "fav": false,
      "icon": Icon(Icons.favorite_border_outlined),
    },
    {
      "image": "images/kfc.png",
      "store": "KFC",
      "product": "22 Product",
      "feedback": "130 Feed Back",
      "fav": false,
      "icon": Icon(Icons.favorite_border_outlined),
    },
    {
      "image": "images/macdonald.png",
      "store": "Macdonald",
      "product": "29 Product",
      "feedback": "105 Feed Back",
      "fav": false,
      "icon": Icon(Icons.favorite_border_outlined),
    },
    {
      "image": "images/Starbucks.jpg",
      "store": "Starbucks",
      "product": "15 Product",
      "feedback": "97 Feed Back",
      "fav": false,
      "icon": Icon(Icons.favorite_border_outlined),
    }
  ];

  List storesDisplay = [];
  void updateList(String value) {
    setState(() {
      storesDisplay = allStores
          .where((element) =>
              element['storeName'].toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  bool loading = false;
  List<dynamic> allStores = [];
  Api api = Api();
  bringAllStores() async {
    setState(() {
      loading = true;
    });
    var respo = await api.postReq(storesLink, {});

    if (respo['status'] == "suc") {
      allStores = respo['data'];
      storesDisplay = List.from(allStores);
      setState(() {
        loading = false;
      });
    } else {}
  }

  @override
  void initState() {
    bringAllStores();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: appBarDesign(),
      body: loading
          ? SizedBox(
              height: size.height,
              width: size.width,
              child: Center(
                child: CircularProgressIndicator(color: color),
              ),
            )
          : ListView.builder(
              itemCount: storesDisplay.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, i) {
                return MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StoreProduct(storesDisplay[i]),
                      ),
                    ).then((value) {
                      bringAllStores();
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.all(10),
                    width: size.width,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromARGB(255, 179, 179, 179),
                            blurRadius: 4)
                      ],
                      color: Color.fromARGB(255, 240, 240, 240),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 37, 179, 136),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15)),
                          ),
                          child: Stack(
                            children: [
                              Container(
                                height: 200,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15)),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            "$imageRoot/${storesDisplay[i]['storeImage']}"),
                                        fit: BoxFit.cover)),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${storesDisplay[i]['storeName']}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${storesDisplay[i]['numberOfProducts']} Products",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                "${storesDisplay[i]['feedBack']} Feed Back",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
    );
  }

  Icon iconDesign(int i) {
    return Icon(
      i == 1 ? Icons.star : Icons.star_border_outlined,
      size: 25,
      color: Colors.amberAccent,
    );
  }

  appBarDesign() {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back),
      ),
      toolbarHeight: 65,
      title: TextFormField(
        onChanged: (value) {
          updateList(value);
        },

        controller:
            searchValue, // take text value and store it in searchValue variable
        textInputAction: TextInputAction.go,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 1),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey,
          ),
          filled: true,
          fillColor: Color.fromARGB(255, 231, 231, 231),
          hintText: "Search",
          focusedBorder: outLDesign(),
          enabledBorder: outLDesign(),
          disabledBorder: outLDesign(),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 37, 179, 136),
      elevation: 0,
    );
  }

  OutlineInputBorder outLDesign() {
    return OutlineInputBorder(
        gapPadding: 10,
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Colors.white, width: 1));
  }
}
