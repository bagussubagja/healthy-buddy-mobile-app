// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/credentials/supabase_credential.dart';
import 'package:healthy_buddy_mobile_app/models/mydoc_model/mydoc_appointment_model.dart';
import 'package:http/http.dart' as http;

import '../../routes/routes.dart';

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
    debugPrint('Error Appointment : ${e.toString()}');
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

Future<http.Response?> updateAppointmentStatus(AppointmentScheduleModel data,
    String idUser, BuildContext context, String idDoctor) async {
  http.Response? respone;
  try {
    respone = await http.patch(
        Uri.parse(
            'https://hlrvqhqntrrqjdbcbqxr.supabase.co/rest/v1/schedule_mydoc_appointment?id_user=eq.$idUser&apikey=$apiKey&id_doctor=eq.$idDoctor'),
        headers: {HttpHeaders.contentTypeHeader: "application/json"},
        body: jsonEncode(data.updateAppointmentStatus()));
    if (respone.statusCode == 204) {
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Selamat!',
          message:
              'Kamu telah janji-temu virtual dengan dokter, semoga harimu menyenangkan!',
          contentType: ContentType.success,
        ),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.bodyScreen, (route) => false);
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return respone;
}
