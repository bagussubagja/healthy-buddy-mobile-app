import 'dart:async';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/routes/routes.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/margin_height.dart';
import 'package:healthy_buddy_mobile_app/shared/theme.dart';
import 'package:sizer/sizer.dart';

import '../../../widgets/margin_width.dart';

class FoodStoreMainScreen extends StatefulWidget {
  const FoodStoreMainScreen({super.key});

  @override
  State<FoodStoreMainScreen> createState() => _FoodStoreMainScreenState();
}

class _FoodStoreMainScreenState extends State<FoodStoreMainScreen> {
  bool _isVisible = false;
  void showContent() {
    setState(() {
      _isVisible = true;
    });
  }

  List<bool> _selectedToogle = [true, false, false, false];

  List<String> _foodStoreCategory = ["Buah", "Sayuran", "Instan", "Minuman"];

  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), showContent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Badge(
        badgeContent: Text(
          _currentIndex.toString(),
          style: regularStyle.copyWith(color: whiteColor),
        ),
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: greenColor,
          child: Icon(
            Icons.shopping_cart_outlined,
            color: whiteColor,
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
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
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(
          padding: defaultPadding,
          child: Visibility(
            visible: _isVisible,
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),
            child: ListView(
              children: [
                Text(
                  'Food Store',
                  style: titleStyle.copyWith(color: greenColor),
                ),
                Text(
                  'Dapatkan makanan sehatmu dimana saja!',
                  style: regularStyle.copyWith(
                    color: greyTextColor,
                  ),
                ),
                MarginHeight(
                  height: 2.h,
                ),
                Visibility(
                  visible: _isVisible,
                  replacement: const Center(child: CircularProgressIndicator()),
                  child: _discountSection(context),
                ),
                MarginHeight(
                  height: 2.h,
                ),
                _foodStoreToogleButton(),
                MarginHeight(height: 2.h),
                Visibility(
                  visible: _isVisible,
                  replacement: const Center(child: CircularProgressIndicator()),
                  child: _itemList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _discountSection(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 30.h,
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'assets/images/discount-offers.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: 30.h,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              colors: [
                Colors.grey.withOpacity(0.2),
                Colors.black.withOpacity(0.7),
              ],
              stops: const [0.0, 1.0],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 50.w,
                  child: Text(
                    'Dapatkan potongan harga 15% dari item yang kamu beli!',
                    style: titleStyle.copyWith(color: whiteColor),
                  ),
                ),
                OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: whiteColor,
                      elevation: 0,
                    ),
                    onPressed: () {
                      final snackBar = SnackBar(
                        elevation: 0,
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        content: AwesomeSnackbarContent(
                          title: 'Selamat!',
                          message:
                              'Kamu telah mendapatkan potongan harga 15% dari setiap item yang akan kamu beli!',
                          contentType: ContentType.success,
                        ),
                      );
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(snackBar);
                    },
                    child: Text(
                      'Dapatkan!',
                      style: regularStyle.copyWith(color: greenColor),
                    ))
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _foodStoreToogleButton() {
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
                    _foodStoreCategory[index],
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

  Widget _itemList() {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 40.h,
            childAspectRatio: 3 / 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        shrinkWrap: true,
        primary: false,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.foodStoreDetailScreen);
            },
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              height: 100,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/images/discount-offers.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  MarginHeight(height: 0.5.h),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Blueberry',
                          style: regularStyle.copyWith(color: blackColor),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$ 10',
                              style: regularStyle,
                            ),
                            Icon(
                              Icons.shopping_cart_outlined,
                              color: blackColor,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: 6);
  }
}
