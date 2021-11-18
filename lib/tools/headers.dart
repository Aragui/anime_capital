import 'package:anime_capital/tools/shared_preference.dart';

final _prefs = SharedPreference.instance;
final url = 'https://anime-capital-server.herokuapp.com/api/anime';
// final url = 'http://192.168.0.28:3000/api/anime';

Map<String, String>? headers() {
  if (_prefs.provider != null) {
    return {'Content-type': 'application/json', 'provider': _prefs.provider!};
  }
}
