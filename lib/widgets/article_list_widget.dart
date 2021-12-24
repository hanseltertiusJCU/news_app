import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:news_app/model/article_item.dart';
import 'package:news_app/model/source_data.dart';
import 'package:news_app/widgets/article_list_view_widget.dart';
import 'package:news_app/widgets/loading_data_widget.dart';

class ArticleListWidget extends StatefulWidget {
  const ArticleListWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ArticleListState();
}

class _ArticleListState extends State<ArticleListWidget> {
  Future getArticlesData() async {
    try {
      var queryParameters = {
        'q': 'tesla',
        'from': '2021-11-23',
        'sortBy': 'publishedAt',
        'apiKey': '88bba294faa442e5b91e3835a27ce0145'
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
        throw Exception(jsonData['message']);
      }
    } on SocketException {
      throw Exception('No Internet Connection');
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
          if (snapshot.hasData) {
            return ArticleListViewWidget(snapshot: snapshot);
          } else if (snapshot.hasError) {
            return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 4.0),
                              child: Text('${snapshot.error}'),
                            ),
                            ElevatedButton(
                                onPressed: () => getArticlesData(),
                                child: const Text('Try Again'))
                          ],
                        ),
                      )
                    ]));
          }

          return const LoadingDataWidget();
        },
      ),
    );
  }
}
