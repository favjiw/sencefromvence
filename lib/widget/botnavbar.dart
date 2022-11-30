import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:sence_sence/home/controller/maps_controller.dart';
import 'package:sence_sence/home/home_screen.dart';
import 'package:sence_sence/profile/profile_screen.dart';
import 'package:sence_sence/shared/theme.dart';
import 'package:sence_sence/webview/webview_screen.dart';

class BotNavBar extends StatefulWidget {
  const BotNavBar({Key? key}) : super(key: key);


  @override
  State<BotNavBar> createState() => _BotNavBarState();
}

class _BotNavBarState extends State<BotNavBar> {
  int currentIndex = 0;
  MapController mapController = new MapController();


  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = HomeScreen();

  late int id;
  late String password;

  Future<int> fetchId() async {
    return await SessionManager().get("user");
  }

  Future<String> fetchPassword() async {
    return await SessionManager().get("pass");
  }

  _BotNavBarState();
  @override

  Widget build(BuildContext context) {
    fetchId().then((res) {
      setState(() {
        this.id = res;
      });
    });

    fetchPassword().then((res) {
      setState(() {
        this.password = res;
      });
    });
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      floatingActionButton: FloatingActionButton(
        child: Image.asset(
          'asset/images/scan-ic.png',
          width: 35.w,
          height: 35.h,
        ),
        onPressed: () {
          // Navigator.pushNamed(context, '/webview');
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WebViewScreen(nis: id, password: password,),
              ));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: SizedBox(
          height: 56.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.r),
                  child: MaterialButton(
                    onPressed: (){
                      setState(() {
                        currentScreen = HomeScreen();
                        currentIndex = 0;
                      });
                    },
                    minWidth: 100.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          currentIndex == 0
                              ? 'asset/images/home-ic-active.png'
                              : 'asset/images/home-ic-inactive.png',
                          width: 24.w,
                          height: 24.h,
                        ),
                        Text("Home", style: currentIndex == 0 ? botNavActive : botNavInactive,),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 20.h),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.r),
                  child: MaterialButton(
                    onPressed: (){
                      setState(() {
                        currentScreen = ProfileScreen();
                        currentIndex = 1;
                      });
                    },
                    minWidth: 100.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          currentIndex == 1
                              ? 'asset/images/profile-ic-active.png'
                              : 'asset/images/profile-ic-inactive.png',
                          width: 24.w,
                          height: 24.h,
                        ),
                        Text("Profile", style: currentIndex == 1 ? botNavActive : botNavInactive,),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
