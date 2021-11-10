import 'package:anime_capital/bloc/home_bloc.dart';
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
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child:
                  Container(child: Image.asset('assets/logos/anicap_logo.png'),
                  width: double.infinity,),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
            ),
            
          ],
        ),
      ),
      body: StreamBuilder(
        stream: hombeBloc.lastEmittedStream,
        builder: (BuildContext context, AsyncSnapshot<List> snapshot){
          if(!snapshot.hasData) hombeBloc.getLast();
          if(snapshot.hasData){
            final data = snapshot.data!;

            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (_, int idx){
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
                    title: Text(data[idx]["name"], style: Theme.of(context).textTheme.headline6,overflow: TextOverflow.clip,),
                    onTap: ()=>{
                      showDialog(context: context, builder: (context){
                        return AlertDialog(
                          backgroundColor: Colors.black,
                          title: Text(data[idx]["name"]),
                          content: Text("https://tioanime.com/"+data[idx]["url"],style: Theme.of(context).textTheme.headline6,overflow: TextOverflow.clip,),
                          actions: <Widget>[
                            MaterialButton(
                                  onPressed: (){
                                    final cap= {
                                      "uri": "https://tioanime.com/"+data[idx]["url"],
                                      "title": data[idx]["name"]
                                    };

                                    Navigator.of(context).pushNamed('/webview', arguments: cap);
                                  },
                                  child: Text('Ver ahora',style: Theme.of(context).textTheme.headline6,overflow: TextOverflow.clip,)),           
                          ],
                        );
                      })                   
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
