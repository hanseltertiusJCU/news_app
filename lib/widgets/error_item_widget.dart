import 'package:flutter/material.dart';
import 'package:news_app/functions/get_articles_data.dart';
import 'package:http/http.dart' as http;

class ErrorItemWidget extends StatelessWidget {
  final AsyncSnapshot snapshot;

  const ErrorItemWidget({Key? key, required this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                        onPressed: () => getArticlesData(http.Client()),
                        child: const Text('Try Again'))
                  ],
                ),
              )
            ]));
  }
}
