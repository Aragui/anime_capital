import 'dart:convert';

import 'package:http/http.dart' as http;

class HomeProvider{
  final url = 'http://10.0.0.13:3000/api/anime';

  Future<List> getAll()async{
    try{
      final res = await http.get(Uri.parse("$url/recents"), headers: {
        'Content-type': 'application/json',
        'provider': 'tioanime'
      });
      final list = jsonDecode(res.body);
      return list;
    }catch(e){
      throw e;
    }
  }
}