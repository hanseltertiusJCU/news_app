import 'dart:convert';
import 'dart:io';

import 'package:news_app/model/article_item.dart';
import 'package:news_app/model/source_data.dart';
import 'package:http/http.dart' as http;

Future getArticlesData() async {
  try {
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
      throw Exception(jsonData['message']);
    }
  } on SocketException {
    throw Exception('No Internet Connection');
  }
}
