import 'dart:async';

import 'package:fast_and_yummy/api/api.dart';
import 'package:fast_and_yummy/api/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class orderMap extends StatefulWidget {
  String StoreID;
  String orderLat;
  String orderLng;
  String orderCity;
  orderMap(this.StoreID, this.orderLat, this.orderLng, this.orderCity,
      {Key? key})
      : super(key: key);

  @override
  State<orderMap> createState() => _orderMapState();
}

class _orderMapState extends State<orderMap> {
  Color basicColor = const Color.fromARGB(255, 37, 179, 136);
  Api api = Api();
  Position? currentLocation;
  CameraPosition? _kGooglePlex;
  bool loading = true;
  Set<Marker> orderMark = {};
  Map storeInformation = {};

  setMark() {
    setState(() {
      orderMark.add(
        Marker(
            markerId: const MarkerId("store"),
            infoWindow: const InfoWindow(title: "Store Location"),
            position: LatLng(double.parse(storeInformation['latitude']),
                double.parse(storeInformation['longitude']))),
      );
      orderMark.add(
        Marker(
            markerId: const MarkerId("order"),
            infoWindow: const InfoWindow(title: "Order Location"),
            position: LatLng(
                double.parse(widget.orderLat), double.parse(widget.orderLng))),
      );
      loading = false;
    });
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
    //return cl;
  }

  getStoreLocation(String store) async {
    var response = await api.postReq(storeInfo, {"id": store});
    if (response['status'] == "suc") {
      setState(() {
        storeInformation = response['data'];
      });
      setMark();
    }
  }

  @override
  void initState() {
    getPosition();
    getLatAndLong();
    getStoreLocation(widget.StoreID);
    super.initState();
  }

  GoogleMapController? gmc;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: basicColor,
      ),
      body: SingleChildScrollView(
        child: loading
            ? SizedBox(
                height: size.height,
                width: size.width,
                child: Center(
                  child: CircularProgressIndicator(color: basicColor),
                ),
              )
            : Column(
                children: [
                  _kGooglePlex == null
                      ? CircularProgressIndicator()
                      : Container(
                          width: double.infinity,
                          height: 500,
                          child: GoogleMap(
                            markers: orderMark,
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
                    child: Column(
                      children: [],
                    ),
                  )
                  // Container(
                  //   width: double.infinity,
                  //   child: TextButton(
                  //     child: Text("Press"),
                  //     onPressed: () async {
                  //       LatLng latlang = LatLng(24.806681, 39.785371);
                  //       gmc!.animateCamera(CameraUpdate.newCameraPosition(
                  //           CameraPosition(target: latlang, zoom: 10.0)));

                  //       var distance = Geolocator.distanceBetween(
                  //           24.806681, 39.785371, 21.350781, 39.873319);
                  //       print("=========== values ===========");
                  //       print(distance / 1000.0);

                  //       //currentLocation = await getLatAndLong();
                  //       print(currentLocation!.latitude);
                  //       print(currentLocation!.longitude);
                  //       List<Placemark> placemarks = await placemarkFromCoordinates(
                  //           currentLocation!.latitude, currentLocation!.longitude);
                  //       print(placemarks[0].locality);
                  //       print("=========== values ===========");
                  //     },
                  //   ),
                  // ),
                ],
              ),
      ),
    );
  }
}
// 24.806681, 39.785371
// 21.350781, 39.873319