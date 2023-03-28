import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:my_app/activity/activity.dart';
import 'package:my_app/dashboard.dart';
import 'dart:developer';

void ignoreOverflowErrors(
  FlutterErrorDetails details, {
  bool forceReport = false,
}) {
  bool ifIsOverflowError = false;
  bool isUnableToLoadAsset = false;

  // Detect overflow error.
  var exception = details.exception;
  if (exception is FlutterError) {
    ifIsOverflowError = !exception.diagnostics.any(
      (e) => e.value.toString().startsWith("A RenderFlex overflowed by"),
    );
    isUnableToLoadAsset = !exception.diagnostics.any(
      (e) => e.value.toString().startsWith("Unable to load asset"),
    );
  }

  // Ignore if is overflow error.
  if (ifIsOverflowError || isUnableToLoadAsset) {
    debugPrint('Ignored Error');
  } else {
    FlutterError.dumpErrorToConsole(details, forceReport: forceReport);
  }
}

void main() {
  const String titulo = "Bicicleta";

  Widget testWidget = MediaQuery(
    data: MediaQueryData(),
    child: MaterialApp(
      home: Dashboard(),
      routes: {
        '/activity': (context) => const Activity(),
      },
    ),
  );
  testWidgets('La pantalla tiene titulo', (WidgetTester tester) async {
    FlutterError.onError = ignoreOverflowErrors;

    await tester.pumpWidget(testWidget);

    // Presionar el botón de navegacion
    await tester.tap(find.text("Bicicleta"));
    await tester.pumpAndSettle();

    expect(find.text(titulo), findsOneWidget);
  });

  testWidgets('La pantalla tiene Ícono', (WidgetTester tester) async {
    FlutterError.onError = ignoreOverflowErrors;

    const String rutaImagen = 'assets/images/bikeEmoji.png';
    await tester.pumpWidget(testWidget);

    // Presionar el botón de navegacion
    await tester.tap(find.text("Bicicleta"));
    await tester.pumpAndSettle();

    expect(find.image(const AssetImage(rutaImagen)), findsOneWidget);
  });
  testWidgets('La pantalla tiene los botones iniciar y elminar',
      (WidgetTester tester) async {
    FlutterError.onError = ignoreOverflowErrors;
    await tester.pumpWidget(testWidget);

    // Presionar el botón de navegacion
    await tester.tap(find.text("Bicicleta"));
    await tester.pumpAndSettle();

    expect(find.text("Iniciar"), findsOneWidget);
    expect(find.text("Eliminar"), findsOneWidget);
  });

  testWidgets('Debe iniciar y detener el timer', (WidgetTester tester) async {
    FlutterError.onError = ignoreOverflowErrors;

    await tester.pumpWidget(testWidget);

    // Presionar el botón de navegacion
    await tester.tap(find.text("Bicicleta"));
    await tester.pumpAndSettle();

    // Presionar el botón iniciar
    await tester.tap(find.byKey(const Key("btn_timer")));
    await tester.pumpAndSettle(Duration(seconds: 5));

    expect(find.text("Detener"), findsOneWidget);
    // print(find.text("Detener"));
  });
}
