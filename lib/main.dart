import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sence_sence/history/history_screen.dart';
import 'package:sence_sence/home/home_screen.dart';
import 'package:sence_sence/login/login_screen.dart';
import 'package:sence_sence/maps/maps_screen.dart';
import 'package:sence_sence/permission/permission_screen.dart';
import 'package:sence_sence/profile/profile_screen.dart';
import 'package:sence_sence/splash/splash_screen.dart';
import 'package:sence_sence/webview/webview_screen.dart';
import 'package:sence_sence/widget/botnavbar.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Permission.camera.request();
  await Permission.audio.request();
  await Permission.videos.request();
  await Permission.microphone.request();
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
              '/splash': (context) => const SplashScreen(),
              '/login': (context) => const LoginScreen(),
              '/nav-bar': (context) => const BotNavBar(),
              '/home': (context) => const HomeScreen(),
              '/history': (context) => const HistoryScreen(),
              '/permission': (context) => const PermissionScreen(),
              '/profile': (context) => const ProfileScreen(),
              '/maps': (context) => const MapsScreen(),
              '/webview': (context) => const WebViewScreen(),
            },
          );
        }
    );
  }
}

