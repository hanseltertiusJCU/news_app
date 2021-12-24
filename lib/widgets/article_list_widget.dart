import 'package:flutter/material.dart';
import 'package:news_app/functions/get_articles_data.dart';
import 'package:news_app/widgets/article_list_view_widget.dart';
import 'package:news_app/widgets/error_item_widget.dart';
import 'package:news_app/widgets/loading_data_widget.dart';
import 'package:http/http.dart' as http;

class ArticleListWidget extends StatefulWidget {
  const ArticleListWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ArticleListState();
}

class _ArticleListState extends State<ArticleListWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App'),
      ),
      body: FutureBuilder(
        future: getArticlesData(http.Client()),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ArticleListViewWidget(snapshot: snapshot);
          } else if (snapshot.hasError) {
            return ErrorItemWidget(snapshot: snapshot);
          }

          return const LoadingDataWidget();
        },
      ),
    );
  }
}
