import 'package:healthy_buddy_mobile_app/core/food_articles_notifier/food_articles_notifier.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class ProviderList {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider(
      create: (_) => FoodArticlesClass(),
    ),
    ChangeNotifierProvider(
      create: (_) => CarouselClass(),
    ),
  ];
}
