// ignore_for_file: prefer_const_constructors

import 'package:fast_and_yummy/HomePage/homepage.dart';
import 'package:fast_and_yummy/api/api.dart';
import 'package:fast_and_yummy/api/linkapi.dart';
import 'package:fast_and_yummy/main.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class mapAfterSignup extends StatefulWidget {
  mapAfterSignup({Key? key}) : super(key: key);

  @override
  State<mapAfterSignup> createState() => _mapAfterSignupState();
}

class _mapAfterSignupState extends State<mapAfterSignup> {
  Color basicColor = const Color.fromARGB(255, 37, 179, 136);
  Position? currentLocation;
  LatLng? newLocation;
  CameraPosition? _kGooglePlex;
  Api _api = Api();

  Set<Marker> myMark = {};

  setMark() {
    myMark.add(
      Marker(
          markerId: MarkerId("Location"),
          infoWindow: InfoWindow(title: "Your Location"),
          position:
              LatLng(currentLocation!.latitude, currentLocation!.longitude)),
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

  Future<void> getLatAndLong() async {
    Position cl = await Geolocator.getCurrentPosition().then((value) => value);
    _kGooglePlex = CameraPosition(
      target: LatLng(cl.latitude, cl.longitude),
      zoom: 14.4746,
    );
    setState(() {
      currentLocation = cl;
    });
    setMark();
    //return cl;
  }

  saveLocation(double lat, double lng, String? cityL) async {
    var response = await _api.postReq(userMapSetLocation, {
      "id": sharedPref.getString("id"),
      "lat": lat,
      "lng": lng,
      "cityL": cityL
    });
    if (response['status'] == "suc") {
      Navigator.of(context).push(MaterialPageRoute(builder: ((context) {
        return HomePage();
      })));
    }
  }

  @override
  void initState() {
    getPosition();
    getLatAndLong();
    super.initState();
  }

  GoogleMapController? gmc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: basicColor,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: 70,
            child: Text("Set Your Location.\nPut the red mark in your location",
                style: TextStyle(fontSize: 18, color: Colors.grey),
                textAlign: TextAlign.center),
          ),
          _kGooglePlex == null
              ? CircularProgressIndicator()
              : Container(
                  width: double.infinity,
                  height: 500,
                  child: GoogleMap(
                    onTap: (LatLng t) {
                      setState(() {
                        myMark.remove(Marker(markerId: MarkerId("Location")));
                        myMark.add(Marker(
                            markerId: MarkerId("Location"),
                            infoWindow: InfoWindow(title: "Your Location"),
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
          SizedBox(
            width: double.infinity,
            height: 20,
          ),
          MaterialButton(
            color: basicColor,
            onPressed: () async {
              if (newLocation == null) {
                List<Placemark> placemarks = await placemarkFromCoordinates(
                    currentLocation!.latitude, currentLocation!.longitude);
                await saveLocation(currentLocation!.latitude,
                    currentLocation!.longitude, placemarks[0].locality);
              } else {
                List<Placemark> placemarks = await placemarkFromCoordinates(
                    newLocation!.latitude, newLocation!.longitude);
                await saveLocation(newLocation!.latitude,
                    newLocation!.longitude, placemarks[0].locality);
              }
            },
            child: Text(
              "Save location and Continue",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      )),
    );
  }
}
