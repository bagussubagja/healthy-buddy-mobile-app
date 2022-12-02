import 'dart:convert';
import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
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
      'https://hlrvqhqntrrqjdbcbqxr.supabase.co/rest/v1/schedule_mydoc_appointment?select=*,users(*),my_doc(*)&apikey=$apiKey&id_user=eq.$idUser');
  try {
    var respone =
        await client.get(uri, headers: {'Authorization': 'Bearer $bearer'});
    if (respone.statusCode == 200) {
      var json = respone.body;
      return appointmentScheduleModelFromJson(json);
    }
  } catch (e) {
    throw e;
  }
  return [];
}

Future<List<AppointmentScheduleModel>?> deleteAppointmentScheduleById(
    {required int id, required BuildContext context}) async {
  var client = http.Client();
  var uri = Uri.parse(
      'https://hlrvqhqntrrqjdbcbqxr.supabase.co/rest/v1/schedule_mydoc_appointment?id=eq.$id&apikey=$apiKey');
  try {
    var respone =
        await client.delete(uri, headers: {'Authorization': 'Bearer $bearer'});
    if (respone.statusCode == 204) {
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Berhasil!',
          message: 'Jadwal Janji-Temu kamu berhasil dihapus!',
          contentType: ContentType.success,
        ),
      );

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return [];
}

Future<http.Response?> addAppointmentScheduleData(
    AppointmentScheduleModel data, BuildContext context) async {
  http.Response? respone;
  try {
    respone = await http.post(
        Uri.parse(
            'https://hlrvqhqntrrqjdbcbqxr.supabase.co/rest/v1/schedule_mydoc_appointment?apikey=$apiKey'),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          'Authorization': 'Bearer $bearer',
          // 'Prefer': 'resolution=merge-duplicates'
        },
        body: jsonEncode(data.toJson()));
  } catch (e) {
    debugPrint(e.toString());
  }

  return respone;
}
