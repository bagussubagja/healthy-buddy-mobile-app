import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/credentials/supabase_credential.dart';
import 'package:healthy_buddy_mobile_app/models/carousel_model.dart';
import 'package:healthy_buddy_mobile_app/models/foodies_model/food_article_model.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

Future<List<CarouselModel>?> getCarouselItem(
    {required BuildContext context, required String section}) async {
  var client = http.Client();
  var uri = Uri.parse(
      'https://hlrvqhqntrrqjdbcbqxr.supabase.co/rest/v1/carousel_section?select=*&section=eq.$section&apikey=$apiKey');
  try {
    var respone =
        await client.get(uri, headers: {'Authorization': 'Bearer $bearer'});
    if (respone.statusCode == 200) {
      var json = respone.body;
      return carouselModelFromJson(json);
    }
  } catch (e) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(e.toString())));
  }
  return [];
}
