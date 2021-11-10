import 'dart:convert';

import 'package:anime_capital/tools/shared_preference.dart';
import 'package:http/http.dart' as http;

class HomeProvider{
  final _prefs = SharedPreference.instance;
  final url = 'http://10.0.0.13:3000/api/anime';

  Map<String, String>? _headers(){
    if (_prefs.provider != null) {
      return {'Content-type': 'application/json', 'provider': _prefs.provider!};
    }
  }

  Future<List> getAll()async{
    try{
      final res = await http.get(Uri.parse("$url/recents"), headers: _headers());
      final list = json.decode(res.body);
      return list;
    }catch(e){
      throw e;
    }
  }

  Future<List> getProviders()async{
    try{
      final res = await http.get(Uri.parse("$url/get-providers"));
      final providers = json.decode(res.body);
      return providers;
    }catch(e){
      throw e;
    }
  }
}