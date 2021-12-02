import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AnimeItem extends StatelessWidget {
  late String imageUrl;
  late String name;
  late String url;
  Function? onClick;

  AnimeItem({Key? key, required this.name, required this.imageUrl, required this.url, this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (){
        if(onClick != null) onClick!();
      },
      child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: Container(
                              height: 115,
                              decoration: BoxDecoration(
                                color: Color(0xFF1B233D),
                                border: Border.all(
                                    color: Color(0xFF1B233D),
                                    width: 2,
                                    style: BorderStyle.solid),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        bottomLeft: Radius.circular(20)),
                                    child: CachedNetworkImage(
                                      imageUrl: this.imageUrl,
                                      height: double.infinity,
                                      width: 160,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Container(
                                    width: size.width * 0.47,
                                    height: double.infinity,
                                    padding: EdgeInsets.symmetric(horizontal: 5),
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          this.name,
                                          overflow: TextOverflow.clip,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2,
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
    );;
  }
}