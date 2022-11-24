import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/models/user_model/user_model.dart';
import 'package:healthy_buddy_mobile_app/services/user_services/user_services.dart';
import 'package:http/http.dart' as http;

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

class UserUpdateNameClass extends ChangeNotifier {
  Future<void> updateName(
      UserModel body, String idUser, BuildContext context) async {
    notifyListeners();
    http.Response response = (await updateUserNameData(body, idUser, context))!;
    if (response.statusCode == 200) {
      debugPrint('Update Berhasil');
    }
    notifyListeners();
  }
}

class UserUpdateAddressClass extends ChangeNotifier {
  Future<void> updateAddress(
      UserModel body, String idUser, BuildContext context) async {
    notifyListeners();
    http.Response response = (await updateUserAddressData(body, idUser, context))!;
    if (response.statusCode == 200) {
      debugPrint('Update Berhasil');
    }
    notifyListeners();
  }
}

