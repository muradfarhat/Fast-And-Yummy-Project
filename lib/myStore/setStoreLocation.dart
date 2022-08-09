// ignore_for_file: use_build_context_synchronously

import 'package:fast_and_yummy/api/api.dart';
import 'package:fast_and_yummy/api/linkapi.dart';
import 'package:fast_and_yummy/main.dart';
import 'package:fast_and_yummy/myStore/myStorePage.dart';
import 'package:fast_and_yummy/userpage/basic_user.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StoreLocation extends StatefulWidget {
  StoreLocation({Key? key}) : super(key: key);

  @override
  State<StoreLocation> createState() => _setStoreLocationState();
}

class _setStoreLocationState extends State<StoreLocation> {
  Color basicColor = const Color.fromARGB(255, 37, 179, 136);
  Position? currentLocation;
  LatLng? newLocation;
  CameraPosition? _kGooglePlex;
  GoogleMapController? gmc;
  Api _api = Api();

  Set<Marker> myMark = {};
  setMark() {
    myMark.add(
      Marker(
          markerId: const MarkerId("Location"),
          infoWindow: const InfoWindow(title: "Your Location"),
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

  saveStoreLocation(double lat, double lng, String? cityL) async {
    var response = await _api.postReq(storeMapSetLocation, {
      "id": sharedPref.getString("id"),
      "lat": lat.toString(),
      "lng": lng.toString(),
      "cityL": cityL
    });
    if (response['status'] == "suc") {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: ((context) {
        return MyStorePage();
      })));
      // Navigator.of(context).pushReplacementNamed("home");
    }
  }

  @override
  void initState() {
    getPosition();
    getLatAndLong();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                List<Placemark> placemarks = await placemarkFromCoordinates(
                    currentLocation!.latitude, currentLocation!.longitude);
                await saveStoreLocation(currentLocation!.latitude,
                    currentLocation!.longitude, placemarks[0].locality);
              } else {
                List<Placemark> placemarks = await placemarkFromCoordinates(
                    newLocation!.latitude, newLocation!.longitude);
                await saveStoreLocation(newLocation!.latitude,
                    newLocation!.longitude, placemarks[0].locality);
              }
            },
            child: const Text(
              "Save location and Continue",
              style: const TextStyle(color: Colors.white),
            ),
          )
        ],
      )),
    );
  }
}
