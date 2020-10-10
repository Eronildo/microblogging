import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:microblogging/src/modules/news/infrastructure/datasources/news_datasource.dart';
import 'package:microblogging/src/modules/news/infrastructure/models/news_model.dart';

class AwsNewsDataSource implements NewsDataSource {
  final Dio dio;

  AwsNewsDataSource({@required this.dio});

  final String _newsUrlPath =
      "https://gb-mobile-app-teste.s3.amazonaws.com/data.json";

  void _configHttpsCertificate() {
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    };
  }

  @override
  Future<NewsModel> getLatestNews() async {
    _configHttpsCertificate();
    final response = await dio.get(_newsUrlPath);
    if (response.statusCode == HttpStatus.ok) {
      return NewsModel.fromJson(response.data);
    } else {
      throw Exception();
    }
  }
}
