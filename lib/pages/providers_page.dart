import 'package:anime_capital/bloc/home_bloc.dart';
import 'package:anime_capital/tools/shared_preference.dart';
import 'package:anime_capital/widgets/provider_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ProvidersPage extends StatefulWidget {
  late Function(dynamic provider) onClic;
  ProvidersPage({Key? key, required this.onClic}) : super(key: key);

  @override
  _ProvidersPageState createState() => _ProvidersPageState();
}

class _ProvidersPageState extends State<ProvidersPage> {
  final _homeBloc = HomeBloc();
  final _prefs = SharedPreference.instance;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                    collapsedHeight: 80,
                    title: Text(
                      "Proveedores",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    centerTitle: true,
                    // flexibleSpace: Column(
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   children: [
                    //     Image.asset('assets/logos/anicap_logo.png', width: 300, height: 250,),
                    //   ],
                    // ),
                    // expandedHeight: 300,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    )),
                  ),
                ),
                (ConnectionState.waiting == snapshot.connectionState)
                ? SliverToBoxAdapter(child: Container(height: size.height * 0.7, alignment: Alignment.center, child: CircularProgressIndicator(color: Theme.of(context).primaryColor,),),)
                : SliverToBoxAdapter(),
                (snapshot.hasData)
                    ? SliverPadding(
                        padding:
                            EdgeInsets.symmetric(vertical: size.height * 0.15),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate((context, idx) {
                            return ProviderTile(
                              icon: data![idx]["icon"],
                              providerKey: data[idx]["key"],
                              status: data[idx]["enabled"],
                              onTap: () {
                                if (data[idx]["enabled"]) {
                                  this.widget.onClic(data[idx]);
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          backgroundColor: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          actionsAlignment:
                                              MainAxisAlignment.center,
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text(
                                                  "abueno pa saber",
                                                  textAlign: TextAlign.center,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle2,
                                                ))
                                          ],
                                          title: Text(
                                            "Actualmente no disponible",
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1,
                                          ),
                                          content: Container(
                                            height: 200,
                                            width: 200,
                                            child: Image.asset(
                                                'assets/logos/anicap_logo.png'),
                                          ),
                                        );
                                      });
                                }
                                // if (data[idx]["enabled"]) {
                                //   _prefs.setProvider = data[idx]["key"];
                                //   Navigator.of(context)
                                //       .pushReplacementNamed('/last-emited');
                                // }
                              },
                            );
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
