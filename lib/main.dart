import 'dart:ui';

import 'package:anime_capital/pages/home_page_old.dart';
import 'package:anime_capital/pages/providers_page.dart';
import 'package:anime_capital/tools/shared_preference.dart';
import 'package:anime_capital/widgets/tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'pages/web_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    SharedPreference.initPrefs();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
        overlays: [SystemUiOverlay.bottom]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AniCap',
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (_) => TabBarPages(),
        // "/": (_) => ProvidersPage(),
        "/last-emited": (_) => HomePage(),
        "/webview": (_) => WebViewPage()
      },
      // onGenerateRoute: (RouteSettings settings) {
      //   late Widget page;
      //   print(settings.name);
      //   switch (settings.name) {
      //     case '/':
      //       page = ProvidersPage();
      //       break;
      //     case "/last-emited":
      //       page = HomePage();
      //       break;
      //   }

      //   return MaterialPageRoute(
      //       builder: (BuildContext context) {
      //         return page;
      //       },
      //       settings: settings);
      // },
      theme: ThemeData(
          primaryColor: Color(0xFF563A10),
          secondaryHeaderColor: Color(0xFF780119),
          scaffoldBackgroundColor: Color(0xFF020b28),
          iconTheme: IconThemeData(color: Colors.white),
          appBarTheme: AppBarTheme(backgroundColor: Color(0xFF780119)),
          textTheme: TextTheme(
              subtitle1: TextStyle(
                  color: Colors.white, letterSpacing: 1, fontSize: 17),
              subtitle2: TextStyle(
                  color: Colors.white, letterSpacing: 1, fontSize: 16),
              headline6: TextStyle(
                  color: Colors.white, letterSpacing: 1, fontSize: 17),
              headline4: TextStyle(
                  letterSpacing: 5,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              headline5: TextStyle(
                color: Colors.white,
                letterSpacing: 1,
                fontSize: 22
              )),
          fontFamily: 'Osaka-Sans Serif',
          tabBarTheme: TabBarTheme(
              indicator: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          color: Color(0xFF780119),
                          style: BorderStyle.solid,
                          width: 8))))
          // brightness: Brightness.dark
          ),
    );
  }
}
