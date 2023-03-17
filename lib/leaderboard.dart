import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Leaderboard extends StatelessWidget {
  const Leaderboard({super.key});

  //TODO: bring the leaderboard data from the storage

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Text("Actividad"),
                  Text("Nombre"),
                  Text("Tiempo"),
                  Text("Distancia"),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        Text("Bicicleta"),
                        Text("Samir"),
                        Text("3"),
                        Text("100"),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
