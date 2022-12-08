import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/credentials/supabase_credential.dart';
import 'package:healthy_buddy_mobile_app/models/mydoc_model/mydoc_model.dart';
import 'package:http/http.dart' as http;

Future<List<MyDocModel>?> getDoctorByExperience(
    {required BuildContext context, required String isExperience}) async {
  var client = http.Client();
  var uri = Uri.parse(
      'https://hlrvqhqntrrqjdbcbqxr.supabase.co/rest/v1/my_doc?select=*&apikey=$apiKey&isExperience=eq.$isExperience');
  try {
    var respone =
        await client.get(uri, headers: {'Authorization': 'Bearer $bearer'});
    if (respone.statusCode == 200) {
      var json = respone.body;
      return myDocModelFromJson(json);
    }
  } catch (e) {
  debugPrint(e.toString());
  }
  return [];
}
