import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:sence_sence/shared/theme.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as mp_tool;

class MapsScreen extends StatefulWidget {
  const MapsScreen({Key? key}) : super(key: key);

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  bool isInSelectedArea = true;

  late List<mp_tool.LatLng> convertedPolygonPoints = polygonPoints
      .map((point) => mp_tool.LatLng(point.latitude, point.longitude))
      .toList();
  void checkUpdatedLocation(LatLng pointLatLng) {
    setState(() {
      isInSelectedArea = mp_tool.PolygonUtil.containsLocation(
          mp_tool.LatLng(pointLatLng.latitude, pointLatLng.longitude),
          convertedPolygonPoints,
          false);
    });
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
  final Completer<GoogleMapController> _controller = Completer();
  // on below line we have specified camera position
  static const CameraPosition _kGoogle = CameraPosition(
    target: LatLng(-6.941165, 107.628982),
    zoom: 17,
  );

  // on below line we have created the list of markers
  final List<Marker> _markers = <Marker>[
    const Marker(
        markerId: MarkerId('1'),
        position: LatLng(-6.941165, 107.628982),
        infoWindow: InfoWindow(
          title: 'SMKN 4 Bandung',
        )),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: neutral,
      appBar: AppBar(
        backgroundColor: white,
        centerTitle: true,
        title: Text("Lokasi", style: appBarTitle,),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black,),
        ),
      ),
      body: Container(
        child: SafeArea(
          // on below line creating google maps
          child: GoogleMap(
            // on below line setting camera position
            initialCameraPosition: _kGoogle,
            // on below line we are setting markers on the map
            markers: Set<Marker>.of(_markers),
            // on below line specifying map type.
            mapType: MapType.normal,
            // on below line setting user location enabled.
            myLocationEnabled: true,
            // on below line setting compass enabled.
            compassEnabled: true,
            // on below line specifying controller on map complete.
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            //polygon area
            polygons: {
              Polygon(
                polygonId: const PolygonId("1"),
                points: polygonPoints,
                fillColor: btnMain.withOpacity(0.20),
                strokeWidth: 1,
              ),
            },
          ),
        ),
      ),
      // on pressing floating action button the camera will take to user current location
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          getUserCurrentLocation().then((value) async {
            print("${value.latitude} ${value.longitude}");
            print("");
            print("ini berhasil terjalankan");
            print("");
            //check
            checkUpdatedLocation(LatLng(value.latitude, value.longitude));
            // marker added for current users location
            _markers.add(
              Marker(
                markerId: const MarkerId("2"),
                position: LatLng(value.latitude, value.longitude),
                infoWindow: const InfoWindow(
                  title: 'Lokasi Saya',
                ),
              ),
            );

            // specified current users location
            CameraPosition cameraPosition = CameraPosition(
              target: LatLng(value.latitude, value.longitude),
              zoom: 18.5,
            );

            final GoogleMapController controller = await _controller.future;
            controller
                .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
            setState(() {});
          });
          if(isInSelectedArea == true){
            buildSuccessDialog(context);
            print("");
            print("ini success ");
            print("");
          }else{
            buildFailedDialog(context);
            print("");
            print("ini gagal ");
            print("");
          }
        },
        child: const Icon(Icons.location_history_rounded),
      ),
    );
  }
  AwesomeDialog buildSuccessDialog(BuildContext context) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      title: 'Bisa Presensi :)',
      titleTextStyle: popUpWarningTitle,
      desc: 'Anda dalam area presensi',
      descTextStyle: popUpWarningDesc,
      buttonsTextStyle: whiteOnBtnSmall,
      buttonsBorderRadius: BorderRadius.circular(6.r),
      btnOkColor: btnMain,
      showCloseIcon: false,
      btnOkText: 'Kembali',
      btnOkOnPress: () {},
    );
  }
  AwesomeDialog buildFailedDialog(BuildContext context) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      title: 'Tidak Bisa Presensi :(',
      titleTextStyle: popUpWarningTitle,
      desc: 'Anda berada di luar area presensi',
      descTextStyle: popUpWarningDesc,
      buttonsTextStyle: whiteOnBtnSmall,
      buttonsBorderRadius: BorderRadius.circular(6.r),
      btnOkColor: btnMain,
      showCloseIcon: false,
      btnOkText: 'Kembali',
      btnOkOnPress: () {},
    );

  }
  bool checkUserCanPresence(){
    late bool canPresense;
    if(isInSelectedArea == true){
      setState(() {
        canPresense = true;
      });
      print("");
      print("ini success ");
      print("");
    }else{
      setState(() {
        canPresense = false;
      });
      print("");
      print("ini gagal ");
      print("");
    }
    return canPresense;
  }
}
