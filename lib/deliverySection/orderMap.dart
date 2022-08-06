import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class orderMap extends StatefulWidget {
  orderMap({Key? key}) : super(key: key);

  @override
  State<orderMap> createState() => _orderMapState();
}

class _orderMapState extends State<orderMap> {
  Position? currentLocation;
  CameraPosition? _kGooglePlex;
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
    print("=============================");
    print(per);
    print("=============================");
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
    //return cl;
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            _kGooglePlex == null
                ? CircularProgressIndicator()
                : Container(
                    width: double.infinity,
                    height: 500,
                    child: GoogleMap(
                      myLocationEnabled: true,
                      mapType: MapType.normal,
                      initialCameraPosition: _kGooglePlex!,
                      onMapCreated: (GoogleMapController controller) {
                        gmc = controller;
                      },
                    ),
                  ),
            Divider(),
            Container(
              width: double.infinity,
              child: TextButton(
                child: Text("Press"),
                onPressed: () async {
                  LatLng latlang = LatLng(24.806681, 39.785371);
                  gmc!.animateCamera(CameraUpdate.newCameraPosition(
                      CameraPosition(target: latlang, zoom: 10.0)));

                  var distance = Geolocator.distanceBetween(
                      24.806681, 39.785371, 21.350781, 39.873319);
                  print("=========== values ===========");
                  print(distance / 1000.0);

                  //currentLocation = await getLatAndLong();
                  print(currentLocation!.latitude);
                  print(currentLocation!.longitude);
                  List<Placemark> placemarks = await placemarkFromCoordinates(
                      currentLocation!.latitude, currentLocation!.longitude);
                  print(placemarks[0].locality);
                  print("=========== values ===========");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// 24.806681, 39.785371
// 21.350781, 39.873319