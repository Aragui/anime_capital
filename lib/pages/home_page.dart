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

  // void _onRechargePressed(String animeTitle, String url) {
  //   showModalBottomSheet(
  //     context: context,
  //     elevation: 0,
  //     barrierColor: Color.fromRGBO(117, 117, 117, .5),
  //     builder: (context) {
  //       return Container(
  //         color: Color.fromRGBO(117, 117, 117, .5),
  //         height: 150,
  //         child: Container(
  //           child: Padding(
  //             padding: EdgeInsets.symmetric(
  //               vertical: 10,
  //               horizontal: 20,
  //             ),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               children: <Widget>[
  //                 ListTile(
  //                   title: Text('Editar estudiante'),
  //                   trailing: Icon(
  //                     Icons.edit,
  //                     color: Colors.blue[900],
  //                   ),
  //                   onTap: () {
  //                     final route = MaterialPageRoute(
  //                       builder: (context) {
                          
  //                       },
  //                     );
  //                     Navigator.push(context, route);
  //                   },
  //                 ),
  //                 ListTile(
  //                   title: Text('Eliminar estudiante'),
  //                   trailing: Icon(
  //                     Icons.delete,
  //                     color: Colors.red,
  //                   ),
  //                   onTap: () {
                      
  //                   },
  //                 )
  //               ],
  //             ),
  //           ),
  //           decoration: BoxDecoration(
  //             color: Theme.of(context).canvasColor,
  //             borderRadius: BorderRadius.only(
  //               topLeft: Radius.circular(30),
  //               topRight: Radius.circular(30),
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

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
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Container(
                child: Image.asset('assets/logos/anicap_logo.png'),
                width: double.infinity,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
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
                    onTap: (){
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
                                      backgroundColor: Colors.black,
                                      title: Text(data[idx]["name"]),
                                      content: Container(
                                        width: 300,
                                        height: 300,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: episodes.length,
                                          itemBuilder:
                                              (BuildContext context, int idx) {
                                            return GestureDetector(
                                              onTap: () {
                                                final cap = {
                                                  "uri": episodes[idx]["url"],
                                                  "title": episodes[idx]["server"]
                                                };

                                                Navigator.of(context).pushNamed(
                                                    '/webview',
                                                    arguments: cap);
                                              },
                                              child:
                                                  Text(episodes[idx]["server"], style: Theme.of(context).textTheme.headline6,),
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
