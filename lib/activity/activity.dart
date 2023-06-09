import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:my_app/activity/helpers.dart';

import 'package:my_app/dashboard.dart';

class Activity extends StatefulWidget {
  const Activity({super.key});

  @override
  State<Activity> createState() => ActivityState();
}

class ActivityState extends State<Activity> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  int _seconds = 0, _minutes = 0, _hours = 0;

  bool isRunning = false;

  double _distance = 0;
  var userLocation = const LatLng(37.42796133580664, -122.085749655962);

  Timer? timer;
  StreamSubscription<Position>? positionStream;

  // ignore: prefer_final_fields
  CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  void _initializeTime() {
    //Start listening to the user's position
    setState(() {
      isRunning = true;
      _seconds = 0;
      _minutes = 0;
      _hours = 0;
      _distance = 0;
    });

    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 2,
    );

    positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position? newPosition) {
      if (newPosition != null) {
        double newDistance = Geolocator.distanceBetween(
            userLocation.latitude,
            userLocation.longitude,
            newPosition.latitude,
            newPosition.longitude);
        setState(() {
          _distance = newDistance;
        });
      }
    });

    timer = Timer.periodic(new Duration(seconds: 1), (timer) {
      setState(() {
        _seconds += 1;
      });

      if (_seconds > 59) {
        setState(() {
          _seconds = 0;
          _minutes += 1;
        });
      } else if (_minutes > 59) {
        setState(() {
          _minutes = 0;
          _hours += 1;
        });
      }
    });
  }

  void _stopTimer() {
    timer?.cancel();
    positionStream?.cancel();
    setState(() {
      isRunning = false;
    });
  }

  Future<void> onCompleteLocation(position) async {
    CameraPosition userPosition = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(position.latitude, position.longitude),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414,
    );

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(userPosition));

    setState(() {
      userLocation = position;
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as ActivityArguments;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                  alignment: Alignment.center,
                  widthFactor: 1.7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          fixedSize: const Size(50, 50),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, "/dashboard");
                        },
                        child: const Icon(
                          CupertinoIcons.arrow_left_circle,
                          color: Colors.black,
                          size: 50,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            args.title,
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          args.image
                        ],
                      ),
                      Container(
                          margin: const EdgeInsets.symmetric(vertical: 40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: <Widget>[
                                  const Text(
                                    "Tiempo",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey,
                                    ),
                                    child: Text("$_hours:$_minutes:$_seconds"),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  const Text(
                                    "Distancia",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey,
                                    ),
                                    child: Text(
                                        "${_distance.toStringAsFixed(1)}m"),
                                  )
                                ],
                              )
                            ],
                          )),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Recorrido",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: GoogleMap(
                                mapType: MapType.normal,
                                initialCameraPosition: _kGooglePlex,
                                onMapCreated: (GoogleMapController controller) {
                                  _controller.complete(controller);
                                  determinePosition(onCompleteLocation);
                                },
                                myLocationEnabled: true,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        // margin: const EdgeInsets.symmetric(vertical: 10),
                        child: ElevatedButton(
                          key: const Key("btn_timer"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                isRunning ? Colors.orange : Colors.green,
                            minimumSize: const Size.fromHeight(50),
                            elevation: 0,
                          ),
                          onPressed: () {
                            !isRunning ? _initializeTime() : _stopTimer();
                          },
                          child: Text(isRunning ? "Detener" : "Iniciar"),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          minimumSize: const Size.fromHeight(50),
                          elevation: 0,
                        ),
                        onPressed: () {},
                        child: const Text("Eliminar"),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
