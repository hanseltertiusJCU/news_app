import 'package:flutter/material.dart';
import 'package:news_app/widgets/article_item_widget.dart';

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
