import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({Key? key}) : super(key: key);

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late InAppWebViewController _webViewController;

  // String url = "https://cautious-sniffle-production.up.railway.app/face/recognizer?expected=2021118620";

  String url =
      "https://cautious-sniffle-production.up.railway.app/face/recognizer?expected=";

  int? id;
  String? password;
  String? uri;
  bool isLoading = true;

  void snap() async {
    final idSnap = await SessionManager().get("user");
    final passSnap = await SessionManager().get("pass");
    // if (mounted) {
    setState(() {
      id = idSnap;
      password = passSnap;
      uri = '$url$id';
      isLoading = false;
    });
    // }
  }

  // Future<int> fetchId() async {
  //   return await SessionManager().get("user");
  // }
  //
  // Future<String> fetchPassword() async {
  //   return await SessionManager().get("pass");
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // fetchId().then((res) {
    //   setState(() {
    //     this.id = res;
    //   });
    // });

    // fetchPassword().then((res) {
    //   setState(() {
    //     this.password = res;
    //   });
    // });
    // int nis = widget.nis;
    // String password2 = widget.password;
    //
    // url = "$url$id";
    //
    // print("Redirecting to $url");
    snap();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : InAppWebView(
                initialUrlRequest: URLRequest(
                  url: Uri.tryParse(
                      "https://cautious-sniffle-production.up.railway.app/face/recognizer?expected=$id"
                      // '$uri',
                      ),
                ),
                initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(
                    mediaPlaybackRequiresUserGesture: false,
                  ),
                ),
                onWebViewCreated: (InAppWebViewController controller) {
                  _webViewController = controller;
                },
                androidOnPermissionRequest: (InAppWebViewController controller,
                    String origin, List<String> resources) async {
                  return PermissionRequestResponse(
                      resources: resources,
                      action: PermissionRequestResponseAction.GRANT);
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(
              "https://cautious-sniffle-production.up.railway.app/face/recognizer?expected=$id");
          Navigator.pop(context);
        },
        child: const Icon(Icons.arrow_back_ios_new_rounded),
      ),
    );
  }
}
