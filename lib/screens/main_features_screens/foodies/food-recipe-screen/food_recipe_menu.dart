import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:healthy_buddy_mobile_app/core/foodies/food_receipt_notifier.dart';
import 'package:healthy_buddy_mobile_app/screens/main_features_screens/foodies/food-recipe-screen/food_recipe_detail_screen.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/margin_height.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/margin_width.dart';
import 'package:healthy_buddy_mobile_app/shared/assets_directory.dart';
import 'package:healthy_buddy_mobile_app/shared/theme.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class FoodReceiptMenuScreen extends StatefulWidget {
  const FoodReceiptMenuScreen({super.key});

  @override
  State<FoodReceiptMenuScreen> createState() => _FoodReceiptMenuScreenState();
}

class _FoodReceiptMenuScreenState extends State<FoodReceiptMenuScreen> {
  final List<String> _foodCategory = ["Breakfast", "Lunch", "Dinner", "Drink"];
  List<bool> selectedToogle = [true, false, false, false];

  @override
  void initState() {
    super.initState();
    final item = Provider.of<FoodReceiptClass>(context, listen: false);
    item.getFoodReceipt(context: context);
    final itemBreakfast =
        Provider.of<FoodReceiptByBreakfast>(context, listen: false);
    itemBreakfast.getFoodReceiptCategory(
        context: context, category: 'Breakfast');
    final itemByLunch = Provider.of<FoodReceiptByLunch>(context, listen: false);
    itemByLunch.getFoodReceiptCategory(context: context, category: 'Lunch');
    final itemByDinner =
        Provider.of<FoodReceiptByDinner>(context, listen: false);
    itemByDinner.getFoodReceiptCategory(context: context, category: 'Dinner');
    final itemByDrink = Provider.of<FoodReceiptByDrink>(context, listen: false);
    itemByDrink.getFoodReceiptCategory(context: context, category: 'Drink');
  }

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: blackColor,
            )),
      ),
      body: SafeArea(
          child: Padding(
        padding: defaultPadding,
        child: ListView(
          children: [
            _headerSection(),
            MarginHeight(height: 1.h),
            _recommendedFoodCard(),
            MarginHeight(height: 3.h),
            _foodToogleButton(),
            MarginHeight(height: 3.h),
            _listFoodByCategory(_currentIndex)
          ],
        ),
      )),
    );
  }

  Widget _headerSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Food Recipe',
          style: titleStyle.copyWith(color: greenColor),
        ),
        MarginHeight(height: 0.75.h),
        Text(
          'Apa yang akan kamu masak hari ini?',
          style: regularStyle.copyWith(color: greyTextColor),
        ),
        MarginHeight(height: 15),
        Text(
          'Rekomendasi',
          style: titleStyle.copyWith(color: greenColor),
        ),
      ],
    );
  }

  Widget _recommendedFoodCard() {
    final item = Provider.of<FoodReceiptClass>(context);
    return SizedBox(
      height: 37.h,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final food = item.receiptModels?[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return FoodReceiptDetailScreen(
                      foodReceiptModel: food,
                    );
                  },
                ));
              },
              child: Container(
                width: 55.w,
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                decoration: BoxDecoration(
                  color: greenColor.withOpacity(0.75),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 25.h,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          item.receiptModels?[index].galleryPhoto[0] ??
                              imgPlaceHolder,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    MarginHeight(height: 1.h),
                    Text(
                      item.receiptModels?[index].name ?? "Loading",
                      style: titleStyle.copyWith(
                          fontSize: 12.sp, color: whiteColor),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RatingBarIndicator(
                          rating: item.receiptModels?[index].rating ?? 0,
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: whiteColor,
                          ),
                          itemCount: 5,
                          itemSize: 17.5,
                          direction: Axis.horizontal,
                        ),
                        Text(
                          item.receiptModels?[index].rating.toString() ?? '0',
                          style: regularStyle.copyWith(color: whiteColor),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return MarginWidth(
              width: 3.w,
            );
          },
          itemCount: 5),
    );
  }

  Widget _foodToogleButton() {
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
                    for (int i = 0; i < selectedToogle.length; i++) {
                      if (i == index) {
                        selectedToogle[i] = true;
                      } else {
                        selectedToogle[i] = false;
                      }
                    }
                    _currentIndex = index;
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(2),
                  height: 30,
                  width: 80,
                  decoration: BoxDecoration(
                      color: selectedToogle[index]
                          ? greenColor.withOpacity(0.2)
                          : greyColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: selectedToogle[index]
                              ? greenDarkerColor
                              : greyTextColor)),
                  child: Text(
                    _foodCategory[index],
                    style: regularStyle.copyWith(
                        color: selectedToogle[index]
                            ? greenDarkerColor
                            : greyTextColor,
                        fontSize: 14),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return MarginWidth(width: 3.w);
            },
            itemCount: 4),
      ),
    );
  }

  Widget _listFoodByCategory(int currentIndex) {
    final itemByBreakfast = Provider.of<FoodReceiptByBreakfast>(context);
    final itemByLunch = Provider.of<FoodReceiptByLunch>(context);
    final itemByDinner = Provider.of<FoodReceiptByDinner>(context);
    final itemByDrink = Provider.of<FoodReceiptByDrink>(context);
    int itemCount(int x) {
      if (x == 0) {
        return itemByBreakfast.receiptModelCategory?.length ?? 0;
      } else if (x == 1) {
        return itemByLunch.receiptModelCategory?.length ?? 0;
      } else if (x == 2) {
        return itemByDinner.receiptModelCategory?.length ?? 0;
      } else if (x == 3) {
        return itemByDrink.receiptModelCategory?.length ?? 0;
      } else {
        return 0;
      }
    }

    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              if (_currentIndex == 0) {
                final itemBreakfastStored =
                    itemByBreakfast.receiptModelCategory?[index];
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return FoodReceiptDetailScreen(
                      foodReceiptModel: itemBreakfastStored,
                    );
                  },
                ));
              } else if (_currentIndex == 1) {
                final itemLunchStored =
                    itemByLunch.receiptModelCategory?[index];
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return FoodReceiptDetailScreen(
                      foodReceiptModel: itemLunchStored,
                    );
                  },
                ));
              } else if (_currentIndex == 2) {
                final itemDinnerStored =
                    itemByDinner.receiptModelCategory?[index];
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return FoodReceiptDetailScreen(
                      foodReceiptModel: itemDinnerStored,
                    );
                  },
                ));
              } else if (_currentIndex == 3) {
                final itemDrinkStored =
                    itemByDrink.receiptModelCategory?[index];
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return FoodReceiptDetailScreen(
                      foodReceiptModel: itemDrinkStored,
                    );
                  },
                ));
              }
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 50.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        _currentIndex == 0
                            ? Text(
                                itemByBreakfast
                                        .receiptModelCategory?[index].name ??
                                    "Loading",
                                style: titleStyle.copyWith(
                                    fontSize: 16.sp, color: blackColor),
                              )
                            : _currentIndex == 1
                                ? Text(
                                    itemByLunch.receiptModelCategory?[index]
                                            .name ??
                                        "Loading",
                                    style: titleStyle.copyWith(
                                        fontSize: 16.sp, color: blackColor),
                                  )
                                : _currentIndex == 2
                                    ? Text(
                                        itemByDinner
                                                .receiptModelCategory?[index]
                                                .name ??
                                            "Loading",
                                        style: titleStyle.copyWith(
                                            fontSize: 16.sp, color: blackColor),
                                      )
                                    : Text(
                                        itemByDrink.receiptModelCategory?[index]
                                                .name ??
                                            "Loading",
                                        style: titleStyle.copyWith(
                                            fontSize: 16.sp, color: blackColor),
                                      ),
                        _currentIndex == 0
                            ? Text(
                                '${itemByBreakfast.receiptModelCategory?[index].description.substring(0, 100)}..',
                                style: regularStyle.copyWith(
                                    fontSize: 10.sp, color: greyTextColor),
                              )
                            : _currentIndex == 1
                                ? Text(
                                    '${itemByLunch.receiptModelCategory?[index].description.substring(0, 100)}..',
                                    style: regularStyle.copyWith(
                                        fontSize: 10.sp, color: greyTextColor),
                                  )
                                : _currentIndex == 2
                                    ? Text(
                                        '${itemByDinner.receiptModelCategory?[index].description.substring(0, 100)}..',
                                        style: regularStyle.copyWith(
                                            fontSize: 10.sp,
                                            color: greyTextColor),
                                      )
                                    : Text(
                                        '${itemByDrink.receiptModelCategory?[index].description.substring(0, 100)}..',
                                        style: regularStyle.copyWith(
                                            fontSize: 10.sp,
                                            color: greyTextColor),
                                      ),
                        MarginHeight(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.access_time_rounded,
                                  color: greyTextColor,
                                ),
                                MarginWidth(width: 5),
                                _currentIndex == 0
                                    ? Text(
                                        '${itemByBreakfast.receiptModelCategory?[index].duration} Min',
                                        style: regularStyle.copyWith(
                                            fontSize: 12, color: greyTextColor),
                                      )
                                    : _currentIndex == 1
                                        ? Text(
                                            '${itemByLunch.receiptModelCategory?[index].duration} Min',
                                            style: regularStyle.copyWith(
                                                fontSize: 12,
                                                color: greyTextColor),
                                          )
                                        : _currentIndex == 2
                                            ? Text(
                                                '${itemByDinner.receiptModelCategory?[index].duration} Min',
                                                style: regularStyle.copyWith(
                                                    fontSize: 12,
                                                    color: greyTextColor),
                                              )
                                            : Text(
                                                '${itemByDrink.receiptModelCategory?[index].duration} Min',
                                                style: regularStyle.copyWith(
                                                    fontSize: 12,
                                                    color: greyTextColor),
                                              )
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.sentiment_satisfied_rounded,
                                  color: greyTextColor,
                                ),
                                MarginWidth(width: 5),
                                _currentIndex == 0
                                    ? Text(
                                        itemByBreakfast
                                                .receiptModelCategory?[index]
                                                .levelOfMaking ??
                                            "Loading",
                                        style: regularStyle.copyWith(
                                            fontSize: 12, color: greyTextColor),
                                      )
                                    : _currentIndex == 1
                                        ? Text(
                                            itemByLunch
                                                    .receiptModelCategory?[
                                                        index]
                                                    .levelOfMaking ??
                                                "Loading",
                                            style: regularStyle.copyWith(
                                                fontSize: 12,
                                                color: greyTextColor),
                                          )
                                        : _currentIndex == 2
                                            ? Text(
                                                itemByDinner
                                                        .receiptModelCategory?[
                                                            index]
                                                        .levelOfMaking ??
                                                    "Loading",
                                                style: regularStyle.copyWith(
                                                    fontSize: 12,
                                                    color: greyTextColor),
                                              )
                                            : Text(
                                                itemByDrink
                                                        .receiptModelCategory?[
                                                            index]
                                                        .levelOfMaking ??
                                                    "Loading",
                                                style: regularStyle.copyWith(
                                                    fontSize: 12,
                                                    color: greyTextColor),
                                              )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 5),
                    width: 30.w,
                    height: 17.h,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: _currentIndex == 0
                            ? CachedNetworkImage(
                                imageUrl: itemByBreakfast
                                        .receiptModelCategory?[index]
                                        .galleryPhoto[0] ??
                                    imgPlaceHolder,
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
                            : _currentIndex == 1
                                ? CachedNetworkImage(
                                    imageUrl: itemByLunch
                                            .receiptModelCategory?[index]
                                            .galleryPhoto[0] ??
                                        imgPlaceHolder,
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
                                : _currentIndex == 2
                                    ? CachedNetworkImage(
                                        imageUrl: itemByDinner
                                                .receiptModelCategory?[index]
                                                .galleryPhoto[0] ??
                                            imgPlaceHolder,
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        placeholder: (context, url) =>
                                            const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Center(
                                          child: Icon(Icons.error),
                                        ),
                                      )
                                    : CachedNetworkImage(
                                        imageUrl: itemByDrink
                                                .receiptModelCategory?[index]
                                                .galleryPhoto[0] ??
                                            imgPlaceHolder,
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        placeholder: (context, url) =>
                                            const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Center(
                                          child: Icon(Icons.error),
                                        ),
                                      )),
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return MarginHeight(height: 2.5.h);
        },
        itemCount: itemCount(_currentIndex));
  }
}
