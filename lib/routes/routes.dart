
import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/models/foodies_model/food_store_model.dart';
import 'package:healthy_buddy_mobile_app/models/mydoc_model/mydoc_model.dart';
import 'package:healthy_buddy_mobile_app/screens/authentication/login_screen.dart';
import 'package:healthy_buddy_mobile_app/screens/authentication/register_screen.dart';
import 'package:healthy_buddy_mobile_app/screens/home/settings/about_us/about_us_screen.dart';
import 'package:healthy_buddy_mobile_app/screens/home/settings/account/account_settings_screen.dart';
import 'package:healthy_buddy_mobile_app/screens/home/settings/help_center/help_center_screen.dart';
import 'package:healthy_buddy_mobile_app/screens/home/state_ui.dart';
import 'package:healthy_buddy_mobile_app/screens/main_features_screens/foodies/food-article-screen/food_article_screen.dart';
import 'package:healthy_buddy_mobile_app/screens/main_features_screens/foodies/food-receipt-screen/food_receipt_detail_screen.dart';
import 'package:healthy_buddy_mobile_app/screens/main_features_screens/foodies/food-receipt-screen/food_receipt_menu.dart';
import 'package:healthy_buddy_mobile_app/screens/main_features_screens/foodies/food-store-screen/food_store_detail_screen.dart';
import 'package:healthy_buddy_mobile_app/screens/main_features_screens/foodies/food-store-screen/food_store_main_screen.dart';
import 'package:healthy_buddy_mobile_app/screens/main_features_screens/foodies/foodies_main_screen.dart';
import 'package:healthy_buddy_mobile_app/screens/home/body_page_screen.dart';
import 'package:healthy_buddy_mobile_app/screens/home/home_page.dart';
import 'package:healthy_buddy_mobile_app/screens/main_features_screens/mydoc/detail_screen/mydoc_detail_screen.dart';
import 'package:healthy_buddy_mobile_app/screens/main_features_screens/mydoc/mydoc_main_screen.dart';
import 'package:healthy_buddy_mobile_app/screens/main_features_screens/sport/sport-store-screen/sport_store_main_screen.dart';
import 'package:healthy_buddy_mobile_app/screens/main_features_screens/sport/sport_main_screen.dart';
import 'package:healthy_buddy_mobile_app/screens/main_features_screens/topup/topup_screen.dart';
import 'package:healthy_buddy_mobile_app/screens/extras/no_internet_found_screen.dart';
import 'package:http/http.dart';

class AppRoutes {
  static const String notInternetScreen = '/nointernet';
  static const String loginScreen = '/login';
  static const String registerScreen = '/register';
  static const String homePageScreen = '/home';
  static const String foodiesScreen = '/foodies';
  static const String foodReceiptMenu = '/foodReceipt';
  static const String foodArticleMenu = '/foodArticle';
  static const String foodReceiptDetailScreen = '/foodReceiptDetailScreen';
  static const String foodStoreMenu = '/foodStore';
  static const String foodStoreDetailScreen = '/foodStoreDetail';
  static const String foodStoreConfirmOrder = '/foodConfirmOrder';
  static const String sportScreen = '/sport';
  static const String sportStore = '/sportStore';
  static const String myDocScreen = '/myDocScreen';
  static const String myDocDetailScreen = '/myDocDetailScreen';
  static const String topUpScreen = '/topup';
  static const String bodyScreen = '/index';
  static const String statePageUI = '/state';
  static const String accountSettingScreen = '/account';
  static const String aboutUsScreen = '/aboutUs';
  static const String helpCenterScreen = '/helpCenter';

  static final routes = {
    notInternetScreen: (context) => const NoInternetFoundScreen(),
    loginScreen: (context) => LoginScreen(),
    registerScreen: (context) => RegisterScreen(),
    homePageScreen: (context) => HomePage(),
    bodyScreen: (context) => BodyPageScreen(),
    foodiesScreen: (context) => const FoodiesScreen(),
    foodArticleMenu: (context) => FoodArticleScreen(),
    foodReceiptMenu: (context) => FoodReceiptMenuScreen(),
    foodReceiptDetailScreen: (context) => FoodReceiptDetailScreen(),
    foodStoreMenu: (context) => FoodStoreMainScreen(),
    sportScreen: (context) => const SportScreen(),
    sportStore: (context) => SportStoreMainScreen(),
    myDocScreen: (context) => MyDocMainScreen(),
    topUpScreen: (context) => TopUpScreen(),
    statePageUI: (context) => const StatePageUI(),
    accountSettingScreen: (context) => AccountSettingScreen(),
    aboutUsScreen: (context) => AboutUsScreen(),
    helpCenterScreen: (context) => HelpCenterScreen()
  };

  static Route<dynamic> handlingGenerateRoute(RouteSettings settings) {
    String route = settings.name ?? '/';

    switch (route) {
      case AppRoutes.notInternetScreen:
        return getPage(const StatePageUI());
      case AppRoutes.loginScreen:
        return getPage(LoginScreen());
      case AppRoutes.registerScreen:
        return getPage(RegisterScreen());
      case AppRoutes.homePageScreen:
        return getPage(HomePage());
      case AppRoutes.bodyScreen:
        return getPage(BodyPageScreen());
      case AppRoutes.foodiesScreen:
        return getPage(const FoodiesScreen());
      case AppRoutes.foodArticleMenu:
        return getPage(const FoodArticleScreen());
      case AppRoutes.foodReceiptMenu:
        return getPage(FoodReceiptMenuScreen());
      case AppRoutes.foodReceiptDetailScreen:
        return getPage(FoodReceiptDetailScreen());
      case AppRoutes.foodStoreMenu:
        return getPage(const FoodStoreMainScreen());
      case AppRoutes.foodStoreDetailScreen:
        final food = settings.arguments as FoodStoreModel;
        return getPage(
          FoodStoreDetailScreen(
            foodStoreModel: food,
          ),
        );
      case AppRoutes.myDocScreen:
        return getPage(MyDocMainScreen());
      case AppRoutes.myDocDetailScreen:
        final doctor = settings.arguments as MyDocModel;
        return getPage(MyDocDetailScreen(
          myDocModel: doctor,
        ));
      case AppRoutes.sportScreen:
        return getPage(const SportScreen());
      case AppRoutes.sportStore:
        return getPage(const SportStoreMainScreen());
      case AppRoutes.topUpScreen:
        return getPage(TopUpScreen());
      case AppRoutes.accountSettingScreen:
        return getPage(AccountSettingScreen());
      case AppRoutes.aboutUsScreen:
        return getPage(AboutUsScreen());
      case AppRoutes.helpCenterScreen:
        return getPage(HelpCenterScreen());
      default:
        return getPage(const Scaffold(
          body: Text("Route Tidak Ada"),
        ));
    }
  }
}

MaterialPageRoute<dynamic> getPage(Widget page) =>
    MaterialPageRoute(builder: (context) => page);
