import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image/network.dart';
import 'package:news_app/model/article_item.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleItemDetailWidget extends StatelessWidget {
  final ArticleItem item;

  const ArticleItemDetailWidget({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(item.title ?? "")),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Text(item.title ?? "",
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 24.0))),
                Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Text(
                    item.author ?? "",
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Text(
                    item.publishedAt ?? "",
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Image(
                      image: NetworkImageWithRetry(item.urlToImage ??
                          'http://diskannak.kabgarut.com/dhaassets/backend/images/no_image.jpg'),
                    )),
                Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Text(
                    item.description ?? "",
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Text(item.content ?? "")),
                RichText(
                    text: TextSpan(
                        text: "Read More...",
                        style: const TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                          fontSize: 16,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            var url = item.url ?? "";

                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          })),
              ],
            ),
          )),
    );
  }
}
