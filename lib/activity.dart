import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'package:my_app/dashboard.dart';

class Activity extends StatefulWidget {
  const Activity({super.key});

  @override
  State<Activity> createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  int _seconds = 0, _minutes = 0, _hours = 0;
  bool _isRunning = false;
  int _distance = 0;

  Timer? timer;

  void _initializeTime() {
    setState(() {
      _isRunning = true;
    });
    timer = Timer.periodic(new Duration(seconds: 1), (timer) {
      setState(() {
        _seconds = timer.tick;
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
    setState(() {
      _isRunning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as ActivityArguments;

    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
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
                          padding: const EdgeInsets.all(24),
                          elevation: 0),
                      onPressed: () {
                        Navigator.pushNamed(context, "/dashboard");
                      },
                      child: const Icon(CupertinoIcons.arrow_left_circle)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: <Widget>[
                          Text(args.title),
                          const Text("Tiempo"),
                          Container(
                            alignment: Alignment.center,
                            width: 80,
                            color: Colors.grey,
                            child: Text("$_hours:$_minutes:$_seconds"),
                          ),
                          const Text("Distancia"),
                          Container(
                            alignment: Alignment.center,
                            width: 80,
                            color: Colors.grey,
                            child: const Text("0 m"),
                          ),
                        ],
                      ),
                      args.image
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Recorrido"),
                        Container(
                          width: double.infinity,
                          height: 600,
                          color: Colors.blue,
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            _isRunning ? Colors.orange : Colors.green,
                        minimumSize: const Size.fromHeight(50),
                        elevation: 0,
                      ),
                      onPressed: () {
                        !_isRunning ? _initializeTime() : _stopTimer();
                      },
                      child: Text(_isRunning ? "Detener" : "Iniciar"),
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
    ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
