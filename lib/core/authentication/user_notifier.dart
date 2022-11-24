import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/models/user_model/user_model.dart';
import 'package:healthy_buddy_mobile_app/services/user_services/user_services.dart';

class UserClass extends ChangeNotifier {
  List<UserModel>? users;
  bool isLoading = false;

  getUser({required BuildContext context, required String idUser}) async {
    isLoading = true;
    users = (await getUserData(context: context, idUser: idUser));
    isLoading = false;
    notifyListeners();
  }
}
