import 'package:healthy_buddy_mobile_app/core/extras/top_article_notifier.dart';
import 'package:healthy_buddy_mobile_app/core/foodies/food_articles_notifier.dart';
import 'package:healthy_buddy_mobile_app/core/foodies/food_receipt_notifier.dart';
import 'package:healthy_buddy_mobile_app/core/foodies/food_store_notifier.dart';
import 'package:healthy_buddy_mobile_app/core/sport/sport_exercise_notifier.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../core/extras/extras_notifier.dart';

class ProviderList {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider(
      create: (_) => FoodArticlesClass(),
    ),
    ChangeNotifierProvider(
      create: (_) => CarouselClass(),
    ),
    ChangeNotifierProvider(
      create: (_) => TopArticleClass(),
    ),
    ChangeNotifierProvider(
      create: (_) => FoodReceiptClass(),
    ),
    ChangeNotifierProvider(
      create: (_) => FoodReceiptByBreakfast(),
    ),
    ChangeNotifierProvider(
      create: (_) => FoodReceiptByLunch(),
    ),
    ChangeNotifierProvider(
      create: (_) => FoodReceiptByDinner(),
    ),
    ChangeNotifierProvider(
      create: (_) => FoodReceiptByDrink(),
    ),
    ChangeNotifierProvider(
      create: (_) => FoodStoreByBuahClass(),
    ),
    ChangeNotifierProvider(
      create: (_) => FoodStoreBySayuranClass(),
    ),
    ChangeNotifierProvider(
      create: (_) => FoodStoreByInstanClass(),
    ),
    ChangeNotifierProvider(
      create: (_) => FoodStoreByMinumanClass(),
    ),
    ChangeNotifierProvider(
      create: (_) => SportExerciseEasyClass(),
    ),
    ChangeNotifierProvider(
      create: (_) => SportExerciseMediumClass(),
    ),
    ChangeNotifierProvider(
      create: (_) => SportExerciseHardClass(),
    ),
  ];
}
