import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProviderTile extends StatelessWidget {
  late String icon;
  late String providerKey;
  void Function()? onTap;

  ProviderTile(
      {Key? key,
      required this.icon,
      required this.providerKey,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).secondaryHeaderColor,
              border: Border.all(color: Color(0xFF), width: 2),
              borderRadius: BorderRadius.all(Radius.circular(20)),
              image: DecorationImage(image: CachedNetworkImageProvider(icon), fit: BoxFit.scaleDown,)),
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
