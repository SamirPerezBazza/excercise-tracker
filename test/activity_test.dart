import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:test/test.dart';
import 'package:my_app/activity/helpers.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  test('Debe localizar el dispositivo', () {
    const testPosition = LatLng(11.0176, -74.810509);

    determinePosition((LatLng userPosition) {
      double distance = Geolocator.distanceBetween(
          testPosition.latitude,
          testPosition.longitude,
          userPosition.latitude,
          userPosition.longitude);

      expect(distance, lessThanOrEqualTo(20));
    });
  });
}
