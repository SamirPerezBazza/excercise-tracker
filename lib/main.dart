import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'activity.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      routes: {
        '/activity': (context) => const FirstRoute(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // int _counter = 0;

  // void _incrementCounter() {
  //   setState(() {
  //     // This call to setState tells the Flutter framework that something has
  //     // changed in this State, which causes it to rerun the build method below
  //     // so that the display can reflect the updated values. If we changed
  //     // _counter without calling setState(), then the build method would not be
  //     // called again, and so nothing would appear to happen.
  //     _counter++;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
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
                  'Hola, Juan',
                  style: TextStyle(fontSize: 40),
                ),
                Text(
                  '¿Que harás hoy?',
                  style: TextStyle(fontSize: 20),
                )
              ],
            )),
        Align(
            alignment: Alignment.center,
            heightFactor: 2,
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                Card(
                  title: 'Bicicleta',
                  image: Image.asset(
                    'assets/images/bikeEmoji.png',
                    width: 100,
                    height: 100,
                  ),
                  handleTab: () => Navigator.pushNamed(context, '/activity'),
                ),
                // Card(
                //   title: 'Caminata',
                //   image: Image.asset(
                //     'assets/images/walkingEmoji.png',
                //     width: 100,
                //     height: 100,
                //   ),
                // ),
                // Card(
                //   title: 'Trotar',
                //   image: Image.asset(
                //     'assets/images/runningEmoji.png',
                //     width: 100,
                //     height: 100,
                //   ),
                // ),
              ],
            )),
        Align(
            alignment: Alignment.center,
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                RoundButton(
                    color: Colors.blue.shade300,
                    icon: const Icon(
                      CupertinoIcons.graph_circle,
                      size: 40,
                    )),
                RoundButton(
                    color: Colors.green.shade300,
                    icon: const Icon(CupertinoIcons.clock)),
                RoundButton(
                    color: Colors.orange.shade300,
                    icon: const Icon(CupertinoIcons.list_bullet)),
                RoundButton(
                    color: Colors.purple.shade300,
                    icon: const Icon(CupertinoIcons.map)),
              ],
            ))
      ],
    ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}

class RoundButton extends StatelessWidget {
  final Color color;
  final Icon icon;
  const RoundButton({
    super.key,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 60,
      child: Material(
        borderRadius: BorderRadius.circular(100),
        color: color,
        child: InkWell(onTap: () {}, child: icon),
      ),
    );
  }
}

class Card extends StatelessWidget {
  final String title;
  final Image image;
  final VoidCallback handleTab;

  const Card({
    super.key,
    required this.title,
    required this.image,
    required this.handleTab,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: handleTab,
        child: Container(
            height: 200,
            width: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
                image
              ],
            )),
      ),
    );
  }
}
