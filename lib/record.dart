import 'package:flutter/material.dart';

class HistorialNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historial'),
      ),
      body: Center(
        child: Image.asset('assets/images/historial.jpg'),
      ),
    );
  }
}
