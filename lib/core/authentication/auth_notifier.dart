import 'package:cache_manager/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/routes/routes.dart';
import 'package:healthy_buddy_mobile_app/services/user_services/auth_services.dart';
import 'package:http/http.dart' as http;

import '../../models/user_model/user_model.dart';

class RegisterDataClass extends ChangeNotifier {
  Future<void> postData(
    UserModel body,
  ) async {
    http.Response response = (await registerUserData(body))!;

    if (response.statusCode == 201) {
      debugPrint('Register User Data Success!');
    }
    notifyListeners();
  }
}

class AuthenticationNotifier extends ChangeNotifier {
  final AuthenticationService _authenticationService = AuthenticationService();
  Future<String?> registerUser(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      dynamic userId = await _authenticationService.registerUser(
          email: email, password: password, context: context);
      WriteCache.setString(key: 'cache', value: userId!).whenComplete(() {
        Navigator.pushNamedAndRemoveUntil(
            context, AppRoutes.biodataScreen, (route) => false,
            arguments: email);
      });
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
          email: email, password: password, context: context);
      print('userId : $userId');
      WriteCache.setString(key: 'cache', value: userId!).whenComplete(() {
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

  Future<void> changeEmail(String email) async {
    try {
      dynamic updateEmail =
          await _authenticationService.updateEmailUser(email: email);
      print(updateEmail);
    } catch (e) {
      print(e);
    }
  }
}
