import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/models/sport_model/sport_article_model.dart';
import 'package:healthy_buddy_mobile_app/services/sport_services/sport_article_service.dart';

class SportArticleClass extends ChangeNotifier {
  List<SportArticleModel>? sportArticle;
  getSport({required BuildContext context}) async {
    sportArticle = (await getSportArticle(context: context));
    notifyListeners();
  }
}
