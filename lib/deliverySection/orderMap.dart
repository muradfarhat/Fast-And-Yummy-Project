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
      if (per == LocationPermission.always ||
          per == LocationPermission.whileInUse) {
        getLatAndLong();
      }
    }
    print("=============================");
    print(per);
    print("=============================");
  }

  Future<Position> getLatAndLong() async {
    Position cl = await Geolocator.getCurrentPosition().then((value) => value);
    return cl;
  }

  @override
  void initState() {
    getPosition();
    super.initState();
  }

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 500,
        width: double.infinity,
        child: TextButton(
          child: Text("Press"),
          onPressed: () async {
            var distance = Geolocator.distanceBetween(
                24.806681, 39.785371, 21.350781, 39.873319);
            print(distance / 1000.0);

            // currentLocation = await getLatAndLong();
            // print(currentLocation!.latitude);
            // print(currentLocation!.longitude);
            // List<Placemark> placemarks = await placemarkFromCoordinates(
            //     currentLocation!.latitude, currentLocation!.longitude);
            // print(placemarks[0].locality);
          },
        ),
        // GoogleMap(
        //   mapType: MapType.normal,
        //   initialCameraPosition: _kGooglePlex,
        //   onMapCreated: (GoogleMapController controller) {
        //     _controller.complete(controller);
        //   },
        // ),
      ),
    );
  }
}
// 24.806681, 39.785371
// 21.350781, 39.873319