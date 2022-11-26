import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:healthy_buddy_mobile_app/models/foodies_model/wishlist_foodies_model.dart';
import 'package:healthy_buddy_mobile_app/models/sport_model/wishlist_sport_model.dart';
import 'package:healthy_buddy_mobile_app/services/wishlist_services/foodies_wishlist_service.dart';
import 'package:healthy_buddy_mobile_app/services/wishlist_services/sport_wishlist_services.dart';

class SportWishlistClass extends ChangeNotifier {
  bool isLoading = false;
  List<WishlistSportModel>? wishlistSport;
  getWishlist({required BuildContext context, required String idUser}) async {
    isLoading = true;
    wishlistSport =
        (await getWishlistSportByUserID(context: context, idUser: idUser));
    isLoading = false;
    notifyListeners();
  }

  deleteSportWishlistData(
      {required int id, required BuildContext context}) async {
    wishlistSport = (await deleteSportWishlist(id: id, context: context));
    notifyListeners();
  }

  Future<void> addData(WishlistSportModel body, BuildContext context) async {
    notifyListeners();
    http.Response response = (await addSportWishlist(body, context))!;
    if (response.statusCode == 201) {
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Berhasil!',
          message: 'Item Berhasil Dimasukkan pada Keranjang!',
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
          message: 'Item Sudah Terdapat Pada Keranjang kamu!',
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