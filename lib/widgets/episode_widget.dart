import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Episode extends StatelessWidget {
  final AsyncSnapshot snapshot;
  final String webtoonId;

  const Episode({
    super.key,
    required this.snapshot,
    required this.webtoonId,
  });

  onButtonTap(dynamic episode) async {
    // final url = Uri.parse("https://google.com");
    // await launchUrl(url);
    // await launchUrlString("https://google.com");
    // print(episode.toString());
    await launchUrlString(
      "https://comic.naver.com/webtoon/detail?titleId=$webtoonId&no=${episode.id}",
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true, //ListView가 Column 안에서 올바르게 동작하도록 설정
      physics:
          const NeverScrollableScrollPhysics(), // ListView가 독립적으로 스크롤 하는것을 방지
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        var episode = snapshot.data![index];
        return GestureDetector(
          onTap: () => onButtonTap(episode),
          child: Container(
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      episode.title,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
