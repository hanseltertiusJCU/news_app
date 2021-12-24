import 'dart:convert';
import 'dart:io';

import 'package:intl/intl.dart';
import 'package:news_app/model/response_model.dart';
import 'package:http/http.dart' as http;

Future<ResponseModel> getArticlesData(http.Client client) async {
  try {
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);

    var queryParameters = {
      'q': 'tesla',
      'from': formattedDate,
      'sortBy': 'publishedAt',
      'apiKey': '88bba294faa442e5b91e3835a27ce014'
    };

    var response = await client
        .get(Uri.https('newsapi.org', 'v2/everything', queryParameters));

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      return ResponseModel.fromJson(jsonData);
    } else {
      throw Exception(jsonData['message']);
    }
  } on SocketException {
    throw Exception('No Internet Connection');
  }
}
