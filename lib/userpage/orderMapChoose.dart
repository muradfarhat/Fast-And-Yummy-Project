import 'package:fast_and_yummy/api/api.dart';
import 'package:fast_and_yummy/api/linkapi.dart';
import 'package:fast_and_yummy/main.dart';
import 'package:fast_and_yummy/userpage/oneOrader.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ChooseLocation extends StatefulWidget {
  dynamic list1;
  dynamic list2;
  ChooseLocation(this.list1, this.list2, {Key? key}) : super(key: key);

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  Color basicColor = const Color.fromARGB(255, 37, 179, 136);
  Position? currentLocation;
  LatLng? newLocation;
  CameraPosition? _kGooglePlex;
  GoogleMapController? gmc;
  Map userInfo = {};

  Set<Marker> myMark = {};

  setMark() {
    myMark.add(
      Marker(
          markerId: const MarkerId("Location"),
          infoWindow: const InfoWindow(title: "Your Location"),
          position: LatLng(
              userInfo.length == 0
                  ? currentLocation!.latitude
                  : double.parse(userInfo["latitude"]),
              userInfo.length == 0
                  ? currentLocation!.longitude
                  : double.parse(userInfo["longitude"]))),
    );
  }

  Future getPosition() async {
    bool services;
    LocationPermission per;
    services = await Geolocator.isLocationServiceEnabled();
    if (services == false) {
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text("Open GBS"),
            );
          });
    }
    per = await Geolocator.checkPermission();
    if (per == LocationPermission.denied) {
      per = await Geolocator.requestPermission();
    }
    return per;
  }

  final Api _api = Api();
  Future<void> getLatAndLong() async {
    Position cl = await Geolocator.getCurrentPosition().then((value) => value);
    _kGooglePlex = CameraPosition(
      target: LatLng(cl.latitude, cl.longitude),
      zoom: 14.4746,
    );
    setState(() {
      currentLocation = cl;
    });

    //return cl;
  }

  getLocationFromDataBase() async {
    var response =
        await _api.postReq(getInfoLink, {"id": sharedPref.getString("id")});
    if (response['status'] == "suc") {
      setState(() {
        userInfo = response['data'];
      });
      setMark();
    }
  } //getInfoLink

  @override
  void initState() {
    getLocationFromDataBase();
    getPosition();
    getLatAndLong();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: basicColor),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: 70,
            child: const Text(
                "Set Your Location.\nPut the red mark in your location",
                style: const TextStyle(fontSize: 18, color: Colors.grey),
                textAlign: TextAlign.center),
          ),
          _kGooglePlex == null
              ? const CircularProgressIndicator()
              : Container(
                  width: double.infinity,
                  height: 500,
                  child: GoogleMap(
                    onTap: (LatLng t) {
                      setState(() {
                        myMark.remove(
                            const Marker(markerId: MarkerId("Location")));
                        myMark.add(Marker(
                            markerId: const MarkerId("Location"),
                            infoWindow:
                                const InfoWindow(title: "Your Location"),
                            position: t));
                        newLocation = t;
                      });
                    },
                    markers: myMark,
                    myLocationEnabled: true,
                    mapType: MapType.normal,
                    initialCameraPosition: _kGooglePlex!,
                    onMapCreated: (GoogleMapController controller) {
                      gmc = controller;
                    },
                  ),
                ),
          const SizedBox(
            width: double.infinity,
            height: 20,
          ),
          MaterialButton(
            color: basicColor,
            onPressed: () async {
              if (newLocation == null) {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: ((context) {
                  return OneOrder(
                      widget.list1,
                      widget.list2,
                      double.parse(userInfo['latitude']),
                      double.parse(userInfo['longitude']),
                      userInfo['cityLocation']);
                })));
              } else {
                List<Placemark> placemarks = await placemarkFromCoordinates(
                    newLocation!.latitude, newLocation!.longitude);
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: ((context) {
                  return OneOrder(
                      widget.list1,
                      widget.list2,
                      newLocation!.latitude,
                      newLocation!.longitude,
                      placemarks[0].locality);
                })));
              }
            },
            child: const Text(
              "Set Order Location",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      )),
    );
  }
}
