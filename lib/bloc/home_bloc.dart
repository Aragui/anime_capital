import 'package:anime_capital/providers/home_provider.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc{

  final _provider = HomeProvider();

  final _lastEmittedController = BehaviorSubject<List>();
  final _providerListController = BehaviorSubject<List>();

  Stream<List> get lastEmittedStream => _lastEmittedController.stream;
  Stream<List> get providerListStream => _providerListController.stream;

  void getLast()async{
    try{
      final list = await _provider.getAll();
      _lastEmittedController.sink.add(list);
    }catch(e){
      _lastEmittedController.sink.addError(e);
    }
  }

  void getProviders()async{
    try{
      final providers = await _provider.getProviders();
      _providerListController.sink.add(providers);
    }catch(e){
      _providerListController.sink.addError(e);
    }
  }

  void dispose(){
    _lastEmittedController.close();
    _providerListController.close();
  }
}