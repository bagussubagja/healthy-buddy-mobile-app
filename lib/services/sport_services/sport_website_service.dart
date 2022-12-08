import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/credentials/supabase_credential.dart';
import 'package:healthy_buddy_mobile_app/models/sport_model/sport_website_model.dart';
import 'package:http/http.dart' as http;

Future<List<SportWebsiteModel>?> getSportWebsiteByCategory(
    {required BuildContext context, required String category}) async {
  var client = http.Client();
  var uri = Uri.parse(
      'https://hlrvqhqntrrqjdbcbqxr.supabase.co/rest/v1/sport_website?select=*&apikey=$apiKey&category=eq.$category');
  try {
    var respone =
        await client.get(uri, headers: {'Authorization': 'Bearer $bearer'});
    if (respone.statusCode == 200) {
      var json = respone.body;
      return sportWebsiteModelFromJson(json);
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return [];
}
