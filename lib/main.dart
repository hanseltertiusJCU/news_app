import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

    print(jsonData);
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
          return const Text('We try to test loading data from server');
        },
      ),
    );
  }
}
