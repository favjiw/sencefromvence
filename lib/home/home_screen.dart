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
import 'package:webview_flutter/webview_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Query dbPresence = FirebaseDatabase.instance.ref().child('presence');

  late bool canPresent;
  late DateTime currentTime = DateTime.now();
  late String yearNow = DateFormat('yyyy-MM-dd').format(DateTime.now());
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

  MapController mapController = new MapController();

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

  @override
  Widget build(BuildContext context) {
    asyncNIS().then((value) {
      setState(() {
        this.nis = '$value';
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
                          'Selamat Siang',
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
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: HexColor('#00DE19'),
                      ),
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100.r),
                          child: Image.network(
                            'https://www.biography.com/.image/ar_1:1%2Cc_fill%2Ccs_srgb%2Cfl_progressive%2Cq_auto:good%2Cw_1200/MTc5OTk2ODUyMTMxNzM0ODcy/gettyimages-1229892983-square.jpg',
                            width: 35.w,
                            height: 35.h,
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
                                'asset/images/hourglass.png',
                                width: 13.w,
                                height: 21.h,
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
                                  print(mapController.isInSelectedArea);
                                  if (mapController.isInSelectedArea == true) {

                                    buildAwesomeDialogSuccessInPresence(context).show();
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
                          } else if (currentTime.isAfter(presenceOutStart) &&
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
                                    buildAwesomeDialogSuccessOutPresence(
                                        context).show();
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
                height: 13.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 7.w),
                child: Text(
                  "Jl. Kliningan No.6, Turangga, Kecamatan Lengkong, Kota Bandung, Jawa Barat",
                  style: addressHome,
                ),
              ),
              SizedBox(
                height: 13.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 153.w,
                    height: 65.h,
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
                        Navigator.pushNamed(context, '/history');
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: white,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Lihat Riwayat",
                            style: btnItemPageHome,
                          ),
                          Image.asset(
                            "asset/images/arrow-right-ic.png",
                            width: 24.w,
                            height: 24.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 153.w,
                    height: 65.h,
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
                        Navigator.pushNamed(context, '/permission');
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: white,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Ajukan Izin",
                            style: btnItemPageHome,
                          ),
                          Image.asset(
                            "asset/images/arrow-right-ic.png",
                            width: 24.w,
                            height: 24.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
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

  Widget itemList({required presence}) {
    String timeIn =
        presence["time_in"] != null ? presence["time_in"].split(" ").last : "-";
    String timeOut = presence["time_out"] != null
        ? presence["time_out"].split(" ").last
        : "-";

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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Masuk",
                                style: activityLabel,
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              Text(
                                timeIn,
                                style: activityTime,
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 30.w,
                          ),
                          Container(
                            width: 1.w,
                            height: 30.h,
                            color: grayUnselect,
                          ),
                          SizedBox(
                            width: 30.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Keluar",
                                style: activityLabel,
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              Text(
                                timeOut,
                                style: activityTime,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "07 Nov 22",
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
}
