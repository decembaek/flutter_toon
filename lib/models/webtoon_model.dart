class WebtoonModel {
  final String title, thumb, id;

  // WebtoonModel({
  //   required this.title,
  //   required this.thumb,
  //   required this.id,
  // });
  WebtoonModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        title = json['title'],
        thumb = json["thumb"];
}
