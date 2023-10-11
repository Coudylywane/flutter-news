import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:news/models/news.dart';

class NewsHttp {
  final String baseUrl = "http://localhost:3000";
  final Dio _dio = Dio();

  Future<List<NewsModel>> getNews() async {
    List<NewsModel> list = [];
    var response = await _dio.get('$baseUrl/news');
    if (response.statusCode == 200) {
      print(response.data);
      for (var element in response.data) {
        list.add(NewsModel.fromJson(element));
      }
    }
    return list;
  }

  getNewsById(int id) async {
    var response = await _dio.get('$baseUrl/news/$id');
    if (response.statusCode == 200) {
      print(response.data);
    }
    return NewsModel();
  }

  createNews(data) async {
    var response = await _dio.post('$baseUrl/news', data: data);
    if (response.statusCode == 201) {
      print(response.data);
    }
  }

  deleteNews(int id) async {
    var response = await _dio.delete('$baseUrl/news/$id');
    if (response.statusCode == 200) {
           getNews();
     }
   }


  updateNews(int id, newData) async {
    var response = await _dio.put('$baseUrl/news/$id', data: newData);
    if (response.statusCode == 200) {
      print(response.data);
    }
  }
}
