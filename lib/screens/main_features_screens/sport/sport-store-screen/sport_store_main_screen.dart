import 'dart:async';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/core/foodies/food_store_notifier.dart';
import 'package:healthy_buddy_mobile_app/core/sport/sport_store_notifier.dart';
import 'package:healthy_buddy_mobile_app/routes/routes.dart';
import 'package:healthy_buddy_mobile_app/screens/main_features_screens/foodies/food-store-screen/food_store_detail_screen.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/margin_height.dart';
import 'package:healthy_buddy_mobile_app/shared/assets_directory.dart';
import 'package:healthy_buddy_mobile_app/shared/theme.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/foodies/food_receipt_notifier.dart';
import '../../../widgets/margin_width.dart';

class SportStoreMainScreen extends StatefulWidget {
  const SportStoreMainScreen({super.key});

  @override
  State<SportStoreMainScreen> createState() => _SportStoreMainScreenState();
}

class _SportStoreMainScreenState extends State<SportStoreMainScreen> {
  bool _isVisible = false;
  bool _isGridViewItemList = true;
  void showContent() {
    if (mounted) {
      setState(() {
        _isVisible = true;
      });
    }
  }

  List<bool> _selectedToogle = [true, false, false, false];

  List<String> _foodStoreCategory = [
    "General",
    "Soccer",
    "Athletic",
    "Badminton"
  ];

  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    final itemGeneral =
        Provider.of<SportStoreGeneralClass>(context, listen: false);
    itemGeneral.getSport(context: context, category: "General");
    final itemSoccer =
        Provider.of<SportStoreSoccerClass>(context, listen: false);
    itemSoccer.getSport(context: context, category: "Soccer");
    final itemAthletic =
        Provider.of<SportStoreAthleticClass>(context, listen: false);
    itemAthletic.getSport(context: context, category: "Athletic");
    final itemBadminton =
        Provider.of<SportStoreBadmintonClass>(context, listen: false);
    itemBadminton.getSport(context: context, category: "Badminton");
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
              onPressed: () {
                setState(() {
                  _isGridViewItemList = !_isGridViewItemList;
                });
              },
              icon: Icon(
                !_isGridViewItemList
                    ? Icons.grid_view_rounded
                    : Icons.list_rounded,
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
                  'Sport Store',
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
                _isGridViewItemList
                    ? _gridViewItemList(_currentIndex)
                    : _listViewItemList(_currentIndex)
                // _gridViewItemList()
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
              'assets/images/discount-offers2.jpg',
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
            physics: const BouncingScrollPhysics(),
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

  Widget _gridViewItemList(int currentIndex) {
    final itemGeneral = Provider.of<SportStoreGeneralClass>(context);
    final itemSoccer = Provider.of<SportStoreSoccerClass>(context);
    final itemAthletic = Provider.of<SportStoreAthleticClass>(context);
    final itemBadminton = Provider.of<SportStoreBadmintonClass>(context);
    int itemCount(int x) {
      if (x == 0) {
        return itemGeneral.sportStore?.length ?? 0;
      } else if (x == 1) {
        return itemSoccer.sportStore?.length ?? 0;
      } else if (x == 2) {
        return itemAthletic.sportStore?.length ?? 0;
      } else if (x == 3) {
        return itemBadminton.sportStore?.length ?? 0;
      } else {
        return 0;
      }
    }

    return GridView.builder(
      shrinkWrap: true,
      primary: false,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 43.h,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
      itemCount: itemCount(_currentIndex),
      itemBuilder: (BuildContext ctx, index) {
        return GestureDetector(
          onTap: () {},
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  _currentIndex == 0
                      ? CachedNetworkImage(
                          imageUrl: itemGeneral.sportStore?[index].gallery[0] ??
                              imgPlaceHolder,
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
                              imageUrl:
                                  itemSoccer.sportStore?[index].gallery[0] ??
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
                                  imageUrl: itemAthletic
                                          .sportStore?[index].gallery[0] ??
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
                              : CachedNetworkImage(
                                  imageUrl: itemBadminton
                                          .sportStore?[index].gallery[0] ??
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _listViewItemList(int currentIndex) {
    final itemByBuah = Provider.of<FoodStoreByBuahClass>(context);
    final itemBySayuran = Provider.of<FoodStoreBySayuranClass>(context);
    final itemByInstan = Provider.of<FoodStoreByInstanClass>(context);
    final itemByMinuman = Provider.of<FoodStoreByMinumanClass>(context);
    int itemCount(int x) {
      if (x == 0) {
        return itemByBuah.foodStoreModel?.length ?? 0;
      } else if (x == 1) {
        return itemBySayuran.foodStoreModel?.length ?? 0;
      } else if (x == 2) {
        return itemByInstan.foodStoreModel?.length ?? 0;
      } else if (x == 3) {
        return itemByMinuman.foodStoreModel?.length ?? 0;
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
                final itemBuah = itemByBuah.foodStoreModel?[index];
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return FoodStoreDetailScreen(
                      foodStoreModel: itemBuah,
                    );
                  },
                ));
              } else if (_currentIndex == 1) {
                final itemSayuran = itemBySayuran.foodStoreModel?[index];
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return FoodStoreDetailScreen(
                      foodStoreModel: itemSayuran,
                    );
                  },
                ));
              } else if (_currentIndex == 2) {
                final itemInstan = itemByInstan.foodStoreModel?[index];
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return FoodStoreDetailScreen(
                      foodStoreModel: itemInstan,
                    );
                  },
                ));
              } else if (_currentIndex == 3) {
                final itemMinuman = itemByMinuman.foodStoreModel?[index];
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return FoodStoreDetailScreen(
                      foodStoreModel: itemMinuman,
                    );
                  },
                ));
              }
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.only(right: 5),
                    width: 30.w,
                    height: 17.h,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: _currentIndex == 0
                            ? CachedNetworkImage(
                                imageUrl: itemByBuah
                                        .foodStoreModel?[index].gallery[0] ??
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
                                    imageUrl: itemBySayuran
                                            .foodStoreModel?[index]
                                            .gallery[0] ??
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
                                        imageUrl: itemByInstan
                                                .foodStoreModel?[index]
                                                .gallery[0] ??
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
                                        imageUrl: itemByMinuman
                                                .foodStoreModel?[index]
                                                .gallery[0] ??
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
                  SizedBox(
                    width: 50.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        _currentIndex == 0
                            ? Text(
                                itemByBuah.foodStoreModel?[index].name ??
                                    "Loading",
                                style: titleStyle.copyWith(
                                    fontSize: 14.sp, color: blackColor),
                              )
                            : _currentIndex == 1
                                ? Text(
                                    itemBySayuran.foodStoreModel?[index].name ??
                                        "Loading",
                                    style: titleStyle.copyWith(
                                        fontSize: 14.sp, color: blackColor),
                                  )
                                : _currentIndex == 2
                                    ? Text(
                                        itemByInstan
                                                .foodStoreModel?[index].name ??
                                            "Loading",
                                        style: titleStyle.copyWith(
                                            fontSize: 14.sp, color: blackColor),
                                      )
                                    : Text(
                                        itemByMinuman
                                                .foodStoreModel?[index].name ??
                                            "Loading",
                                        style: titleStyle.copyWith(
                                            fontSize: 14.sp, color: blackColor),
                                      ),
                        _currentIndex == 0
                            ? Text(
                                '${itemByBuah.foodStoreModel?[index].description.substring(0, 100)}..',
                                style: regularStyle.copyWith(
                                    fontSize: 10.sp, color: blackColor),
                              )
                            : _currentIndex == 1
                                ? Text(
                                    '${itemBySayuran.foodStoreModel?[index].description.substring(0, 100)}..',
                                    style: regularStyle.copyWith(
                                        fontSize: 10.sp, color: blackColor),
                                  )
                                : _currentIndex == 2
                                    ? Text(
                                        '${itemByInstan.foodStoreModel?[index].description.substring(0, 100)}..',
                                        style: regularStyle.copyWith(
                                            fontSize: 10.sp, color: blackColor),
                                      )
                                    : Text(
                                        '${itemByMinuman.foodStoreModel?[index].description.substring(0, 100)}..',
                                        style: regularStyle.copyWith(
                                            fontSize: 10.sp, color: blackColor),
                                      ),
                        MarginHeight(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                _currentIndex == 0
                                    ? Text(
                                        'Rp${itemByBuah.foodStoreModel?[index].price}',
                                        style: regularStyle.copyWith(
                                            fontSize: 12.sp,
                                            color: greyTextColor),
                                      )
                                    : _currentIndex == 1
                                        ? Text(
                                            'Rp${itemBySayuran.foodStoreModel?[index].price}',
                                            style: regularStyle.copyWith(
                                                fontSize: 12.sp,
                                                color: greyTextColor),
                                          )
                                        : _currentIndex == 2
                                            ? Text(
                                                'Rp${itemByInstan.foodStoreModel?[index].price}',
                                                style: regularStyle.copyWith(
                                                    fontSize: 12.sp,
                                                    color: greyTextColor),
                                              )
                                            : Text(
                                                'Rp${itemByMinuman.foodStoreModel?[index].price}',
                                                style: regularStyle.copyWith(
                                                    fontSize: 12.sp,
                                                    color: greyTextColor),
                                              )
                              ],
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Icon(
                                Icons.shopping_cart_outlined,
                                color: greyTextColor,
                              ),
                            ),
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
        separatorBuilder: (context, index) {
          return MarginHeight(height: 2.5.h);
        },
        itemCount: itemCount(_currentIndex));
  }
}
