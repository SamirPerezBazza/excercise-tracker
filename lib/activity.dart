import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FirstRoute extends StatelessWidget {
  const FirstRoute({super.key});

  @override
  Widget build(BuildContext context) {
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
                      onPressed: () {},
                      child: const Icon(CupertinoIcons.arrow_left_circle)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: <Widget>[
                          const Text("Bicicleta"),
                          const Text("Tiempo"),
                          Container(
                            alignment: Alignment.center,
                            width: 80,
                            color: Colors.grey,
                            child: const Text("00:00:00"),
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
                      Image.asset(
                        "assets/images/bikeEmoji.png",
                        width: 100,
                        height: 100,
                      )
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
                        backgroundColor: Colors.green,
                        minimumSize: const Size.fromHeight(50),
                        elevation: 0,
                      ),
                      onPressed: () {},
                      child: const Text("Iniciar"),
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
