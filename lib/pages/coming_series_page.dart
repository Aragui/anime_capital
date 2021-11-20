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
                SliverSafeArea(
                  sliver: SliverAppBar(
                    collapsedHeight: 80,
                    title: Text(
                      "Próximamente",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    centerTitle: true,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    )),
                  ),
                ),
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
                    ? SliverPadding(
                        padding:
                            EdgeInsets.symmetric(vertical: size.height * 0.15),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate((context, idx) {
                            return Text(data![idx]["title"]);
                            
                          }, childCount: data!.length),
                        ),
                      )
                    : SliverToBoxAdapter()
              ],
            );
          }),
    );
  }
}
