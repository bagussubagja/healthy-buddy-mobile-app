import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/models/mydoc_model/mydoc_model.dart';
import 'package:healthy_buddy_mobile_app/models/top_article_model.dart';
import 'package:healthy_buddy_mobile_app/models/user_model/user_model.dart';
import 'package:http/http.dart' as http;

import '../../credentials/supabase_credential.dart';

class SearchTopArticle {
  var listResultTopArticle = [];
  List<TopArticleModel> results = [];
  String topArticleUrl =
      "https://hlrvqhqntrrqjdbcbqxr.supabase.co/rest/v1/top_article?select=*&apikey=$apiKey";
  Future<List<TopArticleModel>> getTopArticle({String? query}) async {
    var url = Uri.parse(topArticleUrl);
    var response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        listResultTopArticle = json.decode(response.body);
        results = listResultTopArticle
            .map((e) => TopArticleModel.fromJson(e))
            .toList();
        if (query != null) {
          results = results
              .where((element) =>
                  element.title.toLowerCase().contains(query.toLowerCase()))
              .toList();
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return results;
  }
}

class SearchMyDoc {
  var listResultMyDoc = [];
  List<MyDocModel> results = [];
  String myDocUrl =
      "https://hlrvqhqntrrqjdbcbqxr.supabase.co/rest/v1/my_doc?select=*&apikey=$apiKey";
  Future<List<MyDocModel>> getMyDocSearchData({String? query}) async {
    var url = Uri.parse(myDocUrl);
    var response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        listResultMyDoc = json.decode(response.body);
        results = listResultMyDoc.map((e) => MyDocModel.fromJson(e)).toList();
        if (query != null) {
          results = results
              .where((element) => element.specialist
                  .toLowerCase()
                  .contains(query.toLowerCase()))
              .toList();
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return results;
  }
}
