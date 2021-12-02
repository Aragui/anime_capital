import 'package:anime_capital/bloc/home_bloc.dart';
import 'package:anime_capital/tools/shared_preference.dart';
import 'package:anime_capital/widgets/custom_appbar.dart';
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
                CustomAppbar(title: "Proveedores"),
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
                                          actionsAlignment: MainAxisAlignment.center,
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text(
                                                  "Entendido",
                                                  textAlign: TextAlign.center,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle2,
                                                ))
                                          ],
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
