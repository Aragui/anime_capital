import 'package:anime_capital/pages/coming_series_page.dart';
import 'package:anime_capital/pages/home_page.dart';
import 'package:anime_capital/pages/providers_page.dart';
import 'package:anime_capital/tools/shared_preference.dart';
import 'package:flutter/material.dart';

class TabBarPages extends StatefulWidget {
  TabBarPages({Key? key}) : super(key: key);

  @override
  _TabBarPagesState createState() => _TabBarPagesState();
}

class _TabBarPagesState extends State<TabBarPages>
    with SingleTickerProviderStateMixin {
  TabController? _controller;
  String? _provider;

  bool showed = false;

  final _prefs = SharedPreference.instance;

  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  Widget _showAnime() {
    if (_provider != null) {
      return HomePage();
    }
    return ProvidersPage(
      onClic: (provider) {
        _prefs.setProvider = provider["key"];
        setState(() {
          _provider = provider["key"];
        });
      },
    );
  }

  void showSurvey(BuildContext context) {
    if (_prefs.answered == null) {
      if (showed == false) {
        setState(() {
          showed = true;
        });
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: BorderSide(
                        color: Theme.of(context).secondaryHeaderColor,
                        width: 3,
                        style: BorderStyle.solid)),
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                content: Container(
                  height: 100,
                  width: 150,
                  alignment: Alignment.center,
                  child: Text("Nos gustaria saber tu opinión de la app."),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        _prefs.setAnswered = true;
                        Navigator.of(context).pop();
                        Navigator.of(context).pushNamed("/webview", arguments: {
                          "uri":
                              "https://docs.google.com/forms/d/e/1FAIpQLSc8aYenpYuJ_aR6GZDAqeHW55ru55Dy1cF2QtrfGJsb8p475g/viewform"
                        });
                      },
                      child: Text('Ir a la encuesta')),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Recuerdamelo más tarde')),
                ],
              );
            });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 15), () => showSurvey(context));
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(bottom: 50),
        child: TabBarView(
          controller: _controller,
          children: [
            _showAnime(),
            ComingSeriesPage(),
          ],
        ),
      ),
      bottomSheet: Material(
        color: Color(0xFF1B233D),
        child: TabBar(
          overlayColor: MaterialStateProperty.all<Color>(Color(0xFFE2BDE2)),
          controller: _controller,
          tabs: [
            Tab(
              text: "Ver anime",
            ),
            Tab(
              text: "Proximamente",
            ),
          ],
        ),
      ),
    );
  }
}
