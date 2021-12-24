import 'dart:convert';

import 'package:news_app/model/article_item.dart';

ResponseModel responseModelFromJson(String str) =>
    ResponseModel.fromJson(json.decode(str));

String responseModelToJson(ResponseModel data) => json.encode(data.toJson());

class ResponseModel {
  String status;
  int totalResults;
  List<ArticleItem> articles;

  ResponseModel({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        status: json["status"],
        totalResults: json["totalResults"],
        articles: List<ArticleItem>.from(
            json["articles"].map((x) => ArticleItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "totalResults": totalResults,
        "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
      };
}
