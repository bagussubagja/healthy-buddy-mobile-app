import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/models/top_article_model.dart';
import 'package:healthy_buddy_mobile_app/services/top-article-services/top_article_service.dart';

class TopArticleClass extends ChangeNotifier {
  List<TopArticleModel>? articles;
  getArticle({required BuildContext context}) async {
    articles = (await getTopArticles(context: context));
    notifyListeners();
  }
}