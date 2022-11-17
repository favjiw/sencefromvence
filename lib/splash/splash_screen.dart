import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sence_sence/shared/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? finalNis;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  Future getValidationData() async{
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var obtainedNis = sharedPreferences.getString('nis');
    setState(() {
      finalNis = obtainedNis!;
    });
    print(finalNis);
  }

  @override
  void initState() {
    // Timer(Duration(seconds: 3), () {
    //   Navigator.pushNamedAndRemoveUntil( context, '/login', (route) => false);
    // });
    getValidationData().whenComplete(() async {
      Timer(const Duration(seconds: 2), () => Navigator.pushNamedAndRemoveUntil( context, finalNis == null ? '/login' : '/nav-bar', (route) => false));
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark, // here what you need
          statusBarIconBrightness: Brightness.dark, // here is what you need,
          statusBarColor: HexColor('#F5F5F5'),
          systemNavigationBarColor: Colors.black.withOpacity(0.8)),
      child: Scaffold(
        backgroundColor: HexColor('#F6FDFF'),
        body: Stack(
          children: [
            Positioned(
              top: 125.h,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 53.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'asset/images/logo.png',
                      width: 255.w,
                      height: 255.h,
                    ),
                    SizedBox(
                      height: 36.h,
                    ),
                    Text(
                      'Sence',
                      style: splashAppName,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 24.h,
                  child: Padding(
                    padding: EdgeInsets.only(left: 83.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'For',
                          style: splashFor,
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          'SMKN 4 BANDUNG',
                          style: splashFrom,
                        ),
                      ],
              ),
                  ),
            )
          ],
        ),
      ),
    );
  }
}
