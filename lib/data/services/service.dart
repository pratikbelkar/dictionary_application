import 'dart:convert';

import 'package:dictionary_application/data/model/dictionary_model.dart';
import 'package:http/http.dart' as http;

class Apiservices {
  static String baseurl = 'https://api.dictionaryapi.dev/api/v2/entries/en/';

  static Future<DictonaryModel?> fetchData(String word) async {
    Uri url = Uri.parse("$baseurl$word");
    final response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return DictonaryModel.fromJson(data[0]);
      } else {
        throw Exception('failure to load meaning');
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}
