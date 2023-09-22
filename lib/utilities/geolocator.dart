import 'package:geolocator/geolocator.dart';
import 'dart:async';

import 'package:get/get.dart';
import '/data/controller/devtool.dart';

final devC = Get.put(DevtoolController());

class GeolocatorUtilities {
  static Position? cachedPosition; //防止在排序时过于频繁读取地址，设置一个缓存
  static const Duration cachedDuration = Duration(seconds: 60);
  //判断两个点是否超过一公里距离，并弹出提示
  static Future<bool> isOverOneKM(double lat, double lng) async {
    double distanceInMeters = await getDistance(lat, lng);

    return distanceInMeters > 1000;
  }

  //得到目的地与当前的距离
  static Future<double> getDistance(double lat, double lng) async {
    late Position currentPosition;

    if (cachedPosition == null) {
      currentPosition = await _determinePosition();

      cachedPosition = currentPosition;
      Future.delayed(cachedDuration, () {
        cachedPosition = null;
      });
    } else {
      currentPosition = cachedPosition!;
    }

    double latitude = currentPosition.latitude;
    double longitude = currentPosition.longitude;
    double distanceInMeters =
        Geolocator.distanceBetween(lat, lng, latitude, longitude);
    devC.addHttpInfo(
        'distance is $distanceInMeters,\n now lat-$latitude lng-$longitude,\n target lat-$lat lng-$lng,');

    return distanceInMeters;
  }

  static Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
