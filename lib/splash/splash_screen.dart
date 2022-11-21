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
  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedNis = sharedPreferences.getString('nis');
    setState(() {
      finalNis = obtainedNis!;
    });
    print(finalNis);
  }

  @override
  void initState() {
    getValidationData().whenComplete(() async {
      Timer(const Duration(seconds: 2), () => Navigator.pushNamedAndRemoveUntil( context, finalNis == null ? '/login' : '/nav-bar', (route) => false));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light, // here what you need
          statusBarIconBrightness: Brightness.light, // here is what you need,
          statusBarColor: Colors.black.withOpacity(0.2),
          systemNavigationBarColor: Colors.black.withOpacity(0.8)),
      child: Scaffold(
        backgroundColor: HexColor('#F6FDFF'),
        body: Container(
          width: 1.sw,
          height: 1.sh,
          decoration: BoxDecoration(
            gradient: RadialGradient(colors: [
              HexColor("#5295FD"),
              HexColor("#0063FC"),
            ]),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 155.h,
                left: 100.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Image.asset(
                        'asset/images/img-logo.png',
                        width: 155.w,
                        height: 255.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: 26.h,
                    ),
                    Text(
                      'Sence',
                      style: splashAppName,
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 150.w,
                bottom: 24.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'By',
                      style: splashBy,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      'Vence',
                      style: splashVence,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
