import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:anime_capital/tools/headers.dart' as util;

class TranslateProvider {
  Future<List> getTranslation(String txt, String to) async {
    try {
      final res = await http.post(Uri.parse("${util.url}/anime-trad"),
          body: json.encode({
            "txt": txt,
            "to": to,
          }),
          headers: {"Content-type": "application/json"});
      final decodedRes = json.decode(res.body);
      return decodedRes;
    } catch (e) {
      throw e;
    }
  }
}
