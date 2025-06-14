import 'package:geolocator/geolocator.dart';

Future<Position> getLocation() async {
  LocationPermission prermission;

  prermission = await Geolocator.checkPermission();

  if (prermission == LocationPermission.denied) {
    prermission = await Geolocator.requestPermission();
    if (prermission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (prermission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  return await Geolocator.getCurrentPosition();
}
