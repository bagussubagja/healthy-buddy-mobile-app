import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/credentials/supabase_credential.dart';
import 'package:healthy_buddy_mobile_app/models/user_model/user_model.dart';
import 'package:http/http.dart' as http;

Future<List<UserModel>?> getUserData(
    {required BuildContext context, required String idUser}) async {
  var client = http.Client();
  var uri = Uri.parse(
      'https://hlrvqhqntrrqjdbcbqxr.supabase.co/rest/v1/users?select=*&apikey=$apiKey&id_user=eq.$idUser');
  try {
    var respone =
        await client.get(uri, headers: {'Authorization': 'Bearer $bearer'});
    if (respone.statusCode == 200) {
      var json = respone.body;
      return userModelFromJson(json);
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return [];
}

Future<http.Response?> updateUserNameData(
    UserModel data, String idUser, BuildContext context) async {
  http.Response? respone;
  try {
    respone = await http.patch(
        Uri.parse(
            'https://hlrvqhqntrrqjdbcbqxr.supabase.co/rest/v1/users?id_user=eq.$idUser&apikey=$apiKey'),
        headers: {HttpHeaders.contentTypeHeader: "application/json"},
        body: jsonEncode(data.updateName()));
  } catch (e) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(e.toString())));
  }
  return respone;
}

Future<http.Response?> updateUserAddressData(
    UserModel data, String idUser, BuildContext context) async {
  http.Response? respone;
  try {
    respone = await http.patch(
        Uri.parse(
            'https://hlrvqhqntrrqjdbcbqxr.supabase.co/rest/v1/users?id_user=eq.$idUser&apikey=$apiKey'),
        headers: {HttpHeaders.contentTypeHeader: "application/json"},
        body: jsonEncode(data.updateAddress()));
  } catch (e) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(e.toString())));
  }
  return respone;
}

Future<http.Response?> updateTopUpBalanceData(
    UserModel data, String idUser, BuildContext context) async {
  http.Response? respone;
  try {
    respone = await http.patch(
        Uri.parse(
            'https://hlrvqhqntrrqjdbcbqxr.supabase.co/rest/v1/users?id_user=eq.$idUser&apikey=$apiKey'),
        headers: {HttpHeaders.contentTypeHeader: "application/json"},
        body: jsonEncode(data.updateBalanceData()));
  } catch (e) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(e.toString())));
  }
  return respone;
}

Future<http.Response?> updateDiscountStatusData(
    UserModel data, String idUser, BuildContext context) async {
  http.Response? respone;
  try {
    respone = await http.patch(
        Uri.parse(
            'https://hlrvqhqntrrqjdbcbqxr.supabase.co/rest/v1/users?id_user=eq.$idUser&apikey=$apiKey'),
        headers: {HttpHeaders.contentTypeHeader: "application/json"},
        body: jsonEncode(data.updateDiscountStatus()));
  } catch (e) {
    debugPrint(e.toString());
  }
  return respone;
}

Future<http.Response?> updateSelfDataUser(
    UserModel data, String idUser, BuildContext context) async {
  http.Response? respone;
  try {
    respone = await http.patch(
        Uri.parse(
            'https://hlrvqhqntrrqjdbcbqxr.supabase.co/rest/v1/users?id_user=eq.$idUser&apikey=$apiKey'),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
        body: jsonEncode(data.selfData()));
  } catch (e) {
    debugPrint(e.toString());
  }
  return respone;
}
