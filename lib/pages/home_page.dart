import 'package:anime_capital/bloc/home_bloc.dart';
import 'package:anime_capital/bloc/webview_bloc.dart';
import 'package:anime_capital/widgets/anime_item.dart';
import 'package:anime_capital/widgets/custom_appbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeBloc = HomeBloc();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: StreamBuilder<List>(
        stream: homeBloc.lastEmittedStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) homeBloc.getLast();
          final data = snapshot.data;

          return CustomScrollView(
            slivers: [
              CustomAppbar(title: "Anime Capital"),
              (snapshot.hasData)
                  ? SliverPadding(
                      padding: EdgeInsets.only(top: 15),
                      sliver: SliverList(
                          delegate: SliverChildBuilderDelegate((context, idx) {
                        return AnimeItem(
                          name: data![idx]["name"],
                          imageUrl: data[idx]["image"],
                          url: data[idx]["url"],
                          onClick: () {
                            final webviewBloc = WebviewBloc();

                            showDialog(
                                context: context,
                                builder: (context) {
                                  return StreamBuilder<List>(
                                      stream: webviewBloc.episodeStream,
                                      builder: (context, episode) {
                                        if (!episode.hasData)
                                          webviewBloc.getVideoProviders(
                                              data[idx]["url"]);

                                        if (episode.hasData) {
                                          final episodes = episode.data!;
                                          return AlertDialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                side: BorderSide(
                                                    color: Theme.of(context)
                                                        .secondaryHeaderColor,
                                                    width: 3,
                                                    style: BorderStyle.solid)),
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
                                                    (BuildContext context,
                                                        int idx) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                      final cap = {
                                                        "uri": episodes[idx]
                                                            ["url"],
                                                        "title": episodes[idx]
                                                            ["server"]
                                                      };

                                                      Navigator.of(context)
                                                          .pushNamed('/webview',
                                                              arguments: cap);
                                                    },
                                                    child: Text(
                                                      "${episodes[idx]["server"]}\n",
                                                      textAlign:
                                                          TextAlign.center,
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
                        );
                      }, childCount: data!.length)),
                    )
                  : SliverToBoxAdapter()
            ],
          );
        },
      ),
    );
  }
}
