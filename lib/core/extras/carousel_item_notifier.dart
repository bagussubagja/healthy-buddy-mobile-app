import 'package:flutter/material.dart';

import '../../models/carousel_model.dart';
import '../../services/carousel_services/get_carousel_article.dart';

class CarouselClass extends ChangeNotifier {
  List<CarouselModel>? carousel;
  bool isLoading = false;

  getDataCarousel(
      {required BuildContext context, required String section}) async {
    isLoading = true;
    carousel = (await getCarouselItem(context: context, section: section));
    isLoading = false;
    notifyListeners();
  }
}
