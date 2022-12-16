// ignore_for_file: use_build_context_synchronously

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:healthy_buddy_mobile_app/models/favorite_model/fav_food_receipt_model.dart';
import 'package:healthy_buddy_mobile_app/models/favorite_model/fav_mydoc_model.dart';
import 'package:healthy_buddy_mobile_app/services/favorite_services/fav_food_receipt_service.dart';
import 'package:healthy_buddy_mobile_app/services/favorite_services/fav_mydoc_service.dart';

class FavoriteClass extends ChangeNotifier {
  List<FavFoodReceiptModel>? food;
  List<FavMyDocModel>? doc;
  bool isLoading = false;
  getFavFood({required BuildContext context, required String idUser}) async {
    isLoading = true;
    food = (await getFavReceiptByIdUser(context: context, idUser: idUser));
    isLoading = false;
    notifyListeners();
  }

  getFavMyDoc({required BuildContext context, required String idUser}) async {
    isLoading = true;
    doc = (await getFavMyDocByIdUser(context: context, idUser: idUser));
    isLoading = false;
    notifyListeners();
  }

  deleteFavFoodData({required int id, required BuildContext context}) async {
    food = (await deleteFavReceiptById(id: id, context: context));
    notifyListeners();
  }

  deleteFavMyDocData({required int id, required BuildContext context}) async {
    doc = (await deleteFavMyDocById(id: id, context: context));
    notifyListeners();
  }


  Future<void> addFavFoodData(
      FavFoodReceiptModel body, BuildContext context) async {
    notifyListeners();
    http.Response response = (await addFavReceiptData(body, context))!;
    if (response.statusCode == 201) {
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Berhasil!',
          message: 'Item berhasil masuk ke dalam favorite kamu!',
          contentType: ContentType.success,
        ),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Gagal!',
          message: 'Item Sudah Terdapat Pada Favorite kamu!',
          contentType: ContentType.failure,
        ),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }

    notifyListeners();
  }

  Future<void> addFavDocData(FavMyDocModel body, BuildContext context) async {
    notifyListeners();
    http.Response? response = (await addFavMyDocData(body, context));
    if (response?.statusCode == 201) {
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Berhasil!',
          message: 'Item berhasil masuk ke dalam favorite kamu!',
          contentType: ContentType.success,
        ),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Gagal!',
          message: 'Item Sudah Terdapat Pada Favorite kamu!',
          contentType: ContentType.failure,
        ),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }

    notifyListeners();
  }


}
