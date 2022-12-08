// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/credentials/supabase_credential.dart';
import 'package:healthy_buddy_mobile_app/models/sport_model/wishlist_sport_model.dart';
import 'package:http/http.dart' as http;

Future<List<WishlistSportModel>?> getWishlistSportByUserID(
    {required BuildContext context, required String idUser}) async {
  var client = http.Client();
  var uri = Uri.parse(
      'https://hlrvqhqntrrqjdbcbqxr.supabase.co/rest/v1/wishlist_sport_item?select=*,sport_store(*)&apikey=$apiKey&id_user=eq.$idUser');
  try {
    var respone =
        await client.get(uri, headers: {'Authorization': 'Bearer $bearer'});
    if (respone.statusCode == 200) {
      var json = respone.body;
      return wishlistSportModelFromJson(json);
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return [];
}

Future<List<WishlistSportModel>?> deleteSportWishlist(
    {required int id, required BuildContext context}) async {
  var client = http.Client();
  var uri = Uri.parse(
      'https://hlrvqhqntrrqjdbcbqxr.supabase.co/rest/v1/wishlist_sport_item?id=eq.$id&apikey=$apiKey');
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
          message: 'Item berhasil dihapus pada wishlist kamu!',
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

Future<http.Response?> addSportWishlist(
    WishlistSportModel data, BuildContext context) async {
  http.Response? respone;
  try {
    respone = await http.post(
        Uri.parse(
            'https://hlrvqhqntrrqjdbcbqxr.supabase.co/rest/v1/wishlist_sport_item?apikey=$apiKey&on_conflict=item_unique_key'),
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
