import 'package:anime_capital/bloc/home_bloc.dart';
import 'package:anime_capital/bloc/webview_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final hombeBloc = HomeBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Anime Capital",
          style: Theme.of(context).textTheme.headline4,
        ),
        centerTitle: true,
        iconTheme: Theme.of(context).iconTheme,
      ),
      body: StreamBuilder(
        stream: hombeBloc.lastEmittedStream,
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (!snapshot.hasData) hombeBloc.getLast();
          if (snapshot.hasData) {
            final data = snapshot.data!;

            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (_, int idx) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: CachedNetworkImage(
                        imageUrl: data[idx]["image"],
                        height: 80,
                        width: 80,
                        fit: BoxFit.fill,
                      ),
                      // child: Image.network(data[idx]["image"], width: 100, height: 100,fit: BoxFit.fill,),
                    ),
                    title: Text(
                      data[idx]["name"],
                      style: Theme.of(context).textTheme.headline6,
                      overflow: TextOverflow.clip,
                    ),
                    onTap: () {
                      final webviewBloc = WebviewBloc();

                      // _onRechargePressed(data[idx]["name"], servers)
                      showDialog(
                          context: context,
                          builder: (context) {
                            return StreamBuilder<List>(
                                stream: webviewBloc.episodeStream,
                                builder: (context, episode) {
                                  if (!episode.hasData)
                                    webviewBloc
                                        .getVideoProviders(data[idx]["url"]);

                                  if (episode.hasData) {
                                    final episodes = episode.data!;
                                    return AlertDialog(
                                      backgroundColor: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      title: Text(
                                        "Selecciona un servidor",
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                                      content: Container(
                                        width: 300,
                                        height: 200,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: episodes.length,
                                          itemBuilder:
                                              (BuildContext context, int idx) {
                                            return GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).pop();
                                                final cap = {
                                                  "uri": episodes[idx]["url"],
                                                  "title": episodes[idx]
                                                      ["server"]
                                                };

                                                Navigator.of(context).pushNamed(
                                                    '/webview',
                                                    arguments: cap);
                                              },
                                              child: Text(
                                                "${episodes[idx]["server"]}\n",
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                  }
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                });
                          });
                    },
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
