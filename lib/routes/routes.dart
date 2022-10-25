import 'package:healthy_buddy_mobile_app/screens/authentication/login_screen.dart';
import 'package:healthy_buddy_mobile_app/screens/authentication/register_screen.dart';
import 'package:healthy_buddy_mobile_app/screens/main_features_screens/foodies/foodies_screen.dart';
import 'package:healthy_buddy_mobile_app/screens/home/body_page_screen.dart';
import 'package:healthy_buddy_mobile_app/screens/home/home_page.dart';

class AppRoutes {
  static const String loginScreen = '/login';
  static const String registerScreen = '/register';
  static const String homePageScreen = '/home';
  static const String foodiesScreen = '/foodies';
  static const String bodyScreen = '/';

  static final routes = {
    loginScreen: (context) => LoginScreen(),
    registerScreen: (context) => RegisterScreen(),
    homePageScreen: (context) => HomePage(),
    bodyScreen: (context) => BodyPageScreen(),
    foodiesScreen: (context) => FoodiesScreen()
  };
}
