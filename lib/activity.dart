import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FirstRoute extends StatelessWidget {
  const FirstRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Align(
            alignment: Alignment.topLeft,
            widthFactor: 1.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Bicicleta',
                  style: TextStyle(fontSize: 40),
                ),
              ],
            )),
      ],
    ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
