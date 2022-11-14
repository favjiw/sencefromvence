// import 'package:flutter/material.dart';
// import 'package:sence_sence/history/history_screen.dart';
// import 'package:sence_sence/home/home_screen.dart';
// import 'package:sence_sence/permission/permission_screen.dart';
// import 'package:sence_sence/profile/profile_screen.dart';
//
// class RouteGenerator {
//   static Route<dynamic> generateRoute(RouteSettings settings) {
//     // jika ingin mengirim argument
//     // final args = settings.arguments;
//
//     switch (settings.name) {
//       case '/home':
//         return MaterialPageRoute(builder: (_) => HomeScreen());
//       case '/profile':
//         return MaterialPageRoute(builder: (_) => ProfileScreen());
//       case '/history':
//         return MaterialPageRoute(builder: (_) => HistoryScreen());
//       case '/permission':
//         return MaterialPageRoute(builder: (_) => PermissionScreen());
//     // return MaterialPageRoute(builder: (_) => AboutPage(args));
//       default:
//         return _errorRoute();
//     }
//   }
//
//   static Route<dynamic> _errorRoute() {
//     return MaterialPageRoute(builder: (_) {
//       return Scaffold(
//         appBar: AppBar(title: Text("Error")),
//         body: Center(child: Text('Error page')),
//       );
//     });
//   }
// }