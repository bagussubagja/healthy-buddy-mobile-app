import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/models/foodies_model/wishlist_foodies_model.dart';
import 'package:healthy_buddy_mobile_app/services/wishlist_services/foodies_wishlist_service.dart';

class FoodiesWishlistClass extends ChangeNotifier {
  List<WishlistFoodiesModel>? wishlistFoodies;
  getWishlist({required BuildContext context, required String idUser}) async {
    wishlistFoodies =
        (await getWishlistFoodiesByUserID(context: context, idUser: idUser));
    notifyListeners();
  }

  deleteFoodiesWishlistData(
      {required int id, required BuildContext context}) async {
    wishlistFoodies = (await deleteFoodiesWishlist(id: id, context: context));
    notifyListeners();
  }
}
