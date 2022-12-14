import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/credentials/supabase_credential.dart';
import 'package:healthy_buddy_mobile_app/models/top_article_model.dart';
import 'package:http/http.dart' as http;

Future<List<TopArticleModel>?> getTopArticles(
    {required BuildContext context}) async {
  var client = http.Client();
  var uri = Uri.parse(
      'https://hlrvqhqntrrqjdbcbqxr.supabase.co/rest/v1/top_article?select=*&apikey=$apiKey');
  try {
    var respone =
        await client.get(uri, headers: {'Authorization': 'Bearer $bearer'});
    if (respone.statusCode == 200) {
      var json = respone.body;
      return topArticleModelFromJson(json);
    }
  } catch (e) {
   debugPrint(e.toString());
  }
  return [];
}
