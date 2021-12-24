import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:news_app/functions/get_articles_data.dart';
import 'package:news_app/model/article_item.dart';
import 'package:news_app/model/response_model.dart';

import 'get_articles_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  test('returns a ResponseModel if the http call completes successfully',
      () async {
    final client = MockClient();

    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);

    var queryParameters = {
      'q': 'tesla',
      'from': formattedDate,
      'sortBy': 'publishedAt',
      'apiKey': '88bba294faa442e5b91e3835a27ce014'
    };

    when(client.get(Uri.https('newsapi.org', 'v2/everything', queryParameters)))
        .thenAnswer((_) async => http.Response(
            '{"status" : "ok", "totalResults" : 1, "articles" : [{"source" : {"id" : null, "name" : "Testing"}, "author" : "Test", "title" : "Testing", "description" : "Test Article", "url" : "https://www.protothema.gr/life-style/article/1194692/giorgos-theofanous-gia-tous-one-sugrotima-periorismenon-fonitikon-dunatotiton/", "urlToImage" : "https://i1.prth.gr/images/640x360share/files/2021-12-08/theofanous.png", "publishedAt" : "2021-12-24T06:17:57Z", "content" : "weineaodneoaindeawoineaoifneawoifnaoeifneofniea"}]}',
            200));

    expect(await getArticlesData(client), isA<ResponseModel>());
  });
}
