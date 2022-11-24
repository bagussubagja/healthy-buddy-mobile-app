import 'dart:convert';

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
      } else {
        print('Something Error');
      }
    } catch (e) {
      print(e.toString());
    }
    return results;
  }
}
