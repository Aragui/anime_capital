import 'package:anime_capital/tools/shared_preference.dart';

final _prefs = SharedPreference.instance;
final url = 'https://anime-central-api.herokuapp.com/api/anime';
// final url = 'http://10.0.0.13:3000/api/anime';

Map<String, String>? headers() {
  if (_prefs.provider != null) {
    return {'Content-type': 'application/json', 'provider': _prefs.provider!};
  }
}
