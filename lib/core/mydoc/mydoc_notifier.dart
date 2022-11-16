import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/models/mydoc_model/mydoc_model.dart';
import 'package:healthy_buddy_mobile_app/services/my_doc_service/my_doc_service.dart';

class FoodStoreByBuahClass extends ChangeNotifier {
  List<MyDocModel>? foodStoreModel;
  getBuah({required BuildContext context, required String category}) async {
    foodStoreModel =
        (await getDoctorBySpecialist(context: context, specialist: 'Buah'));
    notifyListeners();
  }
}
