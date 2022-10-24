import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/core/food_articles_notifier/food_articles_notifier.dart';
import 'package:healthy_buddy_mobile_app/models/food_article/carousel_ver_model.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/margin_height.dart';
import 'package:healthy_buddy_mobile_app/shared/theme.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class FoodiesScreen extends StatefulWidget {
  const FoodiesScreen({super.key});

  @override
  State<FoodiesScreen> createState() => _FoodiesScreenState();
}

class _FoodiesScreenState extends State<FoodiesScreen> {
  bool _isLoading = true;
  void loadingCompleted() {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    final itemCarousel =
        Provider.of<FoodArticlesCarouselClass>(context, listen: false);
    itemCarousel.getFoodArticleDataCarouselVer(context: context);
    Timer(const Duration(seconds: 3), loadingCompleted);
  }

  @override
  Widget build(BuildContext context) {
    final itemCarousel = Provider.of<FoodArticlesCarouselClass>(context);
    final item = itemCarousel.foodArticleCarousel?[0];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: blackColor,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_horiz_rounded,
                color: blackColor,
              ))
        ],
      ),
      body: _isLoading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: Padding(
                padding: defaultPadding,
                child: ListView(
                  children: [
                    Text(
                      'Foodies',
                      style: titleStyle.copyWith(color: greenColor),
                    ),
                    MarginHeight(height: 0.5.h),
                    Text(
                      'Disini tempat mencari makanan sehat!',
                      style: regularStyle.copyWith(color: greyTextColor),
                    ),
                    MarginHeight(height: 1.h),
                    CarouselSlider.builder(
                        itemCount: 3,
                        itemBuilder: (context, index, realIndex) {
                          return Container(
                            color: greyColor,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.network(
                                  item?.thumbnail?[index] ??
                                      'https://i.ytimg.com/vi/uBBDMqZKagY/sddefault.jpg',
                                  fit: BoxFit.cover,
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      Colors.black,
                                      Colors.black12,
                                    ],
                                  )),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${item?.title?[index].substring(0, 45)}..",
                                          style: regularStyle.copyWith(
                                              color: whiteColor),
                                        ),
                                        Text(
                                          "Read More",
                                          style: regularStyle.copyWith(
                                              color: greyTextColor,
                                              fontSize: 13),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        options: CarouselOptions(
                          enlargeCenterPage: true,
                          height: 200,
                          autoPlay: true,
                          aspectRatio: 16 / 9,
                        ))
                  ],
                ),
              ),
            ),
    );
  }
}
