import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:sence_sence/shared/theme.dart';
import 'package:sence_sence/widget/appbar.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:sence_sence/widget/botnavbar.dart';


class PermissionScreen extends StatefulWidget {
  const PermissionScreen({Key? key}) : super(key: key);

  @override
  State<PermissionScreen> createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
  bool _isSick = true;
  bool _isPermission = false;
  String reason = "sakit";
  String status = "3";
  late DateTime currentTime = DateTime.now();
  late String timeNow = DateFormat('yyyy-MM-dd H:m:s').format(DateTime.now());
  late String yearNow = DateFormat('yyyy-MM-dd').format(currentTime);
  late String timeReset = yearNow + " 00:00:00";
  int nis = 0;


  late DatabaseReference dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('presence');
  }

  Future<int> asyncNIS() async {
    return await SessionManager().get("user");
  }

  @override
  Widget build(BuildContext context) {
    asyncNIS().then((value) {
      setState(() {
        this.nis = value;
      });
    });
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        backgroundColor: neutral,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildAppBar(context, "Pengajuan Izin"),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30.h,
                    ),
                    Center(
                      child: Text("Harap isi data berikut!", style: permissionTitle,),
                    ),
                    SizedBox(height: 30.h,),
                    Text("Kenapa kamu ga masuk?", style: permissionSubTitle,),
                    SizedBox(height: 14.h,),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              _isSick = true;
                              _isPermission = false;
                              reason = "sakit";
                              status = "3";
                              print(_isSick);
                            });
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 50.w,
                                height: 50.h,
                                decoration: BoxDecoration(
                                  color: _isSick ? btnMain : grayUnselect,
                                  borderRadius: BorderRadius.circular(100.r),
                                ),
                                child: Center(
                                  child: Image.asset('asset/images/sick-img.png', width: 40.w, height: 40.h,),
                                ),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text("Sakit", style: _isSick ? permissionChoiceSelected : permissionChoiceUnSelected,),
                            ],
                          ),
                        ),
                        SizedBox(width: 33.w,),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _isSick = false;
                              _isPermission = true;
                              reason = "izin";
                              status = "4";
                              print(_isSick);
                            });
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 50.w,
                                height: 50.h,
                                decoration: BoxDecoration(
                                  color: _isPermission ? btnMain : grayUnselect,
                                  borderRadius: BorderRadius.circular(100.r),
                                ),
                                child: Center(
                                  child: Image.asset('asset/images/permission-img.png', width: 40.w, height: 40.h,),
                                ),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text("Izin", style: _isPermission ? permissionChoiceSelected : permissionChoiceUnSelected,),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.h,),
                    _isSick
                        ? Text("Sakit apa?", style: permissionSubTitle,)
                        : Text("Izin kenapa?", style: permissionSubTitle,),
                    SizedBox(height: 14.h,),
                    TextField(
                      keyboardType: TextInputType.text,
                      enableSuggestions: false,
                      style: inputTxt,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.r),
                          borderSide: BorderSide(width: 1, color: grayUnselect),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 13.w),
                        hintText: _isSick ? "Pusing kepala" : "Urusan keluarga",
                        hintStyle: passHint,
                      ),
                    ),
                    SizedBox(height: 30.h,),
                    Text("Bukti Foto", style: permissionSubTitle,),
                    SizedBox(height: 14.h,),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(vertical: 9.h, horizontal: 34.w),
          width: 1.sw,
          height: 65.h,
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    offset: const Offset(0, -1),
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 6,
                    spreadRadius: 0
                ),
              ]
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5.r),
            child: ElevatedButton(
              onPressed: () {
                print(reason);
                print(timeNow);
                print(nis);
                print(status);
                dbRef.push().set({
                  'reason': reason,
                  'status': status,
                  'student_id': nis,
                  'time_in': timeNow.toString(),
                  'time_out': timeReset,
                });
                buildSuccessPermissionDialog(context).show();
              },
              child: Text("Submit", style: whiteOnBtn,),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(btnMain),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

AwesomeDialog buildSuccessPermissionDialog(BuildContext context) {
  return AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      title: 'Berhasil mengajukan izin!',
      titleTextStyle: popUpWarningTitle,
      desc: 'Kamu sudah berhasil mengirimkan izin',
      descTextStyle: popUpWarningDesc,
      buttonsTextStyle: whiteOnBtnSmall,
      buttonsBorderRadius: BorderRadius.circular(6.r),
      btnOkColor: btnMain,
      showCloseIcon: false,
      btnOkText: 'Kembali Ke Home',
      btnOkOnPress: () {
        // Navigator.pushReplacement(context, MaterialPageRoute(
        //   builder: (BuildContext context) => BotNavBar(),
        // ),
        // );
        Navigator.pop(context);
      },
  );
}
