import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:microblogging/src/modules/news/external/datasources/aws_news_datasource.dart';
import 'package:microblogging/src/shared/utils/mocks/news_json.dart';
import 'package:mockito/mockito.dart';

class DioMock extends Mock implements Dio {}

main() {
  final dio = DioMock();
  final datasource = AwsNewsDataSource(dio: dio);

  test('Should return News with seven posts', () async {
    when(dio.get(any)).thenAnswer((_) async =>
        Response(statusCode: HttpStatus.ok, data: json.decode(NEWS_JSON)));
    final news = await datasource.getLatestNews();
    expect(news.posts.length, 7);
  });

  test("Should return Exception when status isn't ok ", () {
    when(dio.get(any))
        .thenAnswer((_) async => Response(statusCode: HttpStatus.forbidden));
    expect(datasource.getLatestNews(), throwsA(isA<Exception>()));
  });
}
