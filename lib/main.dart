import 'package:flutter/material.dart';
import 'package:my_app/leaderboard.dart';
import 'activity.dart';
import 'dashboard.dart';
import 'leaderboard.dart';
import 'record.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
      routes: {
        '/dashboard': (context) => const Dashboard(),
        '/activity': (context) => const Activity(),
        '/leaderboard': (context) => const Leaderboard(),
      },
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/fredbear.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 50.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      hintText: 'Correo electrónico',
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Contraseña',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50.0),
            ElevatedButton(
              onPressed: () {
                _login(context);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
              ),
              child: const Text(
                'Iniciar sesión',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            GestureDetector(
              onTap: () {},
              child: const Text(
                'Registrarse',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _login(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    String? password = prefs.getString('password');

    if ("harry@gmail.com" == emailController.text &&
        "123" == passwordController.text) {
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, "/dashboard");
    } else {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Correo o contraseña incorrectos.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
