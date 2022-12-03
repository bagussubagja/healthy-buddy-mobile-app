import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/models/sport_model/sport_website_model.dart';
import 'package:healthy_buddy_mobile_app/services/sport_services/sport_website_service.dart';

class SportWebsiteFootballClass extends ChangeNotifier {
  List<SportWebsiteModel>? sportWebsite;
  getSportWebsite({required BuildContext context, required String category}) async {
    sportWebsite = (await getSportWebsiteByCategory(context: context, category: "Football"));
    notifyListeners();
  }
}

class SportWebsiteRacingClass extends ChangeNotifier {
  List<SportWebsiteModel>? sportWebsite;
  getSportWebsite({required BuildContext context, required String category}) async {
    sportWebsite = (await getSportWebsiteByCategory(context: context, category: "Racing"));
    notifyListeners();
  }
}

class SportWebsiteBadmintonClass extends ChangeNotifier {
  List<SportWebsiteModel>? sportWebsite;
  getSportWebsite({required BuildContext context, required String category}) async {
    sportWebsite = (await getSportWebsiteByCategory(context: context, category: "Badminton"));
    notifyListeners();
  }
}

class SportWebsiteBasketClass extends ChangeNotifier {
  List<SportWebsiteModel>? sportWebsite;
  getSportWebsite({required BuildContext context, required String category}) async {
    sportWebsite = (await getSportWebsiteByCategory(context: context, category: "Basket"));
    notifyListeners();
  }
}

class SportWebsiteOtherClass extends ChangeNotifier {
  List<SportWebsiteModel>? sportWebsite;
  getSportWebsite({required BuildContext context, required String category}) async {
    sportWebsite = (await getSportWebsiteByCategory(context: context, category: "Others"));
    notifyListeners();
  }
}