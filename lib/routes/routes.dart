import 'package:healthy_buddy_mobile_app/screens/authentication/login_screen.dart';
import 'package:healthy_buddy_mobile_app/screens/authentication/register_screen.dart';
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
import 'package:healthy_buddy_mobile_app/screens/main_features_screens/sport/sport_main_screen.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/no_internet_found_screen.dart';

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
  static const String sportScreen = '/sport';
  static const String myDocScreen = '/myDocScreen';
  static const String myDocDetailScreen = '/myDocDetailScreen';
  static const String bodyScreen = '/index';
  static const String statePageUI = '/state';

  static final routes = {
    notInternetScreen: (context) => const NoInternetFoundScreen(),
    loginScreen: (context) => LoginScreen(),
    registerScreen: (context) => RegisterScreen(),
    homePageScreen: (context) => HomePage(),
    bodyScreen: (context) => BodyPageScreen(),
    foodiesScreen: (context) => const FoodiesScreen(),
    foodArticleMenu: (context) =>  FoodArticleScreen(),
    foodReceiptMenu: (context) => FoodReceiptMenuScreen(),
    foodReceiptDetailScreen: (context) => FoodReceiptDetailScreen(),
    foodStoreMenu: (context) => FoodStoreMainScreen(),
    foodStoreDetailScreen: (context) => FoodStoreDetailScreen(),
    sportScreen: (context) => const SportScreen(),
    myDocScreen: (context) => MyDocMainScreen(),
    myDocDetailScreen: (context) => MyDocDetailScreen(),
    statePageUI: (context) => const StatePageUI(),
  };
}
