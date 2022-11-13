import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/models/foodies_model/food_store_model.dart';
import 'package:healthy_buddy_mobile_app/services/foodies_services/food_store_service/food_store_service.dart';

class FoodStoreByBuahClass extends ChangeNotifier {
  List<FoodStoreModel>? foodStoreModel;
  getBuah({required BuildContext context, required String category}) async {
    foodStoreModel =
        (await getFoodStoreByCategory(context: context, category: 'Buah'));
    notifyListeners();
  }
}

class FoodStoreBySayuranClass extends ChangeNotifier {
  List<FoodStoreModel>? foodStoreModel;
  getSayuran({required BuildContext context, required String category}) async {
    foodStoreModel =
        (await getFoodStoreByCategory(context: context, category: 'Sayuran'));
    notifyListeners();
  }
}

class FoodStoreByInstanClass extends ChangeNotifier {
  List<FoodStoreModel>? foodStoreModel;
  getInstan({required BuildContext context, required String category}) async {
    foodStoreModel =
        (await getFoodStoreByCategory(context: context, category: 'Instan'));
    notifyListeners();
  }
}

class FoodStoreByMinumanClass extends ChangeNotifier {
  List<FoodStoreModel>? foodStoreModel;
  getMinuman({required BuildContext context, required String category}) async {
    foodStoreModel =
        (await getFoodStoreByCategory(context: context, category: 'Minuman'));
    notifyListeners();
  }
}
