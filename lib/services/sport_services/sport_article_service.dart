import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/core/sport/sport_article_notifier.dart';
import 'package:healthy_buddy_mobile_app/credentials/supabase_credential.dart';
import 'package:healthy_buddy_mobile_app/models/foodies_model/food_article_model.dart';
import 'package:healthy_buddy_mobile_app/models/foodies_model/food_receipt_model.dart';
import 'package:healthy_buddy_mobile_app/models/foodies_model/food_store_model.dart';
import 'package:healthy_buddy_mobile_app/models/sport_model/sport_article_model.dart';
import 'package:healthy_buddy_mobile_app/models/sport_model/sport_exercise_model.dart';
import 'package:healthy_buddy_mobile_app/shared/theme.dart';
import 'package:http/http.dart' as http;

Future<List<SportArticleModel>?> getSportArticle(
    {required BuildContext context}) async {
  var client = http.Client();
  var uri = Uri.parse(
      'https://hlrvqhqntrrqjdbcbqxr.supabase.co/rest/v1/sport_article?select=*&apikey=$apiKey');
  try {
    var respone =
        await client.get(uri, headers: {'Authorization': 'Bearer $bearer'});
    if (respone.statusCode == 200) {
      var json = respone.body;
      return sportArticleModelFromJson(json);
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return [];
}
