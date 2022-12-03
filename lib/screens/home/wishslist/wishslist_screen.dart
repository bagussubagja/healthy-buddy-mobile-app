import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cache_manager/cache_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/core/authentication/user_notifier.dart';
import 'package:healthy_buddy_mobile_app/core/wishlist/foodies_wishlist_notifier.dart';
import 'package:healthy_buddy_mobile_app/core/wishlist/sport_wishlist_notifier.dart';
import 'package:healthy_buddy_mobile_app/routes/routes.dart';
import 'package:healthy_buddy_mobile_app/screens/main_features_screens/foodies/food-store-screen/food_store_detail_screen.dart';
import 'package:healthy_buddy_mobile_app/screens/main_features_screens/foodies/food-store-screen/food_store_main_screen.dart';
import 'package:healthy_buddy_mobile_app/screens/main_features_screens/sport/sport-store-screen/sport_store_detail_screen.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/content_empty.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/loading_widget.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/margin_height.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/margin_width.dart';
import 'package:healthy_buddy_mobile_app/shared/theme.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../shared/assets_directory.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  int _currentIndex = 0;

  bool _isLoading = false;
  List<bool> _selectedToogle = [true, false];

  List<String> _foodStoreCategory = ["Foodies Store", "Sport Store"];
  bool _isVisible = false;
  void _showContent() {
    if (mounted) {
      setState(() {
        _isVisible = !_isVisible;
      });
    }
  }

  String? idUser;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 3), _showContent);
    final user = Provider.of<UserClass>(context, listen: false);
    ReadCache.getString(key: 'cache').then((value) {
      setState(() {
        idUser = value;
        user.getUser(context: context, idUser: value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserClass>(context);
    final itemFoodies = Provider.of<FoodiesWishlistClass>(context);
    final itemSport = Provider.of<SportWishlistClass>(context);
    itemFoodies.getWishlist(context: context, idUser: idUser ?? "");
    itemSport.getWishlist(context: context, idUser: idUser ?? "");

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(
          padding: defaultPadding,
          child: ListView(
            shrinkWrap: true,
            children: [
              Text(
                'Keranjang Belanja',
                style: titleStyle.copyWith(color: greenColor),
              ),
              Text(
                'Healthy Buddy - Selalu ada untuk kamu!',
                style: regularStyle.copyWith(color: greyTextColor),
              ),
              MarginHeight(height: 3.h),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_on,
                    color: greyTextColor,
                  ),
                  SizedBox(
                    width: 75.w,
                    child: Text(
                      '${user.users?[0].address}',
                      style: regularStyle.copyWith(color: greyTextColor),
                    ),
                  ),
                ],
              ),
              MarginHeight(height: 2.5.h),
              _categoryToogleButton(),
              MarginHeight(height: 2.5.h),
              Visibility(
                visible: _isVisible,
                replacement: LoadingWidget(),
                child: _itemList(_currentIndex),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _categoryToogleButton() {
    return Center(
      child: SizedBox(
        height: 5.h,
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
                  width: 30.w,
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
              return MarginWidth(width: 20.w);
            },
            itemCount: 2),
      ),
    );
  }

  Widget _itemList(int currentIndex) {
    final itemFoodies = Provider.of<FoodiesWishlistClass>(context);
    final itemSport = Provider.of<SportWishlistClass>(context);
    int itemCount(int x) {
      if (x == 0) {
        return itemFoodies.wishlistFoodies?.length ?? 0;
      } else if (x == 1) {
        return itemSport.wishlistSport?.length ?? 0;
      } else {
        return 0;
      }
    }

    if (itemCount(_currentIndex) == 0) {
      return ContentEmptyWidget(
        content: "Tidak ada Barang yang kamu masukkan ke dalam keranjang!",
      );
    }
    return ListView.separated(
        shrinkWrap: true,
        primary: false,
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            width: double.infinity,
            height: 20.h,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 15),
                  height: 14.h,
                  width: 14.h,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: _currentIndex == 0
                          ? CachedNetworkImage(
                              imageUrl: itemFoodies.wishlistFoodies?[index]
                                      .foodStore?.gallery?[0] ??
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
                              imageUrl: itemSport.wishlistSport?[index]
                                      .sportStore?.gallery?[0] ??
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
                            )),
                ),
                MarginWidth(width: 2.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MarginHeight(height: 2.h),
                    SizedBox(
                      width: 26.h,
                      child: _currentIndex == 0
                          ? Text(
                              itemFoodies.wishlistFoodies?[index].foodStore
                                      ?.name ??
                                  "Loading",
                              style: titleStyle.copyWith(fontSize: 13.sp),
                            )
                          : Text(
                              itemSport.wishlistSport?[index].sportStore
                                      ?.productName ??
                                  "Loading",
                              style: titleStyle.copyWith(fontSize: 13.sp),
                            ),
                    ),
                    SizedBox(
                        width: 26.h,
                        child: _currentIndex == 0
                            ? Text(
                                "${itemFoodies.wishlistFoodies?[index].foodStore?.description?.substring(0, 45)}...",
                                style: regularStyle.copyWith(
                                    fontSize: 10.sp, color: greyTextColor),
                              )
                            : Text(
                                "${itemSport.wishlistSport?[index].sportStore?.description?.substring(0, 45)}...",
                                style: regularStyle.copyWith(
                                    fontSize: 10.sp, color: greyTextColor),
                              )),
                    Row(
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              if (_currentIndex == 0) {
                                final wishlistFoodies = itemFoodies
                                    .wishlistFoodies?[index].foodStore;
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return FoodStoreDetailScreen(
                                      foodStore: wishlistFoodies,
                                    );
                                  },
                                ));
                              } else if (_currentIndex == 1) {
                                final wishlistSport =
                                    itemSport.wishlistSport?[index].sportStore;
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return SportStoreDetailScreen(
                                      sportStore: wishlistSport,
                                    );
                                  },
                                ));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: greenColor),
                            child: Text(
                              'Detail Item',
                              style: regularStyle,
                            )),
                        MarginWidth(width: 10.w),
                        IconButton(
                            onPressed: () async {
                              try {
                                if (_currentIndex == 0) {
                                  await itemFoodies.deleteFoodiesWishlistData(
                                      id: itemFoodies
                                          .wishlistFoodies![index].id!,
                                      context: context);
                                } else if (_currentIndex == 1) {
                                  await itemSport.deleteSportWishlistData(
                                      id: itemSport.wishlistSport![index].id!,
                                      context: context);
                                }
                              } catch (e) {
                                debugPrint(e.toString());
                              }
                            },
                            icon: const Icon(
                              Icons.delete,
                            ))
                      ],
                    )
                  ],
                )
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return MarginHeight(height: 2.h);
        },
        itemCount: itemCount(_currentIndex));
  }
}
