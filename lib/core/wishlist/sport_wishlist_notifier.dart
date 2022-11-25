import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/models/foodies_model/wishlist_foodies_model.dart';
import 'package:healthy_buddy_mobile_app/models/sport_model/wishlist_sport_model.dart';
import 'package:healthy_buddy_mobile_app/services/wishlist_services/foodies_wishlist_service.dart';
import 'package:healthy_buddy_mobile_app/services/wishlist_services/sport_wishlist_services.dart';

class SportWishlistClass extends ChangeNotifier {
  List<WishlistSportModel>? wishlistSport;
  getWishlist({required BuildContext context, required String idUser}) async {
    wishlistSport =
        (await getWishlistSportByUserID(context: context, idUser: idUser));
    notifyListeners();
  }
}
