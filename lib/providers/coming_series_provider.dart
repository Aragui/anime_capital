import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:anime_capital/tools/headers.dart' as util;

class ComingSeriesProvider{

  Future<List> getCommingSeries()async{
    try{
      final res = await http.get(Uri.parse("${util.url}/new-season"), headers: util.headers());
      final parsedResponse = json.decode(res.body);
      return parsedResponse["anime"];
    }catch(e){
      throw e;
    }
  }
}