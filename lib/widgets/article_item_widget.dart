import 'package:flutter/material.dart';
import 'package:flutter_image/network.dart';
import 'package:news_app/model/article_item.dart';
import 'package:news_app/widgets/article_item_detail_widget.dart';

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
