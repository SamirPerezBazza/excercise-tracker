import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';

import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:my_app/dashboard.dart';

class Segments extends StatefulWidget {
  const Segments({super.key});

  @override
  State<Segments> createState() => _SegmentState();
}

class _SegmentState extends State<Segments> {
  TextEditingController nombre = TextEditingController();
  TextEditingController inicio = TextEditingController();
  TextEditingController fin = TextEditingController();
  List<Segment> segments = [];

  void addSegment() {
    Segment newSegment = Segment(nombre.text, inicio.text, fin.text);
    setState(() {
      segments.add(newSegment);
    });
    nombre.clear();
    inicio.clear();
    fin.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showMaterialModalBottomSheet(
            expand: false,
            context: context,
            backgroundColor: Colors.transparent,
            builder: (context) => Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextField(
                    controller: nombre,
                    decoration:
                        const InputDecoration(hintText: 'Nombre del segmento'),
                  ),
                  TextField(
                    controller: inicio,
                    decoration:
                        const InputDecoration(hintText: 'Inicio del segmento'),
                  ),
                  TextField(
                    controller: fin,
                    decoration:
                        const InputDecoration(hintText: 'Final del segmento'),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        addSegment();
                        Navigator.pop(context);
                      },
                      child: const Text('Crear'),
                    ),
                  )
                ],
              ),
            ),
          );
        },
        child: const Icon(CupertinoIcons.add),
      ),
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
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
            const Text("Tabla de posiciones"),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Text("Nombre"),
                  Text("Inicio"),
                  Text("Fin"),
                ],
              ),
            ),
            Container(
              child: Column(
                children: segments
                    .map(
                      (e) => Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          border: Border.all(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(e.name),
                            Text(e.inicio),
                            Text(e.fin),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      )),
    );
  }
}

class Segment {
  String name;
  String inicio;
  String fin;

  Segment(this.name, this.inicio, this.fin);
}
