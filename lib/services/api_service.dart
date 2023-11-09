import 'dart:convert';

import 'package:flutter_toon/models/webtoon_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "https://webtoon-crawler.nomadcoders.workers.dev";
  final String today = "today";
  final String em = "";

  Future<List<WebtoonModel>> getTodaysToons() async {
    List<WebtoonModel> webtoonInstances = [];
    final url = Uri.parse("$baseUrl/$today");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        // final toon = WebtoonModel.fromJson(webtoon);
        webtoonInstances.add(WebtoonModel.fromJson(webtoon));
        // print(toon);
        // print(webtoon);
      }
      return webtoonInstances;
    }
    throw Error(); // error 발생시키기
  }
}
