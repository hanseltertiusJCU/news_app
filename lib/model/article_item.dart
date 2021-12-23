// ignore_for_file: slash_for_doc_comments

import 'package:news_app/model/source_data.dart';

class ArticleItem {
  /**
   * 
   * {
        "source": {
          "id": null,
          "name": "Mirror Online"
        },
        "author": "mirrornews@mirror.co.uk (Freddie Keighley)",
        "title": "Roy Keane has his say on who's the best boss between Pep Guardiola and Jurgen Klopp",
        "description": "Former Manchester United captain Roy Keane hailed Pep Guardiola as \"the man\" as he explained why he favours him over Liverpool's Jurgen Klopp or Chelsea's Thomas Tuchel",
        "url": "https://www.mirror.co.uk/sport/football/news/guardiola-klopp-man-city-liverpool-25769434",
        "urlToImage": "https://i2-prod.mirror.co.uk/incoming/article24751214.ece/ALTERNATES/s1200/0_Roy-Keane.jpg",
        "publishedAt": "2021-12-23T08:22:54Z",
        "content": "Pep Guardiola's Manchester City side play the most attractive brand of football of any Premier League club. \r\n That is the verdict of Roy Keane, who believes the Spaniard is the best manager in the t… [+2493 chars]"
      }
   * 
   */

  final SourceData? source;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;

  ArticleItem(
      {this.source,
      this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content});
}
