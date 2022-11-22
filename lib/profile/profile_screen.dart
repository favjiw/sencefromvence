import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sence_sence/login/login_screen.dart';
import 'package:sence_sence/shared/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late DatabaseReference dbRef;
  int nis = 0;


  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('user');
    // String name = dbRef.equalTo(nis);
  }

  Future<int> asyncNIS() async {
    return await SessionManager().get("user");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: neutral,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 1.sw,
              height: 191.h,
              color: white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 36.h,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 22.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 35.w,
                          height: 35.h,
                        ),
                        Text("Profile", style: appBarTitle,),
                        SizedBox(
                          width: 35.w,
                          height: 35.h,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 45.h,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 9.w,
                      ),
                      Container(
                        width: 60.w,
                        height: 60.h,
                        decoration: BoxDecoration(
                            color: HexColor('#00DE19'), shape: BoxShape.circle),
                        child: Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100.r),
                            child: Image.network(
                              'https://upload.wikimedia.org/wikipedia/commons/thumb/4/49/Elon_Musk_2015.jpg/640px-Elon_Musk_2015.jpg',
                              width: 51.22.w,
                              height: 51.22.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 9.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Fairuztsani Kemal Setiawan",
                            style: settingName,
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            "202118620",
                            style: HomeTitle,
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 11.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.w),
              child: Text("Setelan", style: profileItemTitle,),
            ),
            SizedBox(height: 31.h,),
            InkWell(
              onTap: () {
                buildWarningDialog(context).show();
              },
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 22.w),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Notifikasi",
                          style: profileItem,
                        ),
                        Icon(
                          Icons.keyboard_arrow_right_rounded,
                          color: HexColor('#8B8B8B'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 18.h,),
                  Container(
                    width: 1.sw,
                    height: 1.h,
                    color: HexColor('#8B8B8B').withOpacity(0.25),
                  ),
                ],
              ),
            ),
            SizedBox(height: 17.h,),
            InkWell(
              onTap: () {
                buildWarningDialog(context).show();
              },
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 22.w),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Tema",
                          style: profileItem,
                        ),
                        Row(
                          children: [
                            Text(
                              "light",
                              style: profileItem,
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            Icon(
                              Icons.keyboard_arrow_right_rounded,
                              color: HexColor('#8B8B8B'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 18.h,),
                  Container(
                    width: 1.sw,
                    height: 1.h,
                    color: HexColor('#8B8B8B').withOpacity(0.25),
                  ),
                ],
              ),
            ),
            SizedBox(height: 13.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.w),
              child: Text("Akun", style: profileItemTitle,),
            ),
            SizedBox(height: 31.h,),
            InkWell(
              onTap: () {
                buildWarningDialog(context).show();
              },
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 22.w),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Informasi Pengguna",
                          style: profileItem,
                        ),
                        Icon(
                          Icons.keyboard_arrow_right_rounded,
                          color: HexColor('#8B8B8B'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 18.h,),
                  Container(
                    width: 1.sw,
                    height: 1.h,
                    color: HexColor('#8B8B8B').withOpacity(0.25),
                  ),
                ],
              ),
            ),
            SizedBox(height: 18.h),
            InkWell(
              onTap: () {
                buildWarningDialog(context).show();
              },
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 22.w),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Bahasa",
                          style: profileItem,
                        ),
                        Icon(
                          Icons.keyboard_arrow_right_rounded,
                          color: HexColor('#8B8B8B'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 18.h,),
                  Container(
                    width: 1.sw,
                    height: 1.h,
                    color: HexColor('#8B8B8B').withOpacity(0.25),
                  ),
                ],
              ),
            ),
            SizedBox(height: 18.h),
            InkWell(
              onTap: () {
                buildLogoutDialog(context).show();
              },
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 22.w),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Logout",
                          style: profileItemLogout,
                        ),
                        Icon(
                          Icons.keyboard_arrow_right_rounded,
                          color: red,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 18.h,),
                  Container(
                    width: 1.sw,
                    height: 1.h,
                    color: HexColor('#8B8B8B').withOpacity(0.25),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AwesomeDialog buildWarningDialog(BuildContext context) {
    return AwesomeDialog(
                context: context,
                dialogType: DialogType.warning,
                headerAnimationLoop: false,
                animType: AnimType.bottomSlide,
                title: 'Maaf :(',
                titleTextStyle: popUpWarningTitle,
                desc: 'Fitur ini masih dalam tahap pengembangan',
                descTextStyle: popUpWarningDesc,
                buttonsTextStyle: whiteOnBtnSmall,
                buttonsBorderRadius: BorderRadius.circular(6.r),
                btnOkColor: btnMain,
                showCloseIcon: false,
                btnOkText: 'Kembali',
                btnOkOnPress: () {},
              );
  }

  AwesomeDialog buildLogoutDialog(BuildContext context) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      title: 'Apakah Kamu yakin ingin logout?',
      titleTextStyle: popUpWarningTitle,
      desc: 'Kamu perlu login kembali setelah melakukan logout',
      descTextStyle: popUpWarningDesc,
      buttonsTextStyle: whiteOnBtnSmall,
      buttonsBorderRadius: BorderRadius.circular(6.r),
      btnOkColor: red,
      btnCancelColor: btnMain,
      showCloseIcon: false,
      btnOkText: 'Logout',
      btnOkOnPress: () async {
        final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.remove('nis');
        // Navigator.pushNamed(context, '/login');
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (BuildContext context) => LoginScreen(),
          ),
        );
      },
      btnCancelOnPress: (){}
    );
  }
}
