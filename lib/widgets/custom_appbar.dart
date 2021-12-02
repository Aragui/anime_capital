import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  late String title;
  CustomAppbar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      collapsedHeight: 80,
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline4,
      ),
      centerTitle: true,
      // flexibleSpace: Column(
      //   mainAxisAlignment: MainAxisAlignment.end,
      //   children: [
      //     Image.asset('assets/logos/anicap_logo.png', width: 300, height: 250,),
      //   ],
      // ),
      // expandedHeight: 300,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(50),
        bottomRight: Radius.circular(50),
      )),
    );
  }
}
