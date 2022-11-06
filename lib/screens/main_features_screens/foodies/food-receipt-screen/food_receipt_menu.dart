import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:healthy_buddy_mobile_app/routes/routes.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/margin_height.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/margin_width.dart';
import 'package:healthy_buddy_mobile_app/shared/theme.dart';
import 'package:sizer/sizer.dart';

class FoodReceiptMenuScreen extends StatefulWidget {
  FoodReceiptMenuScreen({super.key});

  @override
  State<FoodReceiptMenuScreen> createState() => _FoodReceiptMenuScreenState();
}

class _FoodReceiptMenuScreenState extends State<FoodReceiptMenuScreen> {
  final List<String> _foodCategory = ["Breakfast", "Lunch", "Dinner", "Drink"];
  List<bool> _selectedToogle = [true, false, false, false];

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_horiz_rounded,
                color: blackColor,
              ))
        ],
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
          'Food Receipt',
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
    return SizedBox(
      height: 40.h,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.foodReceiptDetailScreen);
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
                      height: 200,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          'assets/images/onboardscreen.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    MarginHeight(height: 1.h),
                    Text(
                      'Lorem Ipsum Dolor Sit Amet',
                      style: titleStyle.copyWith(
                          fontSize: 12.sp, color: whiteColor),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RatingBarIndicator(
                          rating: 4,
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: whiteColor,
                          ),
                          itemCount: 5,
                          itemSize: 17.5,
                          direction: Axis.horizontal,
                        ),
                        Text(
                          '4.5',
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
          itemCount: 10),
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
                    for (int i = 0; i < _selectedToogle.length; i++) {
                      if (i == index) {
                        _selectedToogle[i] = true;
                      } else {
                        _selectedToogle[i] = false;
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
                      color: _selectedToogle[index]
                          ? greenColor.withOpacity(0.2)
                          : greyColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: _selectedToogle[index]
                              ? greenDarkerColor
                              : greyTextColor)),
                  child: Text(
                    _foodCategory[index],
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
              return MarginWidth(width: 3.w);
            },
            itemCount: 4),
      ),
    );
  }

  Widget _listFoodByCategory(int currentIndex) {
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(12)),
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
                      Text(
                        currentIndex == 0 ? "Omelette" : "Seblak",
                        style: titleStyle.copyWith(
                            fontSize: 16.sp, color: blackColor),
                      ),
                      Text(
                        'Omelette (also spelled omelet) is a dish made from beaten eggs, fried with butter or oil in a frying pan (without stirring as in scrambled egg).',
                        style: regularStyle.copyWith(
                            fontSize: 10.sp, color: blackColor),
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
                              Text(
                                '10 Min',
                                style: regularStyle.copyWith(
                                    fontSize: 12, color: greyTextColor),
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
                              Text(
                                'Easy',
                                style: regularStyle.copyWith(
                                    fontSize: 12, color: greyTextColor),
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
                    child: Image.asset(
                      'assets/images/onboardscreen.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return MarginHeight(height: 2.5.h);
        },
        itemCount: 10);
  }
}
