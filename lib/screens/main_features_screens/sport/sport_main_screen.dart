import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/core/food_articles_notifier/food_articles_notifier.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/margin_height.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/margin_width.dart';
import 'package:healthy_buddy_mobile_app/shared/theme.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:appinio_animated_toggle_tab/appinio_animated_toggle_tab.dart';

import '../../../shared/assets_directory.dart';

class SportScreen extends StatefulWidget {
  const SportScreen({super.key});

  @override
  State<SportScreen> createState() => _SportScreenState();
}

class _SportScreenState extends State<SportScreen> {
  bool _isLoading = true;
  final String _placeHolder =
      'https://i.ytimg.com/vi/uBBDMqZKagY/sddefault.jpg';
  void loadingCompleted() {
    setState(() {
      _isLoading = false;
    });
  }

  final List<String> _iconImage = [
    "sport-article.png",
    "sport-pedia.png",
    "sport-store.png"
  ];
  final List<String> _iconLabel = [
    "Sport Article",
    "Sport Pedia",
    "Sport Store",
  ];

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    final itemCarousel = Provider.of<CarouselClass>(context, listen: false);
    itemCarousel.getDataCarousel(context: context, section: "sport");
    final item = Provider.of<FoodArticlesClass>(context, listen: false);
    item.getFoodArticleData(context: context);
    Timer(const Duration(seconds: 5), loadingCompleted);
  }

  @override
  Widget build(BuildContext context) {
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
                    _headerSection(),
                    MarginHeight(height: 1.h),
                    _carouselSection(),
                    MarginHeight(height: 3.h),
                    _sportCategory(),
                    MarginHeight(height: 2.h),
                    Center(
                      child: AppinioAnimatedToggleTab(
                        callback: (int i) {
                          setState(() {
                            _currentIndex = i;
                          });
                        },
                        tabTexts: const [
                          'Easy',
                          'Medium',
                          'Hard',
                        ],
                        height: 40,
                        width: 300,
                        boxDecoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        animatedBoxDecoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFc3d2db).withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(2, 2),
                            ),
                          ],
                          color: greenColor.withOpacity(0.25),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5),
                          ),
                          border: Border.all(
                            color: greenDarkerColor,
                            width: 1,
                          ),
                        ),
                        activeStyle: TextStyle(
                          color: greenDarkerColor,
                        ),
                        inactiveStyle: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    _currentIndex == 0 ? Text("Test") : Text('data'),
                    // _tipOfTheDay()
                  ],
                ),
              ),
            ),
    );
  }

  Widget _headerSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sport',
          style: titleStyle.copyWith(color: greenColor),
        ),
        MarginHeight(height: 0.5.h),
        Text(
          'Hal spesial untuk kamu, olahragawan!',
          style: regularStyle.copyWith(color: greyTextColor),
        ),
      ],
    );
  }

  Widget _carouselSection() {
    final itemCarousel = Provider.of<CarouselClass>(context);
    final item = itemCarousel.carousel?[0];
    return CarouselSlider.builder(
      itemCount: 3,
      itemBuilder: (context, index, realIndex) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            color: greyColor,
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  child: Image.network(
                    item?.thumbnail[index] ?? _placeHolder,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black,
                      greyColor.withOpacity(0.1),
                    ],
                  )),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${item?.title[index].substring(0, 45)}..",
                          style: regularStyle.copyWith(color: whiteColor),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            "Read More",
                            style: regularStyle.copyWith(
                                color: greyTextColor, fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      options: CarouselOptions(
        enlargeCenterPage: true,
        height: 200,
        autoPlay: true,
        aspectRatio: 16 / 9,
      ),
    );
  }

  Widget _sportCategory() {
    return SizedBox(
      height: 14.5.h,
      width: double.infinity,
      child: Center(
        child: ListView.separated(
          separatorBuilder: (context, index) {
            return MarginWidth(width: 9.w);
          },
          itemCount: _iconImage.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 7.h,
                    decoration: BoxDecoration(
                      color: greenColor.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.asset(
                      '$iconDirectory/${_iconImage[index]}',
                      scale: 1.5.h,
                    ),
                  ),
                ),
                Text(
                  _iconLabel[index].replaceAll(" ", "\n"),
                  style: regularStyle,
                  textAlign: TextAlign.center,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _tipOfTheDay() {
    final item = Provider.of<FoodArticlesClass>(context, listen: false);
    return Column(
      children: [
        MarginHeight(height: 2.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Article of the Day",
              style: titleStyle,
            ),
            Text(
              'Lihat Semua',
              style: regularStyle.copyWith(color: greyTextColor),
            )
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          primary: false,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: item.foodArticle?.length,
          itemBuilder: (context, index) {
            final itemArticle = item.foodArticle?[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 15),
              padding: defaultPadding,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: greyColor, borderRadius: BorderRadius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      itemArticle?.thumbnail ?? _placeHolder,
                      fit: BoxFit.cover,
                    ),
                  ),
                  MarginHeight(height: 1.h),
                  Text(
                    itemArticle?.title ?? 'Loading...',
                    style: titleStyle.copyWith(fontSize: 14.sp),
                  ),
                  Text(
                    '${itemArticle?.description?.substring(0, 50)}...',
                    style: regularStyle.copyWith(fontSize: 12.sp),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
