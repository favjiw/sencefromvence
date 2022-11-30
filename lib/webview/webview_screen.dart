import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:webview_flutter/webview_flutter.dart' as WebView;
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewScreen extends StatefulWidget {
  final int nis;
  final String password;
  const WebViewScreen({Key? key, required this.nis, required this.password}) : super(key: key);
  // const WebViewScreen({Key? key}) : super(key: key);

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late InAppWebViewController _webViewController;
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
    int nis = widget.nis;
    String password2 = widget.password;

    url = "$url?id=$nis&w=$password2";

    return nis != null && password2 != null
        ? Scaffold(
            body: WillPopScope(
              onWillPop: () async {
                return true;
              },
              // child: WebView.WebView(
              //   initialUrl: url,
              //   javascriptMode: WebView.JavascriptMode.unrestricted,
              // ),
              child: InAppWebView(
                initialUrlRequest: URLRequest(
                  url: Uri.parse(url),
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
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back_ios_new_rounded),
            ),
          )
        : Scaffold(
            body: WillPopScope(
              onWillPop: () async {
                return true;
              },
              child: InAppWebView(
                initialUrlRequest: URLRequest(
                  url: Uri.parse(""),
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
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back_ios_new_rounded),
            ),
          );
  }
}
