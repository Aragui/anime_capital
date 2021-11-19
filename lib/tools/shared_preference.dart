import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference{
  static SharedPreference? _instance;

  static SharedPreferences? _prefs;

  SharedPreference._internal();

  static SharedPreference get instance{
    if(_instance == null){
      _instance = SharedPreference._internal();
    }

    return _instance!;
  }

  static void initPrefs()async{
    _prefs = await SharedPreferences.getInstance();
  }

  String? get provider{
    return _prefs?.getString('provider');
  }

  set setProvider(String provider){
    _prefs?.setString('provider', provider);
  }
}