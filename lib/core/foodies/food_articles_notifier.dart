import 'package:flutter/cupertino.dart';
import 'package:healthy_buddy_mobile_app/models/carousel_model.dart';
import 'package:healthy_buddy_mobile_app/models/foodies_model/food_article_model.dart';
import 'package:healthy_buddy_mobile_app/services/carousel_services/get_carousel_article.dart';
import 'package:healthy_buddy_mobile_app/services/foodies_services/food_articles_service/get_food_article_service.dart';

class FoodArticlesClass extends ChangeNotifier {
  List<FoodArticleModel>? foodArticle;
  bool isLoading = false;

  getFoodArticleData({required BuildContext context}) async {
    isLoading = true;
    foodArticle = (await getFoodArticles(context: context));
    isLoading = false;
    notifyListeners();
  }
}
