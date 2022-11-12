import 'package:flutter/cupertino.dart';
import 'package:healthy_buddy_mobile_app/models/carousel_model.dart';
import 'package:healthy_buddy_mobile_app/models/foodies_model/food_article_model.dart';
import 'package:healthy_buddy_mobile_app/models/foodies_model/food_receipt_model.dart';
import 'package:healthy_buddy_mobile_app/services/carousel_services/get_carousel_article.dart';
import 'package:healthy_buddy_mobile_app/services/foodies_services/food_articles_service/get_food_article_service.dart';
import 'package:healthy_buddy_mobile_app/services/foodies_services/food_receipt_service/category_get_food_receipt.dart';
import 'package:healthy_buddy_mobile_app/services/foodies_services/food_receipt_service/get_food_receipt.dart';

class FoodReceiptClass extends ChangeNotifier {
  List<FoodReceiptModel>? receiptModels;
  getFoodReceipt({required BuildContext context}) async {
    receiptModels = (await getFoodReceipts(context: context));
    notifyListeners();
  }
}

class FoodReceiptByBreakfast extends ChangeNotifier {
  List<FoodReceiptModel>? receiptModelCategory;
  getFoodReceiptCategory(
      {required BuildContext context, required String category}) async {
    receiptModelCategory =
        (await getFoodReceiptByCategory(context: context, category: 'Breakfast'));
    notifyListeners();
  }
}

class FoodReceiptByLunch extends ChangeNotifier {
  List<FoodReceiptModel>? receiptModelCategory;
  getFoodReceiptCategory(
      {required BuildContext context, required String category}) async {
    receiptModelCategory =
        (await getFoodReceiptByCategory(context: context, category: 'Lunch'));
    notifyListeners();
  }
}

class FoodReceiptByDinner extends ChangeNotifier {
  List<FoodReceiptModel>? receiptModelCategory;
  getFoodReceiptCategory(
      {required BuildContext context, required String category}) async {
    receiptModelCategory =
        (await getFoodReceiptByCategory(context: context, category: 'Dinner'));
    notifyListeners();
  }
}

class FoodReceiptByDrink extends ChangeNotifier {
  List<FoodReceiptModel>? receiptModelCategory;
  getFoodReceiptCategory(
      {required BuildContext context, required String category}) async {
    receiptModelCategory =
        (await getFoodReceiptByCategory(context: context, category: 'Drink'));
    notifyListeners();
  }
}
