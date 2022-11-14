import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sence_sence/shared/theme.dart';
import 'package:sence_sence/widget/appbar.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    itemCount: 5,
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 11.h, horizontal: 15.w),
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
                                      color:
                                          HexColor('#C9C9C9').withOpacity(0.10),
                                      offset: const Offset(0, 4),
                                      blurRadius: 6),
                                ]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Masuk",
                                          style: activityLabel,
                                        ),
                                        SizedBox(
                                          height: 4.h,
                                        ),
                                        Text(
                                          "06:51:07",
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Keluar",
                                          style: activityLabel,
                                        ),
                                        SizedBox(
                                          height: 4.h,
                                        ),
                                        Text(
                                          "-",
                                          style: activityTime,
                                        ),
                                      ],
                                    ),
                                  ],
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
                    }),
                ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    itemCount: 2,
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 11.h, horizontal: 15.w),
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
                                      color:
                                      HexColor('#C9C9C9').withOpacity(0.10),
                                      offset: const Offset(0, 4),
                                      blurRadius: 6),
                                ]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Masuk",
                                          style: activityLabel,
                                        ),
                                        SizedBox(
                                          height: 4.h,
                                        ),
                                        Text(
                                          "unpresent",
                                          style: unpresent,
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
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Keluar",
                                          style: activityLabel,
                                        ),
                                        SizedBox(
                                          height: 4.h,
                                        ),
                                        Text(
                                          "unpresent",
                                          style: unpresent,
                                        ),
                                      ],
                                    ),
                                  ],
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
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
