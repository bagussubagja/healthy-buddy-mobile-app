import 'package:healthy_buddy_mobile_app/core/authentication/auth_notifier.dart';
import 'package:healthy_buddy_mobile_app/core/authentication/user_notifier.dart';
import 'package:healthy_buddy_mobile_app/core/extras/top_article_notifier.dart';
import 'package:healthy_buddy_mobile_app/core/foodies/food_articles_notifier.dart';
import 'package:healthy_buddy_mobile_app/core/foodies/food_receipt_notifier.dart';
import 'package:healthy_buddy_mobile_app/core/foodies/food_store_notifier.dart';
import 'package:healthy_buddy_mobile_app/core/mydoc/mydoc_notifier.dart';
import 'package:healthy_buddy_mobile_app/core/purchase_history/purchase_history_notifier.dart';
import 'package:healthy_buddy_mobile_app/core/sport/sport_article_notifier.dart';
import 'package:healthy_buddy_mobile_app/core/sport/sport_exercise_notifier.dart';
import 'package:healthy_buddy_mobile_app/core/sport/sport_store_notifier.dart';
import 'package:healthy_buddy_mobile_app/core/sport/sport_website_notifier.dart';
import 'package:healthy_buddy_mobile_app/core/wishlist/foodies_wishlist_notifier.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../core/extras/carousel_item_notifier.dart';
import '../core/favorites/favorites_notifier.dart';
import '../core/wishlist/sport_wishlist_notifier.dart';

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
      create: (_) => SportArticleClass(),
    ),
    ChangeNotifierProvider(
      create: (_) => SportExerciseAllClass(),
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
    ChangeNotifierProvider(
      create: (_) => SportStoreGeneralClass(),
    ),
    ChangeNotifierProvider(
      create: (_) => SportStoreSoccerClass(),
    ),
    ChangeNotifierProvider(
      create: (_) => SportStoreAthleticClass(),
    ),
    ChangeNotifierProvider(
      create: (_) => SportStoreBadmintonClass(),
    ),
    ChangeNotifierProvider(
      create: (_) => SportStoreSwimmingClass(),
    ),
    ChangeNotifierProvider(
      create: (_) => SportWebsiteFootballClass(),
    ),
    ChangeNotifierProvider(
      create: (_) => SportWebsiteRacingClass(),
    ),
    ChangeNotifierProvider(
      create: (_) => SportWebsiteBadmintonClass(),
    ),
    ChangeNotifierProvider(
      create: (_) => SportWebsiteBasketClass(),
    ),
    ChangeNotifierProvider(
      create: (_) => SportWebsiteOtherClass(),
    ),
    ChangeNotifierProvider(
      create: (_) => MyDocByPulmonologyClass(),
    ),
    ChangeNotifierProvider(
      create: (_) => MyDocByCardiologyClass(),
    ),
    ChangeNotifierProvider(
      create: (_) => MyDocByMentalHealthClass(),
    ),
    ChangeNotifierProvider(
      create: (_) => MyDocByHepatologyClass(),
    ),
    ChangeNotifierProvider(
      create: (_) => MyDocByExperienceClass(),
    ),
    ChangeNotifierProvider(
      create: (_) => MyDocAllClass(),
    ),
    ChangeNotifierProvider(
      create: (_) => MyDocByPulmonologyClass(),
    ),
    ChangeNotifierProvider(
      create: (_) => MyDocByCardiologyClass(),
    ),
    ChangeNotifierProvider(
      create: (_) => MyDocByMentalHealthClass(),
    ),
    ChangeNotifierProvider(
      create: (_) => MyDocByHepatologyClass(),
    ),
    ChangeNotifierProvider(
      create: (_) => MyDocScheduleAppointmentClass(),
    ),
    ChangeNotifierProvider(
      create: (_) => UpdateStatusAppointmentClass(),
    ),
    ChangeNotifierProvider(
      create: (_) => AuthenticationNotifier(),
    ),
    ChangeNotifierProvider(
      create: (_) => RegisterDataClass(),
    ),
    ChangeNotifierProvider(
      create: (_) => UserClass(),
    ),
    ChangeNotifierProvider(
      create: (_) => UserUpdateNameClass(),
    ),
    ChangeNotifierProvider(
      create: (_) => UserUpdateAddressClass(),
    ),
    ChangeNotifierProvider(
      create: (_) => UserUpdateSelfDataClass(),
    ),
    ChangeNotifierProvider(
      create: (_) => UserTopUpClass(),
    ),
    ChangeNotifierProvider(
      create: (_) => UserDiscountClass(),
    ),
    ChangeNotifierProvider(
      create: (_) => FoodiesWishlistClass(),
    ),
    ChangeNotifierProvider(
      create: (_) => SportWishlistClass(),
    ),
    ChangeNotifierProvider(
      create: (_) => PurchaseHistoryClass(),
    ),
    ChangeNotifierProvider(
      create: (_) => PurchaseHistoryClass(),
    ),
    ChangeNotifierProvider(
      create: (_) => PurchaseHistoryClass(),
    ),
    ChangeNotifierProvider(
      create: (_) => FavoriteClass(),
    ),
  ];
}
