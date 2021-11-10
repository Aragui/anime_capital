import 'package:anime_capital/bloc/home_bloc.dart';
import 'package:anime_capital/tools/shared_preference.dart';
import 'package:anime_capital/widgets/provider_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ProvidersPage extends StatefulWidget {
  ProvidersPage({Key? key}) : super(key: key);

  @override
  _ProvidersPageState createState() => _ProvidersPageState();
}

class _ProvidersPageState extends State<ProvidersPage> {
  final _homeBloc = HomeBloc();
  final _prefs = SharedPreference.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List>(
          stream: _homeBloc.providerListStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) _homeBloc.getProviders();
            final data = snapshot.data;
            return CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                SliverSafeArea(
                  sliver: SliverAppBar(
                    title: Text(
                      "Proveedores",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    centerTitle: true,
                    flexibleSpace: Image.asset('assets/logos/anicap_logo.png'),
                    expandedHeight: 300,
                  ),
                ),
                (snapshot.hasData)
                    ? SliverGrid.count(
                        crossAxisCount: 2,
                        children: data!
                            .map((provider) => ProviderTile(
                                  icon: provider["icon"],
                                  providerKey: provider["key"],
                                  onTap: () {
                                    // if(provider["enabled"]){
                                      _prefs.setProvider = provider["key"];
                                      Navigator.of(context).pushReplacementNamed('/last-emited');
                                    // }
                                  },
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
