import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
 

  WebViewPage();

  @override
  WebViewPageState createState() =>
      WebViewPageState();
}

class WebViewPageState extends State<WebViewPage> {
 

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments! as Map;
  final String url=args["uri"];
  final String title=args["name"];
   print(args);
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Column(children: [
          Expanded(
              child: WebView(
                  initialUrl: url,
                  javascriptMode: JavascriptMode.unrestricted
              )
          )
        ])
    );
  }
}