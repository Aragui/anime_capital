import 'package:anime_capital/providers/home_provider.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc{

  final _provider = HomeProvider();

  final _lastEmittedController = BehaviorSubject<List>();

  Stream<List> get lastEmittedStream => _lastEmittedController.stream;

  void getLast()async{
    try{
      final list = await _provider.getAll();
      _lastEmittedController.sink.add(list);
    }catch(e){
      throw e;
    }
  }

  void dispose(){
    _lastEmittedController.close();
  }
}