import 'package:cache_manager/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/routes/routes.dart';
import 'package:healthy_buddy_mobile_app/services/user_services/auth_services.dart';

class AuthenticationNotifier extends ChangeNotifier {
  final AuthenticationService _authenticationService = AuthenticationService();
  Future<String?> registerUser(
      {required String email, required String password}) async {
    try {
      await _authenticationService.registerUser(
          email: email, password: password);
    } catch (e) {
      print(e);
    }
  }

  Future<String?> loginUser(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      dynamic userId = await _authenticationService.loginUser(
          email: email, password: password);
      print('userId : $userId');
      WriteCache.setString(key: 'cache', value: userId).whenComplete(() {
        Navigator.pushNamedAndRemoveUntil(
            context, AppRoutes.statePageUI, (route) => false);
      });
    } catch (e) {
      print(e);
    }
  }

    Future<void> logOut() async {
    try {
      await _authenticationService.logOut();
    } catch (e) {
      print(e);
    }
  }
}

