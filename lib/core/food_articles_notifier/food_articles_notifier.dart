import 'package:flutter/cupertino.dart';
import 'package:healthy_buddy_mobile_app/models/carousel_model.dart';
import 'package:healthy_buddy_mobile_app/models/food_article_model.dart';
import 'package:healthy_buddy_mobile_app/services/food_articles_service/carousel/get_carousel_article.dart';
import 'package:healthy_buddy_mobile_app/services/food_articles_service/get_food_article_service.dart';

class FoodArticlesClass extends ChangeNotifier {
  List<FoodArticleModel>? foodArticle;
  getFoodArticleData({required BuildContext context}) async {
    foodArticle = (await getFoodArticles(context: context));
    notifyListeners();
  }
}

class CarouselClass extends ChangeNotifier {
  List<CarouselModel>? carousel;
  getDataCarousel({required BuildContext context, required String section}) async {
    carousel = (await getCarouselItem(context: context, section: section));
    notifyListeners();
  }
}


