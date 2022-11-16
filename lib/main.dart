import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sence_sence/history/history_screen.dart';
import 'package:sence_sence/home/home_screen.dart';
import 'package:sence_sence/login/login_screen.dart';
import 'package:sence_sence/maps/maps_screen.dart';
import 'package:sence_sence/permission/permission_screen.dart';
import 'package:sence_sence/profile/profile_screen.dart';
import 'package:sence_sence/route/route.dart';
import 'package:sence_sence/splash/splash_screen.dart';
import 'package:sence_sence/widget/botnavbar.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyCs4WR9qTVA3C8cB8sAOdk7iu6TMFlEXRE",
        appId: "App id here",
        messagingSenderId: "Messaging sender id here",
        projectId: "project id here"),
  );

  runApp(const SenceApp());
}

class SenceApp extends StatefulWidget {
  const SenceApp({Key? key}) : super(key: key);

  @override
  State<SenceApp> createState() => _SenceAppState();
}

class _SenceAppState extends State<SenceApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 640),
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            // onGenerateRoute: RouteGenerator.generateRoute,
            // home: HomeScreen(),
            initialRoute: '/splash',
            routes: <String, WidgetBuilder>{
              '/splash': (context) => SplashScreen(),
              '/login': (context) => LoginScreen(),
              '/nav-bar': (context) => BotNavBar(),
              '/home': (context) => HomeScreen(),
              '/history': (context) => HistoryScreen(),
              '/permission': (context) => PermissionScreen(),
              '/profile': (context) => ProfileScreen(),
              '/maps': (context) => MapsScreen(),
            },
          );
        }
    );
  }
}

