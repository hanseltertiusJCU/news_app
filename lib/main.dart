import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/model/article_item.dart';
import 'package:news_app/model/source_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
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
          return const LoadingDataWidget();
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
        padding: const EdgeInsets.all(16.0),
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
