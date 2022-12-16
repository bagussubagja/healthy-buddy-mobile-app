// ignore_for_file: prefer_final_fields, prefer_const_constructors

import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/core/foodies/food_articles_notifier.dart';
import 'package:healthy_buddy_mobile_app/core/sport/sport_exercise_notifier.dart';
import 'package:healthy_buddy_mobile_app/routes/routes.dart';
import 'package:healthy_buddy_mobile_app/screens/main_features_screens/sport/sport-store-screen/sport_store_main_screen.dart';
import 'package:healthy_buddy_mobile_app/screens/main_features_screens/sport/sport_exercise_screen/sport_exercise_screen.dart';

import 'package:healthy_buddy_mobile_app/screens/widgets/margin_height.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/margin_width.dart';
import 'package:healthy_buddy_mobile_app/shared/theme.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/extras/carousel_item_notifier.dart';
import '../../../shared/assets_directory.dart';
import '../../widgets/loading_widget.dart';

class SportScreen extends StatefulWidget {
  const SportScreen({super.key});

  @override
  State<SportScreen> createState() => _SportScreenState();
}

class _SportScreenState extends State<SportScreen> {
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
    "sport-article.png",
    "sport-pedia.png",
    "sport-store.png",
    "sport-exercise.png"
  ];
  final List<String> _iconLabel = [
    "Sport Article",
    "Sport Website",
    "Sport Store",
    "Sport Exercise"
  ];
  final List<String> _exerciseLevel = ["Easy", "Medium", "Hard"];
  List<bool> _selectedToogle = [true, false, false];

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    final itemCarousel = Provider.of<CarouselClass>(context, listen: false);
    itemCarousel.getDataCarousel(context: context, section: "sport");
    final item = Provider.of<FoodArticlesClass>(context, listen: false);
    item.getFoodArticleData(context: context);
    final easyExercise =
        Provider.of<SportExerciseEasyClass>(context, listen: false);
    easyExercise.getSport(context: context, category: 'Easy');
    final mediumExercise =
        Provider.of<SportExerciseMediumClass>(context, listen: false);
    mediumExercise.getSport(context: context, category: 'Medium');
    final hardExercise =
        Provider.of<SportExerciseHardClass>(context, listen: false);
    hardExercise.getSport(context: context, category: 'Hard');
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
                    MarginHeight(height: 2.h),
                    _carouselSection(),
                    MarginHeight(height: 2.h),
                    _sportCategory(),
                    MarginHeight(height: 2.h),
                    _sportLevelToogleButton(_currentIndex),
                    MarginHeight(height: 2.h),
                    _exerciseSection(_currentIndex)
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
          'Tetap Sehat Bersama Kami!',
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
                  onTap: () {
                    if (index == 0) {
                      Navigator.pushNamed(context, AppRoutes.sportArticle);
                    } else if (index == 1) {
                      Navigator.pushNamed(context, AppRoutes.sportWebsite);
                    } else if (index == 2) {
                      // Navigator.pushNamed(context, AppRoutes.sportStore);
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return SportStoreMainScreen();
                        },
                      ));
                    } else if (index == 3) {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return SportExerciseScreen();
                        },
                      ));
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

  Widget _sportLevelToogleButton(int currentIndex) {
    return Center(
      child: SizedBox(
        height: 30,
        child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    for (int i = 0; i < _selectedToogle.length; i++) {
                      if (i == index) {
                        _selectedToogle[i] = true;
                      } else {
                        _selectedToogle[i] = false;
                      }
                    }
                  });
                  _currentIndex = index;
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(2),
                  height: 30,
                  width: 80,
                  decoration: BoxDecoration(
                      color: _selectedToogle[index]
                          ? greenColor.withOpacity(0.2)
                          : greyColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: _selectedToogle[index]
                              ? greenDarkerColor
                              : greyTextColor)),
                  child: Text(
                    _exerciseLevel[index],
                    style: regularStyle.copyWith(
                        color: _selectedToogle[index]
                            ? greenDarkerColor
                            : greyTextColor,
                        fontSize: 14),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return MarginWidth(width: 10.w);
            },
            itemCount: 3),
      ),
    );
  }

  Widget _exerciseSection(int currentIndex) {
    final easyItem = Provider.of<SportExerciseEasyClass>(context);
    final mediumItem = Provider.of<SportExerciseMediumClass>(context);
    final hardItem = Provider.of<SportExerciseHardClass>(context);
    int itemCount(int x) {
      if (x == 0) {
        return easyItem.sportExercise?.length ?? 0;
      } else if (x == 1) {
        return mediumItem.sportExercise?.length ?? 0;
      } else if (x == 2) {
        return hardItem.sportExercise?.length ?? 0;
      } else {
        return 0;
      }
    }

    return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 3,
                  blurRadius: 10,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20.h,
                  width: 30.w,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: _currentIndex == 0
                        ? CachedNetworkImage(
                            imageUrl:
                                easyItem.sportExercise?[index].thumbnail ??
                                    _placeHolder,
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
                          )
                        : _currentIndex == 1
                            ? CachedNetworkImage(
                                imageUrl: mediumItem
                                        .sportExercise?[index].thumbnail ??
                                    _placeHolder,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
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
                                errorWidget: (context, url, error) =>
                                    const Center(
                                  child: Icon(Icons.error),
                                ),
                              )
                            : CachedNetworkImage(
                                imageUrl:
                                    hardItem.sportExercise?[index].thumbnail ??
                                        _placeHolder,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
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
                                errorWidget: (context, url, error) =>
                                    const Center(
                                  child: Icon(Icons.error),
                                ),
                              ),
                  ),
                ),
                MarginWidth(width: 4.w),
                SizedBox(
                    width: 50.w,
                    child: _currentIndex == 0
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${easyItem.sportExercise?[index].name}',
                                style: titleStyle.copyWith(
                                    color: blackColor, fontSize: 14.sp),
                              ),
                              Text(
                                '${easyItem.sportExercise?[index].description.substring(0, 80)}...',
                                style: regularStyle.copyWith(
                                    fontSize: 10.sp, color: greyTextColor),
                              ),
                              Container(
                                alignment: Alignment.bottomRight,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: greenColor,
                                      elevation: 0),
                                  onPressed: () async {
                                    final url = Uri.parse(easyItem
                                        .sportExercise![index].linkVideo);
                                    if (await canLaunchUrl(url)) {
                                      await launchUrl(url);
                                    }
                                  },
                                  child: Text(
                                    'Coba Sekarang!',
                                    style: regularStyle,
                                  ),
                                ),
                              )
                            ],
                          )
                        : _currentIndex == 1
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    mediumItem.sportExercise?[index].name ??
                                        "Loading",
                                    style: titleStyle.copyWith(
                                        color: blackColor, fontSize: 14.sp),
                                  ),
                                  Text(
                                    '${mediumItem.sportExercise?[index].description.substring(0, 80)}...',
                                    style: regularStyle.copyWith(
                                        fontSize: 10.sp, color: greyTextColor),
                                  ),
                                  Container(
                                    alignment: Alignment.bottomRight,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: greenColor,
                                          elevation: 0),
                                      onPressed: () async {
                                        final url = Uri.parse(mediumItem
                                            .sportExercise![index].linkVideo);
                                        if (await canLaunchUrl(url)) {
                                          await launchUrl(url);
                                        }
                                      },
                                      child: Text(
                                        'Coba Sekarang!',
                                        style: regularStyle,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${hardItem.sportExercise?[index].name}...',
                                    style: titleStyle.copyWith(
                                        color: blackColor, fontSize: 14.sp),
                                  ),
                                  Text(
                                    '${hardItem.sportExercise?[index].description.substring(0, 80)}...',
                                    style: regularStyle.copyWith(
                                        fontSize: 10.sp, color: greyTextColor),
                                  ),
                                  Container(
                                    alignment: Alignment.bottomRight,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: greenColor,
                                          elevation: 0),
                                      onPressed: () async {
                                        final url = Uri.parse(hardItem
                                            .sportExercise![index].linkVideo);
                                        if (await canLaunchUrl(url)) {
                                          await launchUrl(url);
                                        }
                                      },
                                      child: Text(
                                        'Coba Sekarang!',
                                        style: regularStyle,
                                      ),
                                    ),
                                  )
                                ],
                              ))
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return MarginHeight(height: 20);
        },
        itemCount: itemCount(_currentIndex));
  }
}
