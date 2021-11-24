import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AnimeCard extends StatelessWidget {
  late String imageUrl;
  late String title;
  late String type;
  late String genre;
  late String producer;
  AnimeCard(
      {Key? key,
      required this.imageUrl,
      required this.title,
      required this.type,
      required this.genre,
      required this.producer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Hero(
      tag: imageUrl,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
            image: DecorationImage(
                image: CachedNetworkImageProvider(imageUrl), fit: BoxFit.cover)),
        child: Stack(
          children: [
            Positioned(
              child: Container(
                height: 350,
                width: double.infinity,
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.only(
                    left: size.width * 0.05,
                    right: size.width * 0.05,
                    bottom: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                    gradient: LinearGradient(
                        colors: [Color(0xFF1B233D), Colors.transparent],
                        stops: [0, 0.8],
                        begin: FractionalOffset.bottomCenter,
                        end: FractionalOffset.topCenter)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        title,
                        overflow: TextOverflow.fade,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Icon(Icons.tv, color: Theme.of(context).secondaryHeaderColor,),
                            ),
                            Container(
                              width: 110,
                              height: 20,
                              child: Text(
                                genre,
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Icon(Icons.movie_creation, color: Theme.of(context).secondaryHeaderColor,),
                            ),
                            Container(
                              width: 100,
                              height: 20,
                              child: Text(
                                producer,
                                overflow: TextOverflow.clip,
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("Ver más", style: Theme.of(context).textTheme.subtitle2,),
                          Icon(Icons.chevron_right, color: Theme.of(context).secondaryHeaderColor,),
                        ],
                      ),
                    ),
    
                  ],
                ),
              ),
              bottom: 0,
              left: 0,
              right: 0,
            ),
            Positioned(
              child: Transform.rotate(
                  angle: 3.1415 / 4,
                  child: Container(
                    color: Theme.of(context).secondaryHeaderColor,
                    height: 30,
                    width: 150,
                    child: Text(
                      (type != '-') ? type : "Unknown",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    alignment: Alignment.center,
                  )),
              top: 27,
              right: -35,
            )
          ],
        ),
      ),
    );
  }
}
