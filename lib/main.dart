import 'dart:ui';

import 'package:anime_capital/pages/home_page.dart';
import 'package:anime_capital/pages/providers_page.dart';
import 'package:anime_capital/tools/shared_preference.dart';
import 'package:flutter/material.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AniCap',
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (_) => ProvidersPage(),
        "/last-emited": (_) => HomePage(),
      },
      theme: ThemeData(
        primaryColor: Color(0xFF563A10),
        secondaryHeaderColor: Color(0xFFFFA6A6),
        scaffoldBackgroundColor: Color(0xFFFDEDAD),
        iconTheme: IconThemeData(color: Colors.white),
        textTheme: TextTheme(
          headline6: TextStyle(
            color: Colors.white,
            letterSpacing: 1,
            fontSize: 17
          ),
            headline4: TextStyle(
                letterSpacing: 3,
                shadows: [
                  Shadow(color: Colors.white, blurRadius: 3, offset: Offset(-1, -1)),
                  Shadow(color: Color(0xFFFFA6A6) /*Color(0xFFFDEDAD)*/, blurRadius: 5, offset: Offset(3, 3)),
                ],
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        fontFamily: 'Osaka-Sans Serif',
        // brightness: Brightness.dark
      ),
    );
  }
}
