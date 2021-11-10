import 'dart:convert';

import 'package:anime_capital/tools/shared_preference.dart';
import 'package:http/http.dart' as http;
import 'package:anime_capital/tools/headers.dart' as headers;

class WebViewProvider{

  Future<List> getVideoProviders(String urlVideo)async{
    try{
      final res = await http.get(Uri.parse("${headers.url}/episode?url=$urlVideo"), headers: headers.headers());
      final providers = json.decode(res.body);
      return providers["servers"];
    }catch(e){
      throw e;
    }
  }

  
}