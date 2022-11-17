import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sence_sence/shared/theme.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sence_sence/widget/botnavbar.dart';
import 'package:shared_preferences/shared_preferences.dart';


String _hash(String text) {
  var bytes = utf8.encode(text);
  var value = sha256.convert(bytes);

  return "$value";
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _nis = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
              Container(
                width: 1.sw,
                height: 243.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [btnMain, HexColor('#428CFF')],
                  ),
                  image: const DecorationImage(
                    alignment: Alignment.bottomCenter,
                    fit: BoxFit.contain,
                    image: AssetImage('asset/images/login-bg-img.png'),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 18.w),
                      child: Text(
                        "Sence",
                        style: senceLoginTitle,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 11.w,
                    ),
                    Text(
                      "Login",
                      style: LoginTitle,
                    ),
                    SizedBox(
                      height: 11.w,
                    ),
                    Text(
                      "NIS",
                      style: inputLabelLogin,
                    ),
                    SizedBox(
                      height: 11.w,
                    ),
                    TextField(
                      controller: _nis,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(10),
                      ],
                      keyboardType: TextInputType.number,
                      enableSuggestions: false,
                      style: inputTxt,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.r),
                          borderSide: BorderSide(width: 1, color: grayBorder),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 14.h, horizontal: 12.w),
                        hintText: '1234567890',
                        hintStyle: passHint,
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.person),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 11.w,
                    ),
                    Text(
                      "Password",
                      style: inputLabelLogin,
                    ),
                    SizedBox(
                      height: 11.w,
                    ),
                    TextField(
                      controller: _password,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      style: inputTxt,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.r),
                          borderSide: BorderSide(width: 1, color: grayUnselect),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 14.h, horizontal: 13.w),
                        hintText: 'Password',
                        hintStyle: passHint,
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.remove_red_eye),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Lupa kata sandi?',
                          style: forgotPassword,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Center(
                        child: SizedBox(
                      width: 321.w,
                      height: 55.h,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5.r),
                        child: ElevatedButton(
                          onPressed: () async {
                            bool valid = false;
                            String nis = _nis.text;
                            String password = _password.text;
                            final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                            sharedPreferences.setString('nis', nis);

                            final snapshot = await FirebaseDatabase.instance.ref().child("users").get();

                            if (snapshot.exists) {
                              (snapshot.value as Map<dynamic, dynamic>)
                                  .forEach((key, val) {
                                    if("${val["id"]}" == nis && "${val["password"]}" == _hash(password)) {
                                      print("Found!");
                                      valid = true;
                                    }
                              });
                            }
                            if(valid) {
                              print("Session exist : ${
                                  await SessionManager().containsKey("id") == true ? "true": "false"
                              }");
                              await SessionManager().set("user", nis);
                              print(await SessionManager().get("user"));
                              Navigator.pushNamedAndRemoveUntil( context, '/nav-bar', (route) => false);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const BotNavBar(),
                                  ));
                            }else {
                              Navigator.pushNamedAndRemoveUntil( context, '/nav-bar', (route) => false);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const BotNavBar(),
                                  ));
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(btnMain),
                          ),
                          child: Text(
                            "Login",
                            style: whiteOnBtn,
                          ),
                        ),
                      ),
                    )),
                    SizedBox(
                      height: 20.h,
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
