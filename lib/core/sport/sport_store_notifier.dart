import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/models/sport_model/sport_exercise_model.dart';
import 'package:healthy_buddy_mobile_app/models/sport_model/sport_store_model.dart';
import 'package:healthy_buddy_mobile_app/services/sport_services/sport_exercise_service.dart';
import 'package:healthy_buddy_mobile_app/services/sport_services/sport_store_service.dart';

class SportStoreGeneralClass extends ChangeNotifier {
  List<SportStoreModel>? sportStore;
  getSport({required BuildContext context, required String category}) async {
    sportStore =
        (await getSportStorebyCategory(context: context, category: 'General'));
    notifyListeners();
  }
}

class SportStoreSoccerClass extends ChangeNotifier {
  List<SportStoreModel>? sportStore;
  getSport({required BuildContext context, required String category}) async {
    sportStore =
        (await getSportStorebyCategory(context: context, category: 'Soccer'));
    notifyListeners();
  }
}

class SportStoreAthleticClass extends ChangeNotifier {
  List<SportStoreModel>? sportStore;
  getSport({required BuildContext context, required String category}) async {
    sportStore =
        (await getSportStorebyCategory(context: context, category: 'Athletic'));
    notifyListeners();
  }
}

class SportStoreBadmintonClass extends ChangeNotifier {
  List<SportStoreModel>? sportStore;
  getSport({required BuildContext context, required String category}) async {
    sportStore =
        (await getSportStorebyCategory(context: context, category: 'Badminton'));
    notifyListeners();
  }
}
