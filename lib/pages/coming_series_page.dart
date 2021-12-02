import 'package:anime_capital/widgets/anime_card.dart';
import 'package:anime_capital/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:anime_capital/bloc/coming_series_bloc.dart';

class ComingSeriesPage extends StatefulWidget {
  ComingSeriesPage({Key? key}) : super(key: key);

  @override
  _ComingSeriesPageState createState() => _ComingSeriesPageState();
}

class _ComingSeriesPageState extends State<ComingSeriesPage> {
  final _comingSeriesBloc = ComingSeriesBloc();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: StreamBuilder<List>(
          stream: _comingSeriesBloc.comingSeriesStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) _comingSeriesBloc.setComingSeries();
            final data = snapshot.data;
            return CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                CustomAppbar(title: "Próximamente"),
                (ConnectionState.waiting == snapshot.connectionState)
                    ? SliverToBoxAdapter(
                        child: Container(
                          height: size.height * 0.7,
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      )
                    : SliverToBoxAdapter(),
                (snapshot.hasData)
                    ? SliverGrid.count(
                        crossAxisCount: 1,
                        children: data!
                            .map((e) => GestureDetector(
                              onTap: (){
                                Navigator.of(context).pushNamed('/coming-serie', arguments: e);
                              },
                              child: AnimeCard(
                                    imageUrl: e["image_url"],
                                    title: e["title"],
                                    type: e["type"],
                                    genre: (e["genres"].length > 0) ? e["genres"][0]["name"] : "unknown",
                                    producer: (e["producers"].length >0)? e["producers"][0]["name"] : "unknown"
                                  ),
                            ))
                            .toList(),
                      )
                    : SliverToBoxAdapter()
              ],
            );
          }),
    );
  }
}
