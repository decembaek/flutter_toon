import 'dart:convert';

import 'package:flutter_toon/models/webtoon_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  // final String baseUrl = "https://webtoon-crawler.nomadcoders.workers.dev";
  // final String today = "today";
  static const baseUrl = "https://webtoon-crawler.nomadcoders.workers.dev";
  static const today = "today";

  // async awaite 는 future 해야함
  static Future<List<WebtoonModel>> getTodaysToons() async {
    List<WebtoonModel> webtoonInstances = [];
    final url = Uri.parse("$baseUrl/$today");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        final instance = WebtoonModel.fromJson(webtoon);
        webtoonInstances.add(instance);
      }
      return webtoonInstances;
    }
    throw Error(); // error 발생시키기
  }
}
