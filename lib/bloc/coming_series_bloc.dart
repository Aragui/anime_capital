import 'package:rxdart/rxdart.dart';
import 'package:anime_capital/providers/coming_series_provider.dart';

class ComingSeriesBloc {
  final seriesProvider = ComingSeriesProvider();

  final _comingSeriesController = BehaviorSubject<List>();

  Stream<List> get comingSeriesStream =>
      _comingSeriesController.stream;

  void setComingSeries() async {
    try {
      final series = await seriesProvider.getCommingSeries();
      _comingSeriesController.sink.add(series);
    } catch (e) {
      _comingSeriesController.sink.addError(e);
    }
  }

  void dispose() {
    _comingSeriesController.close();
  }
}
