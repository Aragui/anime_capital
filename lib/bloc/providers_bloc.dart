import 'package:anime_capital/providers/home_provider.dart';
import 'package:rxdart/rxdart.dart';

class ProvidersBloc {
  final _provider = HomeProvider();
  
  final _providerListController = BehaviorSubject<List>();

  Stream<List> get providerListStream => _providerListController.stream;

  void getProviders() async {
    try {
      final providers = await _provider.getProviders();
      _providerListController.sink.add(providers);
    } catch (e) {
      _providerListController.sink.addError(e);
    }
  }

  void dispose() {
    _providerListController.close();
  }
}
