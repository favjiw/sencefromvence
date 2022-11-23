import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:sence_sence/shared/theme.dart';
import 'package:sence_sence/widget/appbar.dart';
import 'package:lottie/lottie.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with SingleTickerProviderStateMixin {
  Query dbPresence = FirebaseDatabase.instance.ref().child('presence');
  late TabController tabController;
  String nis = "";

  Future<int> asyncNIS() async {
    return await SessionManager().get("user");
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

  @override
  void initState() {
    // TODO: implement initState
    tabController = TabController(length: 2, vsync: this);
    super.initState();
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildAppBar(context, "Riwayat"),
          SizedBox(
            height: 46.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 99.w,
                  height: 99.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                    border: Border.all(color: green, width: 4.w),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "100",
                        style: historyDayNumm,
                      ),
                      Text(
                        "hari",
                        style: historyDayTxt,
                      )
                    ],
                  ),
                ),
                Container(
                  width: 99.w,
                  height: 99.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                    border: Border.all(color: red, width: 4.w),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "2",
                        style: historyDayNumm,
                      ),
                      Text(
                        "hari",
                        style: historyDayTxt,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 24.h,
          ),
          TabBar(
            controller: tabController,
            labelColor: btnMain,
            indicatorColor: btnMain,
            unselectedLabelColor: grayUnselect,
            unselectedLabelStyle: historyUnSelectedLabel,
            labelStyle: historySelectedLabel,
            tabs: [Text("Hadir"), Text("Absen")],
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                hasPresence(nis) != false
                    ? SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 20.h),
                            FirebaseAnimatedList(
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                query: dbPresence,
                                itemBuilder: (BuildContext context,
                                    DataSnapshot snapshot,
                                    Animation<double> animation,
                                    int index) {
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
                                  return itemListIsPresent(
                                      presence: validPresence);
                                }),
                          ],
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset(
                            'asset/images/93134-not-found.json',
                            width: 140.w,
                            height: 140.h,
                            fit: BoxFit.cover,
                            repeat: true,
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Text(
                            "Wah, Presensi\nkamu masih kosong",
                            style: elseTitleHistory,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                hasPresence(nis) != false
                    ? SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 20.h),
                            FirebaseAnimatedList(
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                query: dbPresence,
                                itemBuilder: (BuildContext context,
                                    DataSnapshot snapshot,
                                    Animation<double> animation,
                                    int index) {
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
                                  return itemListIsNotPresent(
                                      presence: validPresence);
                                }),
                          ],
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset(
                            'asset/images/93134-not-found.json',
                            width: 140.w,
                            height: 140.h,
                            fit: BoxFit.cover,
                            repeat: true,
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Text(
                            "Wah, Presensi\nkamu masih kosong",
                            style: elseTitleHistory,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget itemListIsPresent({required presence}) {
    String statusFromPresence = presence["status"];
    String timeIn =
        presence["time_in"] != null ? presence["time_in"].split(" ").last : "-";
    String timeOut = presence["time_out"] != null
        ? presence["time_out"].split(" ").last
        : "-";
    String fullDate = presence["time_in"];
    DateTime fullDateTime = DateTime.parse(fullDate);
    String dateNow = DateFormat('d MMM yy').format(fullDateTime);
    // String timePresenceIn = presence["time_in"];
    // DateTime fullTimeIn = DateTime.parse(timePresenceIn);
    // String timeIn = DateFormat('hh:m:s').format(fullTimeIn);
    // String timePresenceOut = presence["time_out"];
    // DateTime fullTimeOut = DateTime.parse(timePresenceOut);
    // String timeOut = DateFormat('hh:m:s').format(fullTimeOut);
    if (timeIn == "0") timeIn = "-";
    if (timeOut == "0") timeOut = "-";

    bool checkStatus(String status) {
      return status == "1" || status == "2";
    }

    bool checkTimeStrip(String timeIn, String timeOut) {
      late bool isCheckTrue;
      if (timeIn != "-" || timeOut != "-") {
        isCheckTrue = true;
      } else {
        isCheckTrue = false;
      }
      return isCheckTrue;
    }

    return Container(
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (checkStatus(statusFromPresence) &&
              checkTimeStrip(timeIn, timeOut)) {
            return Column(
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 11.h, horizontal: 15.w),
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
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }

  Widget itemListIsNotPresent({required presence}) {
    String statusFromPresence = presence["status"];
    String timeIn =
        presence["time_in"] != null ? presence["time_in"].split(" ").last : "-";
    String timeOut = presence["time_out"] != null
        ? presence["time_out"].split(" ").last
        : "-";
    String fullDate = presence["time_in"];
    DateTime fullDateTime = DateTime.parse(fullDate);
    String dateNow = DateFormat('d MMM yy').format(fullDateTime);
    // String timePresenceIn = presence["time_in"];
    // DateTime fullTimeIn = DateTime.parse(timePresenceIn);
    // String timeIn = DateFormat('hh:m:s').format(fullTimeIn);
    // String timePresenceOut = presence["time_out"];
    // DateTime fullTimeOut = DateTime.parse(timePresenceOut);
    // String timeOut = DateFormat('hh:m:s').format(fullTimeOut);
    if (timeIn == "0") timeIn = "-";
    if (timeOut == "0") timeOut = "-";

    bool checkStatus(String status) {
      return status == "0" || status == "3" || status == "4";
    }

    bool checkTimeStrip(String timeIn, String timeOut) {
      late bool isCheckTrue;
      if (timeIn != "-" || timeOut != "-") {
        isCheckTrue = true;
      } else {
        isCheckTrue = false;
      }
      return isCheckTrue;
    }

    return Container(
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (checkStatus(statusFromPresence)) {
            return Column(
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 11.h, horizontal: 15.w),
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
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
