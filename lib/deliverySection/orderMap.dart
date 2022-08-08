import 'dart:async';

import 'package:fast_and_yummy/api/api.dart';
import 'package:fast_and_yummy/api/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class orderMap extends StatefulWidget {
  String StoreID;
  String orderLat;
  String orderLng;
  String orderCity;
  String orderName;
  String phone;
  String price;
  orderMap(this.StoreID, this.orderLat, this.orderLng, this.orderCity,
      this.orderName, this.phone, this.price,
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

  /********* For Line ***** */
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        width: 5,
        polylineId: id,
        color: basicColor,
        points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }

  _getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyDGsYZS1NKLmlMpI9ZyiNgzVeY_aZQXhAQ",
      PointLatLng(double.parse(storeInformation['latitude']),
          double.parse(storeInformation['longitude'])),
      PointLatLng(double.parse(widget.orderLat), double.parse(widget.orderLng)),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyLine();
  }
  /********* For line ***** */

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

  calculateDistance(
      double firstLat, double firstLng, double secondLat, double secondLng) {
    var distance =
        Geolocator.distanceBetween(firstLat, firstLng, secondLat, secondLng);

    return (distance / 1000).toStringAsFixed(3);
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
                      ? const CircularProgressIndicator()
                      : Container(
                          width: double.infinity,
                          height: 500,
                          child: GoogleMap(
                            polylines: Set<Polyline>.of(polylines.values),
                            markers: orderMark,
                            myLocationEnabled: true,
                            mapType: MapType.normal,
                            initialCameraPosition: _kGooglePlex!,
                            onMapCreated: (GoogleMapController controller) {
                              gmc = controller;
                              _getPolyline();
                            },
                          ),
                        ),
                  const Divider(),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Expanded(
                                child: Text(
                              "Order Distance :",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                            Expanded(
                                child: Text(
                                    "${calculateDistance(double.parse(storeInformation['latitude']), double.parse(storeInformation['longitude']), double.parse(widget.orderLat), double.parse(widget.orderLng))} Km"))
                          ],
                        ),
                        Row(
                          children: [
                            const Expanded(
                                child: Text("To :",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                            Expanded(child: Text("${widget.orderName}"))
                          ],
                        ),
                        Row(
                          children: [
                            const Expanded(
                                child: Text("Phone :",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                            Expanded(child: Text("${widget.phone}"))
                          ],
                        ),
                        Row(
                          children: [
                            const Expanded(
                                child: Text("At :",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                            Expanded(child: Text("${widget.orderCity}"))
                          ],
                        ),
                        Row(
                          children: [
                            const Expanded(
                                child: Text("Price :",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                            Expanded(child: Text("${widget.price}"))
                          ],
                        ),
                      ],
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
