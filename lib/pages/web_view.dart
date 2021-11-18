import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/services.dart';
class WebViewPage extends StatefulWidget {
 

  WebViewPage();

  @override
  WebViewPageState createState() =>
      WebViewPageState();
}

class WebViewPageState extends State<WebViewPage> {
  bool _charged = false;

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  }

  @override
  void dispose() {
    
    super.dispose();
    SystemChrome.setEnabledSystemUIOverlays([
      SystemUiOverlay.top, SystemUiOverlay.bottom
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
  final url=args["uri"];
  // final title=args["title"];
   print(args);
    return Scaffold(
        
        body: SafeArea(
          child: WebView(
              initialUrl: url,
              javascriptMode: JavascriptMode.unrestricted,
              gestureNavigationEnabled: true,
              navigationDelegate: (NavigationRequest request){
                if(_charged){
                  return NavigationDecision.prevent;
                }
                setState(() {
                  _charged = !_charged;
                });
                return NavigationDecision.navigate;
              },
              
          ),
        )
    );
  }
}