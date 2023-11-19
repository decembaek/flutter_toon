import 'dart:convert';

import 'package:flutter_toon/models/webtoon_detail_model.dart';
import 'package:flutter_toon/models/webtoon_episode_model.dart';
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

  // Detail API request
  static Future<WebtoonDetailModel> getToonById(String id) async {
    final url = Uri.parse("$baseUrl/$id");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final webtoon = jsonDecode(response.body);
      return WebtoonDetailModel.fromJson(webtoon);
    }
    throw Error();
  }

  // episodes 여러개 가져오기
  static Future<List<WebtoonEpisodeModel>> getLatestEpisodesById(
      String id) async {
    List<WebtoonEpisodeModel> episodesInstances = [];
    final url = Uri.parse("$baseUrl/$id/episodes");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final epidoes = jsonDecode(response.body);
      for (var episode in epidoes) {
        episodesInstances.add(WebtoonEpisodeModel.fromJson(episode));
      }
      return episodesInstances;
    }
    throw Error();
  }
}
