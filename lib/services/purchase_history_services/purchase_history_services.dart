import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:healthy_buddy_mobile_app/models/purchase_history_model/purchase_history_model.dart';

import '../../credentials/supabase_credential.dart';
import '../../shared/theme.dart';

Future<List<PurchaseHistoryModel>?> getPurchaseHistoryData(
    {required BuildContext context, required String idUser}) async {
  var client = http.Client();
  var uri = Uri.parse(
      'https://hlrvqhqntrrqjdbcbqxr.supabase.co/rest/v1/purchase_history?select=*&apikey=$apiKey&id_user=eq.$idUser');
  try {
    var respone =
        await client.get(uri, headers: {'Authorization': 'Bearer $bearer'});
    if (respone.statusCode == 200) {
      var json = respone.body;
      return purchaseHistoryModelFromJson(json);
    }
  } catch (e) {
   debugPrint(e.toString());
  }
  return [];
}

Future<http.Response?> addFoodiesTransaction(
    PurchaseHistoryModel data, BuildContext context) async {
  http.Response? respone;
  try {
    respone = await http.post(
        Uri.parse(
            'https://hlrvqhqntrrqjdbcbqxr.supabase.co/rest/v1/purchase_history?apikey=$apiKey'),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          'Authorization': 'Bearer $bearer',
        },
        body: jsonEncode(data.toJson()));
  } catch (e) {
    debugPrint(e.toString());
  }
 
  return respone;
}
