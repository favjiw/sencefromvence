import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:maps_toolkit/maps_toolkit.dart' as mp_tool;

class MapController {
  bool isInSelectedArea = false;

  late List<mp_tool.LatLng> convertedPolygonPoints = polygonPoints
      .map((point) => mp_tool.LatLng(point.latitude, point.longitude))
      .toList();

  void checkUpdatedLocation(LatLng pointLatLng) {
    isInSelectedArea = mp_tool.PolygonUtil.containsLocation(
        mp_tool.LatLng(pointLatLng.latitude, pointLatLng.longitude),
        convertedPolygonPoints,
        false);
  }

  //polygon
  List<LatLng> polygonPoints = [
    const LatLng(-6.941823, 107.628492),
    const LatLng(-6.941839, 107.628906),
    const LatLng(-6.941642, 107.628949),
    const LatLng(-6.941701, 107.629298),
    const LatLng(-6.941551, 107.629362),
    const LatLng(-6.941573, 107.629555),
    const LatLng(-6.941040, 107.629743),
    const LatLng(-6.940652, 107.628932),
    const LatLng(-6.940955, 107.628884),
    const LatLng(-6.940923, 107.628643),
  ];

  // created method for getting user current location
  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR$error");
    });
    return await Geolocator.getCurrentPosition();
  }

  void validateUserLocation() async{
    getUserCurrentLocation().then((value) async {
      print("${value.latitude} ${value.longitude}");
      checkUpdatedLocation(LatLng(value.latitude, value.longitude));
      if(isInSelectedArea == true){
        print("ini success");
      }else{
        print("ini gagal");
      }
    });
  }
}
