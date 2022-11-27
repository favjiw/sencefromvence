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

  late int id;
  late String password;

  Future<int> fetchId() async {
    return await SessionManager().get("user");
  }

  Future<String> fetchPassword() async {
    return await SessionManager().get("pass");
  }

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

    url = "$url?id=$id&w=$password";

    return id != null ? Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: url,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.arrow_back_ios_new_rounded),
      ),
    ) : Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: const WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: "",
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