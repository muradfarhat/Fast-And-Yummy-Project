import 'package:fast_and_yummy/api/api.dart';
import 'package:fast_and_yummy/api/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class myOrderMap extends StatefulWidget {
  String StoreID;
  String deliveryMan;
  String orderLat;
  String orderLng;
  String orderCity;
  String orderName;
  String price;
  myOrderMap(this.StoreID, this.deliveryMan, this.orderLat, this.orderLng,
      this.orderCity, this.orderName, this.price,
      {Key? key})
      : super(key: key);

  @override
  State<myOrderMap> createState() => _myOrderMapState();
}

class _myOrderMapState extends State<myOrderMap> {
  Color basicColor = const Color.fromARGB(255, 37, 179, 136);
  Api api = Api();
  Position? currentLocation;
  CameraPosition? _kGooglePlex;
  bool loading = true;
  Set<Marker> orderMark = {};
  Map storeInformation = {};
  Map deliveryInfo = {};

  String? deliveryManName;
  String? phone;

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

  getDeliveryMan(String id) async {
    var response = await api.postReq(bringDeliveryInfo, {"id": id});
    if (response['status'] == "suc") {
      setState(() {
        deliveryInfo = response['data'][0];
      });
    }
  }

  getName(String id) async {
    var response = await api.postReq(getDeliverName, {"id": id});
    if (response['status'] == "suc") {
      setState(() {
        deliveryManName =
            "${response['data'][0]["first_name"]} ${response['data'][0]["last_name"]}";
        phone = response['data'][0]["phone"];
      });
    }
  }

  GoogleMapController? gmc;

  @override
  void initState() {
    getDeliveryMan(widget.deliveryMan);
    getName(widget.deliveryMan);
    getPosition();
    getLatAndLong();
    getStoreLocation(widget.StoreID);
    super.initState();
  }

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
                                  child: Text("At :",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))),
                              Expanded(child: Text("${widget.orderCity}"))
                            ],
                          ),
                          Row(
                            children: [
                              const Expanded(
                                  child: Text("With :",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))),
                              Expanded(child: Text("$deliveryManName"))
                            ],
                          ),
                          Row(
                            children: [
                              const Expanded(
                                  child: Text("Phone :",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))),
                              Expanded(child: Text("$phone"))
                            ],
                          ),
                          Row(
                            children: [
                              const Expanded(
                                  child: Text("Man ID :",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))),
                              Expanded(
                                  child: Text("${deliveryInfo["deliveryID"]}"))
                            ],
                          ),
                          Row(
                            children: [
                              const Expanded(
                                  child: Text("Car Model :",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))),
                              Expanded(
                                  child: Text("${deliveryInfo["carModel"]}"))
                            ],
                          ),
                          Row(
                            children: [
                              const Expanded(
                                  child: Text("Car ID :",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))),
                              Expanded(
                                  child: Text("${deliveryInfo["carNumber"]}"))
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                )),
    );
  }
}
