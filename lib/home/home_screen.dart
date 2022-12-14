import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:sence_sence/shared/theme.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:sence_sence/home/controller/maps_controller.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Query dbPresence = FirebaseDatabase.instance.ref().child('presence');
  Query refStudent = FirebaseDatabase.instance.ref().child('users');
  var studentRef = FirebaseDatabase.instance.ref('users');
  // DatabaseReference refName =  FirebaseDatabase.instance.ref('users/-NH2Qg94bIZbqyLZMveS/').child("name");
  Query refName = FirebaseDatabase.instance.ref('users/-NH2Qg94bIZbqyLZMveS/').child("id");

  late bool canPresent;
  late DateTime currentTime = DateTime.now();
  late String yearNow = DateFormat('yyyy-MM-dd').format(DateTime.now());
  late String timeNow = DateFormat('yyyy-MM-dd hh:mm:ss').format(currentTime);
  late String presenceMorningStart = yearNow + " 06:00:00";
  late String presenceMorningEnd = yearNow + " 07:00:00";
  late String presenceAfternoonStart = yearNow + " 14:00:00";
  late String presenceAfternoonEnd = yearNow + " 17:00:00";
  late String morningStart = yearNow + " 00:00:00";
  late String morningEnd = yearNow + " 12:00:00";
  late DateTime presenceInStart = DateTime.parse(presenceMorningStart);
  late DateTime presenceInEnd = DateTime.parse(presenceMorningEnd);
  late DateTime presenceOutStart = DateTime.parse(presenceAfternoonStart);
  late DateTime presenceOutEnd = DateTime.parse(presenceAfternoonEnd);
  late DateTime dayStart = DateTime.parse(morningStart);
  late DateTime dayEnd = DateTime.parse(morningEnd);
  String nis = "";
  Timer? timer;
  String name = "siapa";

  MapController mapController = new MapController();
  late DatabaseReference dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('presence');
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      currentTime = DateTime.now();
      timeNow = DateFormat('yyyy-MM-dd hh:mm:ss').format(currentTime);
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future<bool> hasPresence(String Id) async {
    bool has = false;
    final snapshot =
        await FirebaseDatabase.instance.ref().child("presence").get();
    (snapshot.value as Map<dynamic, dynamic>).forEach((key, val) {
      if (val["student_id"] == nis) {
        has = true;
      }
    });

    return has;
  }

  bool isCanPresentIn() {
    if (currentTime.isAfter(presenceInStart) &&
        currentTime.isBefore(presenceInEnd)) {
      setState(() {
        canPresent = true;
      });
    } else {
      setState(() {
        canPresent = false;
      });
    }
    return canPresent;
  }

  bool statusTime() {
    late bool isMorning;
    if (currentTime.isAfter(dayStart) && currentTime.isBefore(dayEnd)) {
      setState(() {
        isMorning = true;
      });
    } else {
      setState(() {
        isMorning = false;
      });
    }
    return isMorning;
  }

  Future<int> asyncNIS() async {
    return await SessionManager().get("user");
  }

  Future<String> getName() async {
    var nis = await asyncNIS();
    final refName2   = FirebaseDatabase.instance.ref('users').orderByChild("id").equalTo(nis);
    DatabaseEvent event = await refName2.once();
    var value = event.snapshot.value as Map;
    if(value.containsKey('-NH2Qg94bIZbqyLZMveS')) {
      var users = value!['-NH2Qg94bIZbqyLZMveS'];
      // print(users!['name']);
      // String name = event.snapshot.value.toString();
      return users!['name'];
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {

    asyncNIS().then((value) {
      setState(() {
        this.nis = '$value';
      });
    });

    getName().then((value){
      setState(() {
        this.name = value;
      });
    });

    return Scaffold(
      backgroundColor: neutral,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 46.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Selamat datang,',
                          style: HomeTitle,
                        ),
                        Text(
                          nis,
                          style: HomeTitle,
                        ),
                      ],
                    ),
                    Container(
                      width: 41.w,
                      height: 41.h,
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: HexColor('#00DE19'),
                      ),
                      child: Container(
                        width: 35.w,
                        height: 35.h,
                        decoration: BoxDecoration(
                          color: HexColor('#FEFFBF'),
                          borderRadius: BorderRadius.circular(100.r),
                        ),
                        child: Center(
                          child: Image.asset(
                            'asset/images/img-profile.png',
                            width: 26.w,
                            height: 26.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Center(
                child: Container(
                  padding: EdgeInsets.only(left: 18.w, right: 18.w, top: 15.h),
                  width: 326.w,
                  height: 164.h,
                  decoration: BoxDecoration(
                    color: btnMain,
                    borderRadius: BorderRadius.circular(6.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.10),
                        offset: const Offset(0, 4),
                        blurRadius: 10,
                        spreadRadius: 0,
                      ),
                    ],
                    image: DecorationImage(
                      alignment: Alignment.bottomCenter,
                      fit: BoxFit.contain,
                      image: AssetImage('asset/images/line-home-bg.png'),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        statusTime() == true
                            ? 'Kamu belum melakukan presensi masuk'
                            : 'Kamu belum melakukan presensi keluar',
                        style: HomeTitleWhitee,
                      ),
                      Text(
                        'Batas Waktu :',
                        style: HomesubTitleWhite,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 35.w,
                            height: 35.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Center(
                              child: Image.asset(
                                'asset/images/deadline-ic.png',
                                width: 23.w,
                                height: 23.h,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 14.w,
                          ),
                          Text(
                            statusTime() == true ? '07:00' : '16:00',
                            style: HomeTimeWhite,
                          ),
                          Container(
                            child: LayoutBuilder(builder: (context, constraints){
                              if (currentTime.isAfter(presenceInStart) &&
                                  currentTime.isBefore(presenceOutStart)){
                                return Text("(telat)", style: homeLate,);
                              }else{
                                return SizedBox();
                              }
                            }),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Container(
                        child: LayoutBuilder(builder: (context, constraints) {
                          if (currentTime.isAfter(presenceInStart) &&
                              currentTime.isBefore(presenceInEnd)) {
                            return Container(
                              width: 287.w,
                              height: 40.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.10),
                                    offset: Offset(0, 4),
                                    blurRadius: 6,
                                  ),
                                ],
                              ),
                              child: TextButton(
                                onPressed: () {
                                  mapController.validateUserLocation();
                                  if (mapController.isInSelectedArea == true) {
                                    Navigator.pushNamed(context, '/webview');
                                  } else {
                                    buildAwesomeDialogNotInArea(context).show();
                                  }
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: white,
                                ),
                                child: Text(
                                  "Lakukan Presensi",
                                  style: WhiteOnButton,
                                ),
                              ),
                            );
                          } else if (currentTime.isAfter(presenceInEnd) && currentTime.isBefore(presenceOutStart)){
                            return Container(
                              width: 287.w,
                              height: 40.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.10),
                                    offset: Offset(0, 4),
                                    blurRadius: 6,
                                  ),
                                ],
                              ),
                              child: TextButton(
                                onPressed: () {
                                  mapController.validateUserLocation();
                                  if (mapController.isInSelectedArea == true) {
                                    Navigator.pushNamed(context, '/webview');
                                  } else {
                                    buildAwesomeDialogNotInArea(context).show();
                                  }
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: HexColor('#F0FF40'),
                                ),
                                child: Text(
                                  "Lakukan Presensi",
                                  style: WhiteOnButton,
                                ),
                              ),
                            );
                          }
                          else if (currentTime.isAfter(presenceOutStart) &&
                              currentTime.isBefore(presenceOutEnd)) {
                            return Container(
                              width: 287.w,
                              height: 40.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.10),
                                    offset: Offset(0, 4),
                                    blurRadius: 6,
                                  ),
                                ],
                              ),
                              child: TextButton(
                                onPressed: () {
                                  mapController.validateUserLocation();
                                  if (mapController.isInSelectedArea == true) {
                                    Navigator.pushNamed(context, '/webview');
                                  } else {
                                    buildAwesomeDialogNotInArea(context).show();
                                  }
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: white,
                                ),
                                child: Text(
                                  "Lakukan Presensi",
                                  style: WhiteOnButton,
                                ),
                              ),
                            );
                          } else {
                            return Container(
                              width: 287.w,
                              height: 40.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  buildAwesomeDialogNotInTime(context).show();
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: HexColor("#E5E5E5"),
                                ),
                                child: Text(
                                  "Lakukan Presensi",
                                  style: buttonDisabled,
                                ),
                              ),
                            );
                          }
                        }),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/history');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        padding: EdgeInsets.zero,
                        elevation: 0,
                      ),
                      child: Container(
                        width: 76.w,
                        height: 76.h,
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(6.r),
                            border: Border.all(
                              color: grayBorder,
                              width: 1.w,
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: HexColor('#C9C9C9').withOpacity(0.10),
                                  offset: const Offset(0, 4),
                                  blurRadius: 6),
                            ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("asset/images/history-ic.png", width: 39.w, height: 39.h,),
                            SizedBox(height: 5.h),
                            Text("Riwayat", style: homeCategoryTitle,),
                          ],
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/permission');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        padding: EdgeInsets.zero,
                        elevation: 0,
                      ),
                      child: Container(
                        width: 76.w,
                        height: 76.h,
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(6.r),
                            border: Border.all(
                              color: grayBorder,
                              width: 1.w,
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: HexColor('#C9C9C9').withOpacity(0.10),
                                  offset: const Offset(0, 4),
                                  blurRadius: 6),
                            ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("asset/images/sick-ic.png", width: 39.w, height: 39.h,),
                            SizedBox(height: 5.h),
                            Text("Ajukan Izin", style: homeCategoryTitle,),
                          ],
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/maps');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        padding: EdgeInsets.zero,
                        elevation: 0,
                      ),
                      child: Container(
                        width: 76.w,
                        height: 76.h,
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(6.r),
                            border: Border.all(
                              color: grayBorder,
                              width: 1.w,
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: HexColor('#C9C9C9').withOpacity(0.10),
                                  offset: const Offset(0, 4),
                                  blurRadius: 6),
                            ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("asset/images/map-ic.png", width: 39.w, height: 39.h,),
                            SizedBox(height: 5.h),
                            Text("Lokasi", style: homeCategoryTitle,),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 13.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Aktifitasmu",
                    style: btnItemPageHome,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/history');
                    },
                    child: Text(
                      "show all",
                      style: allHome,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              hasPresence(nis) != false
                  ? FirebaseAnimatedList(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      query: dbPresence.limitToLast(5),
                      itemBuilder: (BuildContext context, DataSnapshot snapshot,
                          Animation<double> animation, int index) {
                        Map presence = snapshot.value as Map;
                        Map validPresence = {};

                        presence.forEach((key, val) {
                          if (key == "student_id" &&
                              "${presence[key]}" == nis) {
                            validPresence = presence;
                          }
                        });
                        // (snapshot.value as Map).forEach((key, val) {
                        //   print(presence.know)
                        // });

                        presence['key'] = snapshot.key;
                        validPresence['key'] = snapshot.key;
                        // print(presence['time_in']);
                        return itemList(presence: validPresence);
                      })
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Lottie.asset(
                            'asset/images/93134-not-found.json',
                            width: 140.w,
                            fit: BoxFit.cover,
                            repeat: true,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Wah, Presensi\nkamu masih kosong",
                              style: elseTitle,
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text(
                              "Yuk, kita hadir\ndi sekolah tepat waktu",
                              style: elseDesc,
                            ),
                          ],
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: BotNavBar(),
    );
  }

  Widget itemList({required presence}) {
    String presenceIn = presence["time_in"] == null
        ? "0000-00-00 00:00:00"
        : presence["time_in"];
    String presenceOut = presence["time_out"] == null
        ? "0000-00-00 00:00:00"
        : presence["time_out"];
    String timeIn = "empty";
    String timeOut = "empty";

    if (presenceIn != "0000-00-00 00:00:00") {
      DateTime timeInTime = DateTime.parse(presenceIn);
      timeInTime = timeInTime.add(const Duration(hours: 7));
      timeIn = DateFormat('HH:mm:ss').format(timeInTime);
    } else {
      timeIn = "0";
    }

    if (presenceOut != "0000-00-00 00:00:00") {
      DateTime timeOutTime = DateTime.parse(presenceOut);
      timeOutTime = timeOutTime.add(const Duration(hours: 7));
      timeOut = DateFormat('HH:mm:ss').format(timeOutTime);
    } else {
      timeOut = "0";
    }

    String dateNow;
    if (presence["time_in"] != null) {
      String fullDate = presence["time_in"];
      DateTime fullDateTime = DateTime.parse(fullDate);
      dateNow = DateFormat('d MMM yy').format(fullDateTime);
    } else {
      dateNow = "";
    }

    if (timeIn == "0") timeIn = "-";
    if (timeOut == "0") timeOut = "-";

    return timeIn == "-" && timeOut == "-"
        ? SizedBox()
        : Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 11.h, horizontal: 15.w),
                width: 329.w,
                height: 74.h,
                decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(6.r),
                    border: Border.all(
                      color: grayBorder,
                      width: 1.w,
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: HexColor('#C9C9C9').withOpacity(0.10),
                          offset: const Offset(0, 4),
                          blurRadius: 6),
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 190.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Masuk",
                                style: activityLabel,
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              Container(
                                child: LayoutBuilder(
                                    builder: (context, constraints) {
                                  if (presence["status"] == 0) {
                                    return Row(
                                      children: [
                                        Text(
                                          "unpresent",
                                          style: unpresent,
                                        ),
                                        Text(
                                          "[A]",
                                          style: unpresentA,
                                        ),
                                      ],
                                    );
                                  } else if (presence["status"] == 3) {
                                    return Row(
                                      children: [
                                        Text(
                                          "unpresent",
                                          style: unpresent,
                                        ),
                                        Text(
                                          "[S]",
                                          style: unpresentS,
                                        ),
                                      ],
                                    );
                                  } else if (presence["status"] == 4) {
                                    return Row(
                                      children: [
                                        Text(
                                          "unpresent",
                                          style: unpresent,
                                        ),
                                        Text(
                                          "[I]",
                                          style: unpresentI,
                                        ),
                                      ],
                                    );
                                  } else {
                                    return Text(
                                      timeIn,
                                      style: activityTime,
                                      textAlign: TextAlign.center,
                                    );
                                  }
                                }),
                              ),
                            ],
                          ),
                          Container(
                            width: 1.w,
                            height: 30.h,
                            color: grayUnselect,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Keluar",
                                style: activityLabel,
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              Container(
                                child: LayoutBuilder(
                                    builder: (context, constraints) {
                                  if (presence["status"] == 0) {
                                    return Row(
                                      children: [
                                        Text(
                                          "unpresent",
                                          style: unpresent,
                                        ),
                                        Text(
                                          "[A]",
                                          style: unpresentA,
                                        ),
                                      ],
                                    );
                                  } else if (presence["status"] == 3) {
                                    return Row(
                                      children: [
                                        Text(
                                          "unpresent",
                                          style: unpresent,
                                        ),
                                        Text(
                                          "[S]",
                                          style: unpresentS,
                                        ),
                                      ],
                                    );
                                  } else if (presence["status"] == 4) {
                                    return Row(
                                      children: [
                                        Text(
                                          "unpresent",
                                          style: unpresent,
                                        ),
                                        Text(
                                          "[I]",
                                          style: unpresentI,
                                        ),
                                      ],
                                    );
                                  } else {
                                    return Text(
                                      timeOut,
                                      style: activityTime,
                                    );
                                  }
                                }),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Text(
                      dateNow,
                      style: activityDateGray,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
            ],
          );
  }

  AwesomeDialog buildAwesomeDialogSuccessOutPresence(BuildContext context) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      title: 'Presensi Berhasil!',
      titleTextStyle: popUpWarningTitle,
      desc: 'Kamu sudah melakukan presensi keluar',
      descTextStyle: popUpWarningDesc,
      buttonsTextStyle: whiteOnBtnSmall,
      buttonsBorderRadius: BorderRadius.circular(6.r),
      btnOkColor: btnMain,
      showCloseIcon: false,
      btnOkText: 'Kembali',
      btnOkOnPress: () {},
    );
  }

  AwesomeDialog buildAwesomeDialogNotInArea(BuildContext context) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      title: 'Warning',
      titleTextStyle: popUpWarningTitle,
      desc: 'Kamu tidak berada dalam area SMKN 4 Bandung',
      descTextStyle: popUpWarningDesc,
      buttonsTextStyle: whiteOnBtnSmall,
      buttonsBorderRadius: BorderRadius.circular(6.r),
      btnOkColor: btnMain,
      showCloseIcon: false,
      btnOkText: 'Kembali',
      btnOkOnPress: () {},
    );
  }

  AwesomeDialog buildAwesomeDialogSuccessInPresence(BuildContext context) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      title: 'Presensi Berhasil!',
      titleTextStyle: popUpWarningTitle,
      desc: 'Kamu sudah melakukan presensi masuk',
      descTextStyle: popUpWarningDesc,
      buttonsTextStyle: whiteOnBtnSmall,
      buttonsBorderRadius: BorderRadius.circular(6.r),
      btnOkColor: btnMain,
      showCloseIcon: false,
      btnOkText: 'Kembali',
      btnOkOnPress: () {},
    );
  }

  AwesomeDialog buildAwesomeDialogNotInTime(BuildContext context) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      title: 'Warning',
      titleTextStyle: popUpWarningTitle,
      desc: 'Kamu belum bisa presensi sekarang',
      descTextStyle: popUpWarningDesc,
      buttonsTextStyle: whiteOnBtnSmall,
      buttonsBorderRadius: BorderRadius.circular(6.r),
      btnOkColor: btnMain,
      showCloseIcon: false,
      btnOkText: 'Kembali',
      btnOkOnPress: () {},
    );
  }
}
