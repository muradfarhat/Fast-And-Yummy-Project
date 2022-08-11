import 'dart:async';

import 'package:fast_and_yummy/HomePage/homepage.dart';
import 'package:fast_and_yummy/api/api.dart';
import 'package:fast_and_yummy/api/linkapi.dart';
import 'package:fast_and_yummy/deliverySection/deliveredOrders.dart';
import 'package:fast_and_yummy/deliverySection/disactiveAccount.dart';
import 'package:fast_and_yummy/deliverySection/mapAfterSignUp.dart';
import 'package:fast_and_yummy/deliverySection/orderMap.dart';
import 'package:fast_and_yummy/deliverySection/readyOrders.dart';
import 'package:fast_and_yummy/deliverySection/test.dart';
import 'package:fast_and_yummy/main.dart';
import 'package:fast_and_yummy/userpage/AboutPgae.dart';
import 'package:fast_and_yummy/userpage/profile.dart';
import 'package:fast_and_yummy/userpage/supportPage.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class homePageDelivery extends StatefulWidget {
  homePageDelivery({Key? key}) : super(key: key);

  @override
  State<homePageDelivery> createState() => _homePageDeliveryState();
}

class _homePageDeliveryState extends State<homePageDelivery> {
  Color color = const Color.fromARGB(255, 37, 179, 136);
  int selected = 1;
  List<Widget> pagesContent = [
    const Profile("delivery"),
    readyOrder(),
    doneOrders()
  ];
  dynamic lis;
  bool loading = false;
  bool notAactive = true;
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

  setDeliveryLocation(String lat, String lng) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(double.parse(lat), double.parse(lng));
    var resp = await api.postReq(userMapSetLocation, {
      "id": sharedPref.getString("id"),
      "lat": lat,
      "lng": lng,
      "cityL": placemarks[0].locality
    });
  }

  getDeliveryActive() async {
    var resp =
        await api.postReq(getDeliverActive, {"id": sharedPref.getString("id")});
    if (resp['status'] == "suc") {
      if (resp['data'] == "yes") {
        notAactive = false;
      } else {
        notAactive = true;
      }
    }
  }

  setDeliveryActive(String active) async {
    var resp = await api.postReq(
        setDeliverActive, {"id": sharedPref.getString("id"), "active": active});
    if (resp['status'] == "suc") {
      getDeliveryActive();
    }
  }

  @override
  void initState() {
    getDeliveryActive();
    getDeliveryData();
    final LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    StreamSubscription<Position> positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position? position) {
      setDeliveryLocation(
          position!.latitude.toString(), position.longitude.toString());
      print("Save Location");
      print(position == null
          ? 'Unknown'
          : '${position.latitude.toString()}, ${position.longitude.toString()}');
    });
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
                child: const Center(
                  child: CircularProgressIndicator(
                      color: Color.fromARGB(255, 37, 179, 136)),
                ),
              )
            : Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  UserAccountsDrawerHeader(
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 37, 179, 136),
                      ),
                      currentAccountPicture: CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: lis?['image'] == ""
                            ? const NetworkImage(
                                "https://i.stack.imgur.com/l60Hf.png")
                            : NetworkImage("$imageRoot/${lis?['image']}"),
                      ),
                      accountName:
                          Text(lis?['first_name'] + " " + lis?['last_name']),
                      accountEmail: Text(lis?['email'])),
                  Visibility(
                    visible: !notAactive,
                    child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => disActive()));
                        },
                        child: listTileDesgin(
                          "Disactive Account",
                          Icons.stop,
                        )),
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => support()));
                      },
                      child: listTileDesgin(
                        "Support",
                        Icons.support,
                      )),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => aboutPage()));
                      },
                      child: listTileDesgin(
                        "About",
                        Icons.info,
                      )),
                  InkWell(
                      onTap: () {
                        sharedPref.clear();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()),
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
        backgroundColor: const Color.fromARGB(255, 37, 179, 136),
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            setState(() {
              selected = value;
            });
          },
          currentIndex: selected,
          type: BottomNavigationBarType.fixed,
          selectedIconTheme: const IconThemeData(
              color: Color.fromARGB(255, 37, 179, 136), size: 45),
          selectedItemColor: const Color.fromARGB(255, 37, 179, 136),
          unselectedItemColor: const Color.fromARGB(255, 157, 157, 157),
          iconSize: 30,
          items: [
            bottomNavDesign("Profile", Icons.person),
            bottomNavDesign("Ready Orders", Icons.map_outlined),
            bottomNavDesign("Deliverd Orders", Icons.done),
          ]),
      body: notAactive
          ? Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  margin: const EdgeInsets.all(20),
                  child: const Text("Your account disactive.",
                      style: TextStyle(fontSize: 20, color: Colors.grey)),
                ),
                MaterialButton(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  onPressed: () {
                    setDeliveryActive("yes");
                    setState(() {});
                  },
                  color: color,
                  child: const Text(
                    "Active My Account",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )
          : pagesContent.elementAt(selected), //deliveryProfile(),
    );
  }

  ListTile listTileDesgin(String name, IconData ic) {
    return ListTile(
      title: Text(name),
      leading: Icon(
        ic,
        color: const Color.fromARGB(255, 37, 179, 136),
      ),
    );
  }

  BottomNavigationBarItem bottomNavDesign(String name, IconData ic) {
    return BottomNavigationBarItem(
        icon: Icon(
          ic,
        ),
        label: name);
  }
}
