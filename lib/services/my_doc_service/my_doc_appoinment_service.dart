import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/credentials/supabase_credential.dart';
import 'package:healthy_buddy_mobile_app/models/foodies_model/food_article_model.dart';
import 'package:healthy_buddy_mobile_app/models/foodies_model/food_receipt_model.dart';
import 'package:healthy_buddy_mobile_app/models/foodies_model/food_store_model.dart';
import 'package:healthy_buddy_mobile_app/models/mydoc_model/mydoc_appointment_model.dart';
import 'package:healthy_buddy_mobile_app/models/mydoc_model/mydoc_model.dart';
import 'package:healthy_buddy_mobile_app/shared/theme.dart';
import 'package:http/http.dart' as http;

Future<List<AppointmentScheduleModel>?> getAppointmentScheduleByUserID(
    {required BuildContext context, required String idUser}) async {
  var client = http.Client();
  var uri = Uri.parse(
      'https://hlrvqhqntrrqjdbcbqxr.supabase.co/rest/v1/schedule_appointment_doctor?select=*&apikey=$apiKey&id_user=eq.$idUser');
  try {
    var respone =
        await client.get(uri, headers: {'Authorization': 'Bearer $bearer'});
    if (respone.statusCode == 200) {
      var json = respone.body;
      return appointmentScheduleModelFromJson(json);
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
      e.toString(),
      style: regularStyle,
    )));
  }
  return [];
}

Future<http.Response?> addAppointmentScheduleData(
    AppointmentScheduleModel data, BuildContext context) async {
  http.Response? respone;
  try {
    respone = await http.post(
        Uri.parse(
            'https://hlrvqhqntrrqjdbcbqxr.supabase.co/rest/v1/schedule_appointment_doctor?apikey=$apiKey'),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          'Authorization': 'Bearer $bearer',
          // 'Prefer': 'resolution=merge-duplicates'
        },
        body: jsonEncode(data.toJson()));
  } catch (e) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(e.toString())));
  }
  debugPrint(respone.toString());
  return respone;
}
