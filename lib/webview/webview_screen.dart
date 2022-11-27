import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({Key? key}) : super(key: key);

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  String url = "https://flask-facerec.herokuapp.com/login";
  int nis = 0;
  int nis2 = 2021118576;
  String pass2 = 'ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f';
  int id = 0;
  String pass = "not changed";

  Future<dynamic> getFromSession(String key) async {
    return await SessionManager().get(key);
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

    getFromSession("user").then((res) {
      setState(() {
        this.id = res;
      });
    });

    getFromSession("pass").then((res) {
      setState(() {
        this.pass = res;
      });
    });

    String with_get_params = "?id=$id";
    with_get_params += "&w=$pass";
    // print(id);
    // print(pass);
    print(id);
    print(nis2);
    print(pass2);
    print(pass);


    return Scaffold(

      body: WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: "$url?id=$nis2&w=$pass2",
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.arrow_back_ios_new_rounded),
      ),
    );
  }
}