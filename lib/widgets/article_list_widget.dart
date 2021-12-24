import 'package:flutter/material.dart';
import 'package:news_app/functions/get_articles_data.dart';
import 'package:news_app/widgets/article_list_view_widget.dart';
import 'package:news_app/widgets/loading_data_widget.dart';

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
