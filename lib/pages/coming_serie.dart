import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:anime_capital/providers/translate_provider.dart';

class ComingSeriePage extends StatefulWidget {
  ComingSeriePage({Key? key}) : super(key: key);

  @override
  _ComingSeriePageState createState() => _ComingSeriePageState();
}

class _ComingSeriePageState extends State<ComingSeriePage> {
  String? synopsis;
  bool wasTranslated = false;
  double? score;
  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    final size = MediaQuery.of(context).size;

    final decoration = BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
            color: Theme.of(context).secondaryHeaderColor,
            style: BorderStyle.solid,
            width: 3));

    final title = Theme.of(context).textTheme.headline5;

    final String titleString =
        arg["genres"].map((val) => val["name"]).join(', ');
    final String demographics =
        arg['demographics'].map((val) => val["name"]).join(', ');
    final String producers =
        arg["producers"].map((val) => val["name"]).join(', ');
    synopsis = synopsis ?? arg["synopsis"];

    final translate = TranslateProvider();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 400,
            pinned: true,
            flexibleSpace: Hero(
              tag: arg["image_url"],
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(arg["image_url"]),
                )),
                child: Stack(
                  children: [
                    Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        top: (size.height * 0.01),
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                Color(0xFF1B233D),
                                Colors.transparent
                              ],
                                  stops: [
                                0,
                                0.8
                              ],
                                  begin: FractionalOffset.bottomCenter,
                                  end: FractionalOffset.topCenter)),
                          alignment: Alignment.bottomCenter,
                          padding: EdgeInsets.only(bottom: 20),
                          child: Text(
                            arg["title"],
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ))
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 18, horizontal: 10),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _container(
                    title: "Generos",
                    style: title,
                    content: Text(
                      (titleString.length != 0) ? titleString : 'Undefined',
                      overflow: TextOverflow.clip,
                    ),
                    decoration: decoration),
                _container(
                    title: "Demografía",
                    style: title,
                    decoration: decoration,
                    content: Text((demographics.length != 0)
                        ? demographics
                        : 'Undefined')),
                _container(
                    title: "Estudio",
                    style: title,
                    decoration: decoration,
                    content: Text(
                        (producers.length != 0) ? producers : 'Undefined')),
                _container(
                  title: "Sinopsis",
                  style: title,
                  content: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: size.width * 0.8,
                        child: Text(
                          synopsis!,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: (!wasTranslated)
                            ? ElevatedButton(
                                onPressed: () async {
                                  final translated = await translate
                                      .getTranslation(synopsis!, 'es');
                                  final newSynopsis =
                                      translated[0]["translations"][0]["text"];
                                  setState(() {
                                    synopsis = newSynopsis;
                                    wasTranslated = true;
                                    score = translated[0]["detectedLanguage"]["score"] *
                                        100.0;
                                  });
                                },
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Theme.of(context).secondaryHeaderColor)),
                                child: Container(
                                  width: 100,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.translate),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text("Traducir"),
                                      )
                                    ],
                                  ),
                                ))
                            : Container(
                                width: size.width * 0.9,
                                height: 70,
                                margin: EdgeInsets.only(top: 40),
                                padding: EdgeInsets.all(5),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(color: Color(0xFF1B233D), borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                    "Traducido por Azure Cognitive Service con $score puntos de certeza", textAlign: TextAlign.center,),
                              ),
                      )
                    ],
                  ),
                  decoration: decoration,
                )
              ]),
            ),
          )
        ],
      ),
    );
  }

  Widget _container(
      {String? title,
      Widget? content,
      TextStyle? style,
      BoxDecoration? decoration}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: decoration,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              title ?? '',
              key: UniqueKey(),
              style: style,
            ),
          ),
          content ?? Container()
        ],
      ),
    );
  }
}
