import 'dart:ui';

import 'package:anime_capital/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AniCap',
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (_) => HomePage(),
      },
      darkTheme: ThemeData(
        accentColor: Colors.white,
        primaryColor: Color(0xFFF0A9B5),
        secondaryHeaderColor: Color(0xFFE3687E),
        scaffoldBackgroundColor: Color(0xFF49382A),
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
                  Shadow(color: Colors.red, blurRadius: 5, offset: Offset(3, 3)),
                ],
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        fontFamily: 'Osaka-Sans Serif',
        // brightness: Brightness.dark
      ),
      themeMode: ThemeMode.dark,
    );
  }
}
