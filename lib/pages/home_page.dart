import 'package:anime_capital/bloc/home_bloc.dart';
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
    return Scaffold(
      body: StreamBuilder<List>(
        stream: homeBloc.lastEmittedStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) homeBloc.getLast();
          if (snapshot.hasData) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: Text(
                    "Anime Capital",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  centerTitle: true,
                  iconTheme: Theme.of(context).iconTheme,
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
