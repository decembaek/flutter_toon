import 'package:flutter/material.dart';
import 'package:flutter_toon/models/webtoon_detail_model.dart';
import 'package:flutter_toon/models/webtoon_episode_model.dart';
import 'package:flutter_toon/services/api_service.dart';

class DetailScreen extends StatefulWidget {
  final String title, thumb, id;

  const DetailScreen({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  // Future<WebtoonDetailModel> webtoon = ApiService.getToonById(widget.id);
  late Future<WebtoonDetailModel> webtoon;
  late Future<List<WebtoonEpisodeModel>> episodes;

  @override
  void initState() {
    super.initState();
    webtoon = ApiService.getToonById(widget.id);
    episodes = ApiService.getLatestEpisodesById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // elevation 그림자, 음영
        elevation: 2,
        foregroundColor: Colors.green,
        backgroundColor: Colors.white,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
          child: Column(
            children: [
              // const SizedBox(
              //   height: 50,
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: widget.id,
                    child: Container(
                      width: 250,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            15,
                          ),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 15,
                              offset: const Offset(3, 3),
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ]),
                      child: Image.network(
                        widget.thumb,
                        headers: const {
                          "User-Agent":
                              "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              FutureBuilder(
                future: webtoon,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data!.about,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          "${snapshot.data!.genre} / ${snapshot.data!.age}",
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    );
                  }
                  return const Text("...");
                },
              ),
              const SizedBox(
                height: 20,
              ),
              FutureBuilder(
                  future: episodes,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true, //ListView가 Column 안에서 올바르게 동작하도록 설정
                        physics:
                            const NeverScrollableScrollPhysics(), // ListView가 독립적으로 스크롤 하는것을 방지
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          var episode = snapshot.data![index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.green.shade400,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 20,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    episode.title,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.chevron_right_rounded,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                      //Listview로도 짜보기
                      // return Column(
                      //   children: [
                      //     for (var episode in snapshot.data!)
                      //       Container(
                      //         margin: const EdgeInsets.only(bottom: 10),
                      //         decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(20),
                      //           color: Colors.green.shade400,
                      //         ),
                      //         child: Padding(
                      //           padding: const EdgeInsets.symmetric(
                      //             vertical: 10,
                      //             horizontal: 20,
                      //           ),
                      //           child: Row(
                      //             mainAxisAlignment:
                      //                 MainAxisAlignment.spaceBetween,
                      //             children: [
                      //               Text(
                      //                 episode.title,
                      //                 style: const TextStyle(
                      //                   color: Colors.white,
                      //                   fontSize: 16,
                      //                 ),
                      //               ),
                      //               const Icon(
                      //                 Icons.chevron_right_rounded,
                      //                 color: Colors.white,
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //       )
                      //   ],
                      // );
                    }
                    return Container();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
