import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/core/foodies/food_articles_notifier.dart';
import 'package:healthy_buddy_mobile_app/routes/routes.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/loading_widget.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/margin_height.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/margin_width.dart';
import 'package:healthy_buddy_mobile_app/shared/theme.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/extras/carousel_item_notifier.dart';
import '../../../shared/assets_directory.dart';

class FoodiesScreen extends StatefulWidget {
  const FoodiesScreen({super.key});

  @override
  State<FoodiesScreen> createState() => _FoodiesScreenState();
}

class _FoodiesScreenState extends State<FoodiesScreen> {
  bool _isLoading = true;
  void showContent() {
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  final String _placeHolder =
      'https://i.ytimg.com/vi/uBBDMqZKagY/sddefault.jpg';

  final List<String> _iconImage = [
    "food-article.png",
    "food-pedia.png",
    "food-receipt.png",
    "food-store.png"
  ];
  final List<String> _iconLabel = [
    "Food Article",
    "Food Calculator",
    "Food Receipt",
    "Food Store"
  ];

  @override
  void initState() {
    super.initState();
    final itemCarousel = Provider.of<CarouselClass>(context, listen: false);
    itemCarousel.getDataCarousel(context: context, section: "foodies");
    final item = Provider.of<FoodArticlesClass>(context, listen: false);
    item.getFoodArticleData(context: context);
    Timer(const Duration(seconds: 2), showContent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: blackColor,
          ),
        ),
      ),
      body: SafeArea(
        child: _isLoading
            ? LoadingWidget(
                color: greenColor,
              )
            : Padding(
                padding: defaultPadding,
                child: ListView(
                  children: [
                    _headerSection(),
                    MarginHeight(height: 1.h),
                    _carouselSection(),
                    MarginHeight(height: 3.h),
                    _foodiesCategory(context),
                    MarginHeight(height: 2.h),
                    Visibility(
                      visible: true,
                      replacement: LoadingWidget(),
                      child: _articleOfTheDay(),
                    )
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
          'Foodies',
          style: titleStyle.copyWith(color: greenColor),
        ),
        MarginHeight(height: 0.5.h),
        Text(
          'Disini tempat mencari makanan sehat!',
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
                  child: CachedNetworkImage(
                    imageUrl: item?.thumbnail[index] ?? _placeHolder,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => const Center(
                      child: Icon(Icons.error),
                    ),
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
                          onTap: () async {
                            final url = Uri.parse(itemCarousel
                                .carousel![0].link[index]
                                .toString());
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url);
                            }
                          },
                          child: Text(
                            "Baca Selengkapnya",
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

  Widget _foodiesCategory(BuildContext context) {
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
                  onTap: () async {
                    if (index == 0) {
                      Navigator.pushNamed(context, AppRoutes.foodArticleMenu);
                    } else if (index == 1) {
                       Navigator.pushNamed(context, AppRoutes.foodCalculatorScreen);
                    } else if (index == 2) {
                      Navigator.pushNamed(context, AppRoutes.foodReceiptMenu);
                    } else if (index == 3) {
                      Navigator.pushNamed(context, AppRoutes.foodStoreMenu);
                    }
                  },
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

  Widget _articleOfTheDay() {
    final item = Provider.of<FoodArticlesClass>(context);
    return Column(
      children: [
        MarginHeight(height: 2.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Article of the Day",
              style: titleStyle.copyWith(color: blackColor),
            ),
          ],
        ),
        MarginHeight(height: 1.25.h),
        item.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                shrinkWrap: true,
                primary: false,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 2,
                itemBuilder: (context, index) {
                  final itemArticle = item.foodArticle?[index];
                  return GestureDetector(
                    onTap: () async {
                      final url = Uri.parse(item.foodArticle![index].link!);
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      padding: defaultPadding,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: CachedNetworkImage(
                              imageUrl: itemArticle?.thumbnail ?? _placeHolder,
                            ),
                          ),
                          MarginHeight(height: 1.h),
                          Text(
                            itemArticle?.title ?? 'Loading...',
                            style: titleStyle.copyWith(
                                fontSize: 14.sp, color: blackColor),
                          ),
                          Text(
                            '${itemArticle?.description?.substring(0, 50)}...',
                            style: regularStyle.copyWith(
                                fontSize: 12.sp, color: greyTextColor),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ],
    );
  }
}
