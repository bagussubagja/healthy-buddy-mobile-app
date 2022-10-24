import 'package:flutter/cupertino.dart';
import 'package:healthy_buddy_mobile_app/models/food_article/carousel_ver_model.dart';
import 'package:healthy_buddy_mobile_app/models/food_article/food_article_model.dart';
import 'package:healthy_buddy_mobile_app/services/food_articles_service/carousel/get_carousel_article.dart';
import 'package:healthy_buddy_mobile_app/services/food_articles_service/get_food_article_service.dart';

class FoodArticlesClass extends ChangeNotifier {
  List<FoodArticleModel>? foodArticle;
  getFoodArticleData({required BuildContext context}) async {
    foodArticle = (await getFoodArticles(context: context));
    notifyListeners();
  }
}

class FoodArticlesCarouselClass extends ChangeNotifier {
  List<FoodArticleCarouselModel>? foodArticleCarousel;
  getFoodArticleDataCarouselVer({required BuildContext context}) async {
    foodArticleCarousel = (await getFoodArticlesCarousel(context: context));
    notifyListeners();
  }
}


