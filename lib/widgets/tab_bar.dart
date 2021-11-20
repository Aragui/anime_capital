import 'package:anime_capital/pages/coming_series_page.dart';
import 'package:anime_capital/pages/home_page_old.dart';
import 'package:anime_capital/pages/providers_page.dart';
import 'package:anime_capital/providers/test.dart';
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

  @override
  Widget build(BuildContext context) {
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
