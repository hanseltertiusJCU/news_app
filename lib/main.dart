import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/model/article_item.dart';
import 'package:news_app/model/source_data.dart';
import 'package:flutter_image/flutter_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: ArticleListWidget(),
    );
  }
}

class ArticleListWidget extends StatefulWidget {
  const ArticleListWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ArticleListState();
}

class _ArticleListState extends State<ArticleListWidget> {
  Future getArticlesData() async {
    var queryParameters = {
      'q': 'tesla',
      'from': '2021-11-23',
      'sortBy': 'publishedAt',
      'apiKey': '88bba294faa442e5b91e3835a27ce014'
    };

    var response = await http
        .get(Uri.https('newsapi.org', 'v2/everything', queryParameters));

    var jsonData = jsonDecode(response.body);

    List<ArticleItem> articles = [];

    if (jsonData['status'] == 'ok') {
      for (var article in jsonData['articles']) {
        var source = article['source'];

        SourceData sourceData =
            SourceData(id: source['id'], name: source['name']);

        ArticleItem articleItem = ArticleItem(
            source: sourceData,
            author: article['author'],
            title: article['title'],
            description: article['description'],
            url: article['url'],
            urlToImage: article['urlToImage'],
            publishedAt: article['publishedAt'],
            content: article['content']);

        articles.add(articleItem);
      }
      return articles;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App'),
      ),
      body: FutureBuilder(
        future: getArticlesData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingDataWidget();
          } else {
            return ArticleListViewWidget(snapshot: snapshot);
          }
        },
      ),
    );
  }
}

class LoadingDataWidget extends StatelessWidget {
  const LoadingDataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text('Retrieving News Data')),
            LinearProgressIndicator(
              value: null,
            )
          ],
        ));
  }
}

class ArticleListViewWidget extends StatelessWidget {
  final AsyncSnapshot snapshot;

  const ArticleListViewWidget({Key? key, required this.snapshot})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: const EdgeInsets.all(8.0),
        itemCount: snapshot.data.length,
        separatorBuilder: (context, index) =>
            const Padding(padding: EdgeInsets.symmetric(vertical: 8.0)),
        itemBuilder: (context, index) {
          return ArticleItemWidget(item: snapshot.data[index]);
        });
  }
}

class ArticleItemWidget extends StatelessWidget {
  final ArticleItem item;

  const ArticleItemWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Card(
        elevation: 4.0,
        child: InkWell(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      topRight: Radius.circular(4.0)),
                  child: Image(
                    image: NetworkImageWithRetry(item.urlToImage ??
                        'http://diskannak.kabgarut.com/dhaassets/backend/images/no_image.jpg'),
                  )),
              Text(
                item.title ?? "",
                style: const TextStyle(
                    fontSize: 24.0, fontWeight: FontWeight.bold),
              )
            ],
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ArticleItemDetailWidget(item: item)));
          },
        ),
      ),
    );
  }
}

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
