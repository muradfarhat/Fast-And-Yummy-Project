// ignore_for_file: prefer_const_constructors, must_be_immutable, no_logic_in_create_state
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import 'api/linkapi.dart';

double count = 1.00;
double price = 8.99;
double total = price * count;

class Detialscreen extends StatefulWidget {
  dynamic list;
  bool flag = false;
  dynamic storeID;
  Detialscreen(this.list, this.storeID, {Key? key}) : super(key: key);

  @override
  State<Detialscreen> createState() => _DetialscreenState();
}

class _DetialscreenState extends State<Detialscreen> {
  bool comment = false;
  List<Map> feedback = [
    {"name": "Murad Farhat", "comment": "Good Pizza"},
    {"name": "Ra'ed Khwayreh", "comment": "Nice one"},
    {"name": "Murad Farhat", "comment": "Good Pizza"},
    {"name": "Ra'ed Khwayreh", "comment": "Nice one"},
    {"name": "Murad Farhat", "comment": "Good Pizza"},
    {"name": "Ra'ed Khwayreh", "comment": "Nice one"},
  ];
  @override
  void initState() {
    print(widget.storeID);
    if (!widget.flag) {
      setState(() {
        var arr = widget.list['content'].split(",");
        for (int i = 0; i < arr.length; i++) {
          content.add(arr[i]);
        }
        widget.flag = true;
      });
    }
    super.initState();
  }

  List content = [];
  bool visable = true;
  Icon icone = Icon(Icons.favorite_border_outlined);
  bool love = false;
  Color color = Color.fromARGB(255, 37, 179, 136);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: color,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                      //color: Colors.black.withOpacity(0.5),
                      image: DecorationImage(
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.5), BlendMode.darken),
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              "$imageRoot/${widget.list['image']}"))),
                  child: Text(
                    "${widget.list['productName']}",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 35),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: 10, top: 150, right: 10, bottom: 10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 5),
                              child: Text(
                                "${widget.list['rate']}",
                                // ignore: prefer_const_constructors
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.yellow[600],
                            )
                          ],
                        ),
                      ]),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(
                left: 10,
                right: 10,
                top: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text(
                            "Description",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          trailing: Icon(
                            Icons.description_outlined,
                            color: color,
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
                            child: Text(widget.list['description']))
                      ],
                    ),
                  ),
                  Card(
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: Text(
                              "Content",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            trailing: Icon(
                              Icons.content_paste,
                              color: color,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
                            child: Wrap(
                              children: listGenerate(),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Card(
                    // ignore: prefer_const_literals_to_create_immutables
                    child: Column(children: [
                      ListTile(
                        title: Text(
                          "Feedback",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Row(
                          children: [],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 150,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: ListView.builder(
                            itemCount: feedback.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                  title: Text("${feedback[index]["name"]}"),
                                  subtitle:
                                      Text("${feedback[index]["comment"]}"),
                                  leading: Container(
                                    padding: EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: color),
                                    child: Text("${index + 1}",
                                        style: TextStyle(
                                          color: Colors.white,
                                        )),
                                  ));
                            }),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 0, 15, 20),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  comment = !comment;
                                });
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.comment,
                                    color: color,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Visibility(
                                    visible: !comment,
                                    child: Text("Add comment",
                                        style: TextStyle(
                                            color: color,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Visibility(
                              visible: comment,
                              child: Flexible(
                                child: TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  cursorColor:
                                      Color.fromARGB(255, 21, 157, 117),
                                  decoration: InputDecoration(
                                    hintText: "Add comment",
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 21, 157, 117)),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 21, 157, 117)),
                                    ),
                                    fillColor: Colors.black,
                                    hintStyle: TextStyle(
                                      fontFamily: "Prompt2",
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: comment,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: Icon(
                                      Icons.send,
                                      color: color,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ]),
                  ),
                  Card(
                    child: Container(
                      padding: EdgeInsets.all(18),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Request Details",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Center(
                            child: Container(
                              width: 130,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        count++;
                                        total = price * count;
                                      });
                                    },
                                    icon: Icon(Icons.add),
                                  ),
                                  Text(
                                    "$count",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        count--;
                                        total = price * count;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.remove,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 2,
        child: Container(
          padding: EdgeInsets.all(20),
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total: $total",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  primary: Colors.amber,
                ),
                onPressed: () {},
                icon: Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.black,
                ),
                label: Text(
                  "Order Now",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  listGenerate() {
    return List.generate(content.length, (index) {
      return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Color.fromARGB(255, 197, 197, 197), blurRadius: 4)
            ],
            borderRadius: BorderRadius.circular(30),
          ),
          padding: EdgeInsets.symmetric(horizontal: 10),
          margin: EdgeInsets.only(left: 5, bottom: 15, right: 5),
          alignment: Alignment.center,
          width: 150,
          height: 40,
          child: Row(
            children: [
              Expanded(child: Icon(Icons.local_pizza)),
              Expanded(
                flex: 3,
                child: Text(
                  "${content[index]}", // ${favorite[index]['name']}
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 17),
                ),
              ),
            ],
          ));
    });
  }

  Icon iconDesign(int i) {
    return Icon(
      i == 1 ? Icons.star : Icons.star_border_outlined,
      size: 28,
      color: Colors.amberAccent,
    );
  }
}
