import 'package:fast_and_yummy/HomePage/homepage.dart';
import 'package:fast_and_yummy/api/api.dart';
import 'package:fast_and_yummy/api/linkapi.dart';
import 'package:fast_and_yummy/deliverySection/profilePage.dart';
import 'package:fast_and_yummy/main.dart';
import 'package:flutter/material.dart';

class homePageDelivery extends StatefulWidget {
  homePageDelivery({Key? key}) : super(key: key);

  @override
  State<homePageDelivery> createState() => _homePageDeliveryState();
}

class _homePageDeliveryState extends State<homePageDelivery> {
  dynamic lis;
  bool loading = false;
  Api api = Api();
  getDeliveryData() async {
    setState(() {
      loading = true;
    });
    var resp = await api
        .postReq(getInfoLinkDelivery, {"id": sharedPref.getString("id")});
    if (resp['status'] == "suc") {
      setState(() {
        lis = resp['data'];
        loading = false;
      });
    } else {}
  }

  @override
  void initState() {
    getDeliveryData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: Drawer(
        child: loading
            ? SizedBox(
                height: size.height,
                width: size.width,
                child: Center(
                  child: CircularProgressIndicator(
                      color: Color.fromARGB(255, 37, 179, 136)),
                ),
              )
            : Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  UserAccountsDrawerHeader(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 37, 179, 136),
                      ),
                      currentAccountPicture: CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: lis?['image'] == ""
                            ? NetworkImage(
                                "https://i.stack.imgur.com/l60Hf.png")
                            : NetworkImage("$imageRoot/${lis?['image']}"),
                      ),
                      accountName:
                          Text(lis?['first_name'] + " " + lis?['last_name']),
                      accountEmail: Text(lis?['email'])),
                  InkWell(
                      onTap: () {
                        sharedPref.clear();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      },
                      child: listTileDesgin(
                        "Logout",
                        Icons.exit_to_app,
                      )),
                ],
              ),
      ),
      appBar: AppBar(
        //toolbarHeight: 0,
        backgroundColor: Color.fromARGB(255, 37, 179, 136),
      ),
      body: deliveryProfile(),
    );
  }

  ListTile listTileDesgin(String name, IconData ic) {
    return ListTile(
      title: Text(name),
      leading: Icon(
        ic,
        color: Color.fromARGB(255, 37, 179, 136),
      ),
    );
  }
}