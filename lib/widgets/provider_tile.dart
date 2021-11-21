import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class ProviderTile extends StatelessWidget {
  late String icon;
  late bool status;
  late String providerKey;
  void Function()? onTap;

  ProviderTile(
      {Key? key,
      required this.icon,
      required this.providerKey,
      required this.status,
      this.onTap})
      : super(key: key);

  Widget _banner(status) {
    if (!status)
      return Positioned(
          right: -1,
          top: 32,
          child: Transform.rotate(
            angle: pi / 4,
            child: Container(
              width: 130,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.amber
              ),
              child: Text(
                "Próximamente",
              ),
            ),
          ));
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        child: Stack(children: [
          Container(
            height: 80,
            decoration: BoxDecoration(
              color: Color(0xFF1B233D),
              // border: Border.all(color: Color(0xFF1B233D), width: 2, style: BorderStyle.solid),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: CachedNetworkImage(
              imageUrl: icon,
              height: double.infinity,
              width: 200,
            ),
            alignment: Alignment.center,
          ),
          _banner(status)
        ]),
      ),
    );
  }
}
