import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/credentials/supabase_credential.dart';
import 'package:healthy_buddy_mobile_app/models/food_article/carousel_ver_model.dart';
import 'package:healthy_buddy_mobile_app/models/food_article/food_article_model.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

Future<List<FoodArticleCarouselModel>?> getFoodArticlesCarousel(
    {required BuildContext context}) async {
  var client = http.Client();
  var uri = Uri.parse(
      'https://hlrvqhqntrrqjdbcbqxr.supabase.co/rest/v1/food_article_carousel?select=*&apikey=$apiKey');
  try {
    var respone =
        await client.get(uri, headers: {'Authorization': 'Bearer $bearer'});
    if (respone.statusCode == 200) {
      var json = respone.body;
      return foodArticleCarouselModelFromJson(json);
    }
  } catch (e) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(e.toString())));
  }
  return [];
}