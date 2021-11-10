import 'package:anime_capital/providers/webview_provider.dart';
import 'package:rxdart/rxdart.dart';

class WebviewBloc{
  final provider = WebViewProvider();

  final _episodeProvidersController = BehaviorSubject<List>();

  Stream<List> get episodeStream => _episodeProvidersController.stream;

  void getVideoProviders(String urlVideo)async{
    try{
      final providers = await provider.getVideoProviders(urlVideo);
      _episodeProvidersController.sink.add(providers);
    }catch(e){
      _episodeProvidersController.sink.addError(e);
    }
  }

  void dispose(){
    _episodeProvidersController.close();
  }
}