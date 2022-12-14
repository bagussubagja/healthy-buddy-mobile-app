import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/models/foodies_model/food_store_model.dart';
import 'package:healthy_buddy_mobile_app/models/foodies_model/wishlist_foodies_model.dart';
import 'package:healthy_buddy_mobile_app/models/mydoc_model/mydoc_model.dart';
import 'package:healthy_buddy_mobile_app/screens/authentication/biodata_screen.dart';
import 'package:healthy_buddy_mobile_app/screens/authentication/login_screen.dart';
import 'package:healthy_buddy_mobile_app/screens/authentication/register_screen.dart';
import 'package:healthy_buddy_mobile_app/screens/home/profile_screen.dart';
import 'package:healthy_buddy_mobile_app/screens/home/settings/about_us/about_us_screen.dart';
import 'package:healthy_buddy_mobile_app/screens/home/settings/account/account_settings_screen.dart';
import 'package:healthy_buddy_mobile_app/screens/home/settings/help_center/help_center_screen.dart';
import 'package:healthy_buddy_mobile_app/screens/home/settings/purchase_history/purcase_history_screen.dart';
import 'package:healthy_buddy_mobile_app/screens/home/state_ui.dart';
import 'package:healthy_buddy_mobile_app/screens/home/top_article/top_article_screen.dart';
import 'package:healthy_buddy_mobile_app/screens/home/wishslist/wishslist_screen.dart';
import 'package:healthy_buddy_mobile_app/screens/main_features_screens/foodies/food-article-screen/food_article_screen.dart';
import 'package:healthy_buddy_mobile_app/screens/main_features_screens/foodies/food-calculator-screen/food_calculator_screen.dart';
import 'package:healthy_buddy_mobile_app/screens/main_features_screens/foodies/food-recipe-screen/food_recipe_detail_screen.dart';
import 'package:healthy_buddy_mobile_app/screens/main_features_screens/foodies/food-recipe-screen/food_recipe_menu.dart';
import 'package:healthy_buddy_mobile_app/screens/main_features_screens/foodies/food-store-screen/food_store_detail_screen.dart';
import 'package:healthy_buddy_mobile_app/screens/main_features_screens/foodies/food-store-screen/food_store_main_screen.dart';
import 'package:healthy_buddy_mobile_app/screens/main_features_screens/foodies/food-store-screen/food_store_status_order_screen.dart';
import 'package:healthy_buddy_mobile_app/screens/main_features_screens/foodies/foodies_main_screen.dart';
import 'package:healthy_buddy_mobile_app/screens/home/body_page_screen.dart';
import 'package:healthy_buddy_mobile_app/screens/home/home_page.dart';
import 'package:healthy_buddy_mobile_app/screens/main_features_screens/mydoc/appoinment_screen/appointment_confirmation_screen.dart';
import 'package:healthy_buddy_mobile_app/screens/main_features_screens/mydoc/appoinment_screen/appointment_history_screen.dart';
import 'package:healthy_buddy_mobile_app/screens/main_features_screens/mydoc/category_screen/mydoc_category_screen.dart';
import 'package:healthy_buddy_mobile_app/screens/main_features_screens/mydoc/detail_screen/mydoc_detail_screen.dart';
import 'package:healthy_buddy_mobile_app/screens/main_features_screens/mydoc/mydoc_main_screen.dart';
import 'package:healthy_buddy_mobile_app/screens/main_features_screens/mydoc/top_doctor_screen/top_doctor_screen.dart';
import 'package:healthy_buddy_mobile_app/screens/main_features_screens/sport/sport-article-screen/sport_article_screen.dart';

import 'package:healthy_buddy_mobile_app/screens/main_features_screens/sport/sport-website-screen/sport_website_screen.dart';
import 'package:healthy_buddy_mobile_app/screens/main_features_screens/sport/sport_exercise_screen/sport_exercise_screen.dart';
import 'package:healthy_buddy_mobile_app/screens/main_features_screens/sport/sport_main_screen.dart';
import 'package:healthy_buddy_mobile_app/screens/main_features_screens/topup_balance/topup_balance_screen.dart';
import 'package:healthy_buddy_mobile_app/screens/extras/no_internet_found_screen.dart';


class AppRoutes {
  static const String notInternetScreen = '/nointernet';
  static const String loginScreen = '/login';
  static const String registerScreen = '/register';
  static const String biodataScreen = '/biodata';
  static const String homePageScreen = '/home';
  static const String profileScreen = '/profile';
  static const String wishlistScreen = '/wishlist';
  static const String topArticleScreen = '/topArticleScreen';
  static const String foodiesScreen = '/foodies';
  static const String foodReceiptMenu = '/foodReceipt';
  static const String foodArticleMenu = '/foodArticle';
  static const String foodReceiptDetailScreen = '/foodReceiptDetailScreen';
  static const String foodStoreMenu = '/foodStore';
  static const String foodCalculatorScreen = '/foodCalculator';
  static const String foodStoreDetailScreen = '/foodStoreDetail';
  static const String foodStoreStatusOrder = '/foodConfirmOrder';
  static const String sportScreen = '/sport';
  static const String sportArticle = '/sportArticle';
  static const String sportWebsite = '/sportWebsite';
  static const String sportExercise = '/sportExercise';
  static const String sportStore = '/sportStore';
  static const String myDocScreen = '/myDocScreen';
  static const String myDocCategoryScreen = '/myDocCategory';
  static const String myDocDetailScreen = '/myDocDetailScreen';
  static const String myDocTopDocScreen = '/myDocTopDocScreen';
  static const String myDocAppointmentScreen = '/myDocAppointmentScreen';
  static const String myDocAppointmentHistoryScreen =
      '/myDocAppointmentHistoryScreen';
  static const String topUpScreen = '/topup';
  static const String bodyScreen = '/index';
  static const String statePageUI = '/state';
  static const String accountSettingScreen = '/account';
  static const String aboutUsScreen = '/aboutUs';
  static const String helpCenterScreen = '/helpCenter';
  static const String purchaseHistoryScreen = '/purchaseHistrory';

  static final routes = {
    notInternetScreen: (context) => const NoInternetFoundScreen(),
    loginScreen: (context) => const LoginScreen(),
    registerScreen: (context) => const RegisterScreen(),
    homePageScreen: (context) => const HomePage(),
    bodyScreen: (context) => const BodyPageScreen(),
    foodiesScreen: (context) => const FoodiesScreen(),
    foodArticleMenu: (context) => const FoodArticleScreen(),
    foodReceiptMenu: (context) => const FoodReceiptMenuScreen(),
    foodReceiptDetailScreen: (context) => FoodReceiptDetailScreen(),
    foodStoreMenu: (context) => const FoodStoreMainScreen(),
    sportScreen: (context) => const SportScreen(),
    sportArticle: (context) => const SportArticleScreen(),
    myDocScreen: (context) => const MyDocMainScreen(),
    topUpScreen: (context) => const TopUpScreen(),
    statePageUI: (context) => const StatePageUI(),
    accountSettingScreen: (context) => const AccountSettingScreen(),
    aboutUsScreen: (context) => AboutUsScreen(),
    helpCenterScreen: (context) => const HelpCenterScreen()
  };

  static Route<dynamic> handlingGenerateRoute(RouteSettings settings) {
    String route = settings.name ?? '/';

    switch (route) {
      case AppRoutes.notInternetScreen:
        return getPage(const StatePageUI());
      case AppRoutes.loginScreen:
        return getPage(const LoginScreen());
      case AppRoutes.registerScreen:
        return getPage(const RegisterScreen());
      case AppRoutes.biodataScreen:
        final email = settings.arguments as String;
        return getPage(BiodataScreen(
          email: email,
        ));
      case AppRoutes.homePageScreen:
        return getPage(const HomePage());
      case AppRoutes.profileScreen:
        return getPage(const ProfileScreen());
      case AppRoutes.topArticleScreen:
        return getPage(const TopArticleScreen());
      case AppRoutes.wishlistScreen:
        return getPage(const WishlistScreen());
      case AppRoutes.bodyScreen:
        return getPage(const BodyPageScreen());
      case AppRoutes.foodiesScreen:
        return getPage(const FoodiesScreen());
      case AppRoutes.foodCalculatorScreen:
        return getPage(FoodCalculatorScreen());
      case AppRoutes.foodArticleMenu:
        return getPage(const FoodArticleScreen());
      case AppRoutes.foodReceiptMenu:
        return getPage(const FoodReceiptMenuScreen());
      case AppRoutes.foodReceiptDetailScreen:
        return getPage(FoodReceiptDetailScreen());
      case AppRoutes.foodStoreMenu:
        return getPage(const FoodStoreMainScreen());
      case AppRoutes.foodStoreDetailScreen:
        final food = settings.arguments as FoodStoreModel;
        final wishlistFood = settings.arguments as FoodStore;
        return getPage(
          FoodStoreDetailScreen(
            foodStoreModel: food,
            foodStore: wishlistFood,
          ),
        );
      case AppRoutes.foodStoreStatusOrder:
        return getPage(const FoodStoreStatusOrderScreen());
      case AppRoutes.myDocScreen:
        return getPage(const MyDocMainScreen());
      case AppRoutes.myDocCategoryScreen:
        final index = settings.arguments as int;
        return getPage(MyDocCategoryScreen(
          index: index,
        ));
      case AppRoutes.myDocDetailScreen:
        final doctor = settings.arguments as MyDocModel;
        return getPage(MyDocDetailScreen(
          myDocModel: doctor,
        ));
      case AppRoutes.myDocAppointmentScreen:
        return getPage(AppointmentConfirmationScreen());
      case AppRoutes.myDocAppointmentHistoryScreen:
        return getPage(const MyDocAppointmentHistoryScreen());
      case AppRoutes.myDocTopDocScreen:
        return getPage(const TopDoctorScreen());
      case AppRoutes.sportScreen:
        return getPage(const SportScreen());
      case AppRoutes.sportArticle:
        return getPage(const SportArticleScreen());
      case AppRoutes.sportExercise:
        return getPage(const SportExerciseScreen());
      case AppRoutes.sportWebsite:
        return getPage(const SportWebsiteScreen());
      case AppRoutes.topUpScreen:
        return getPage(const TopUpScreen());
      case AppRoutes.accountSettingScreen:
        return getPage(const AccountSettingScreen());
      case AppRoutes.aboutUsScreen:
        return getPage(AboutUsScreen());
      case AppRoutes.helpCenterScreen:
        return getPage(const HelpCenterScreen());
      case AppRoutes.purchaseHistoryScreen:
        return getPage(const PurchaseHistoryScreen());
      default:
        return getPage(const Scaffold(
          body: Text("Route Tidak Ada"),
        ));
    }
  }
}

MaterialPageRoute<dynamic> getPage(Widget page) =>
    MaterialPageRoute(builder: (context) => page);
