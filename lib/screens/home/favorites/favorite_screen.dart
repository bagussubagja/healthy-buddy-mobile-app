// ignore_for_file: prefer_final_fields, use_build_context_synchronously

import 'package:cache_manager/cache_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthy_buddy_mobile_app/core/favorites/favorites_notifier.dart';
import 'package:healthy_buddy_mobile_app/screens/main_features_screens/foodies/food-recipe-screen/food_recipe_detail_screen.dart';
import 'package:healthy_buddy_mobile_app/screens/main_features_screens/mydoc/detail_screen/mydoc_detail_screen.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/margin_height.dart';
import 'package:healthy_buddy_mobile_app/shared/theme.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/margin_width.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  int _currentIndex = 0;
  String? idUser;
  List<bool> _selectedToogle = [true, false];
  final List<String> _categoryLabel = [
    "Foodies",
    "MyDoc",
  ];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final item = Provider.of<FavoriteClass>(context, listen: false);
    ReadCache.getString(key: 'cache').then((value) {
      setState(() {
        idUser = value;
        item.getFavFood(context: context, idUser: value);
        item.getFavMyDoc(context: context, idUser: value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final item = Provider.of<FavoriteClass>(context);
    item.getFavFood(context: context, idUser: idUser ?? "");
    item.getFavMyDoc(context: context, idUser: idUser ?? "");
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(
          padding: defaultPadding,
          child: ListView(
            children: [
              _headerSection(),
              _toogleButton(),
              MarginHeight(height: 2.h),
              _itemList()
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
          'Favorite',
          style: titleStyle.copyWith(color: greenColor),
        ),
        Text(
          'Healthy Buddy - Item kesukaanmu ada disini!',
          style: regularStyle.copyWith(color: greyTextColor),
        ),
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 50.h,
          child: SvgPicture.asset('assets/svg/favorite.svg'),
        ),
      ],
    );
  }

  Widget _toogleButton() {
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
                    _categoryLabel[index],
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
              return MarginWidth(width: 6.w);
            },
            itemCount: _categoryLabel.length),
      ),
    );
  }

  Widget _itemList() {
    final item = Provider.of<FavoriteClass>(context);
    int itemCount(int x) {
      if (x == 0) {
        return item.food?.length ?? 0;
      } else if (x == 1) {
        return item.doc?.length ?? 0;
      } else {
        return 0;
      }
    }

    if (itemCount(_currentIndex) == 0) {
      return Text(
        'Tidak ada item Favorite yang kamu simpan disini!',
        style: regularStyle.copyWith(color: greyTextColor),
        textAlign: TextAlign.center,
      );
    }
    return ListView.separated(
      separatorBuilder: (context, index) {
        return MarginHeight(height: 2.h);
      },
      shrinkWrap: true,
      primary: false,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount(_currentIndex),
      itemBuilder: (context, index) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 13.h,
                width: 13.h,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: _currentIndex == 0
                        ? '${item.food?[index].foodReceipt?.galleryPhoto?[0]}'
                        : '${item.doc?[index].myDoc?.thumbnail}',
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
              ),
              SizedBox(
                width: 60.w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 55.w,
                      child: Text(
                        _currentIndex == 0
                            ? '${item.food?[index].foodReceipt?.name}'
                            : '${item.doc?[index].myDoc?.name}',
                        style: titleStyle.copyWith(fontSize: 12.sp),
                      ),
                    ),
                    SizedBox(
                      width: 55.w,
                      child: Text(
                        _currentIndex == 0
                            ? '${item.food?[index].foodReceipt?.description?.substring(0, 60)}...'
                            : '${item.doc?[index].myDoc?.description?.substring(0, 60)}...',
                        style: regularStyle.copyWith(
                            color: greyTextColor, fontSize: 10.sp),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Konfirmasi'),
                                  content: const Text(
                                      'Apakah kamu yakin untuk menghapus item ini pada bagian favorite?'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () async {
                                        try {
                                          if (_currentIndex == 0) {
                                            await item.deleteFavFoodData(
                                                id: item.food![index].id!,
                                                context: context);
                                          } else if (_currentIndex == 1) {
                                            await item.deleteFavMyDocData(
                                                id: item.doc![index].id!,
                                                context: context);
                                          }
                                        } catch (e) {
                                          debugPrint(e.toString());
                                        }
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Ya'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Tidak'),
                                    ),
                                  ],
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.delete,
                            )),
                        MarginWidth(width: 4.h),
                        GestureDetector(
                          onTap: () async {
                            if (_currentIndex == 0) {
                              final food = item.food?[index].foodReceipt;
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return FoodReceiptDetailScreen(
                                    foodReceipt: food,
                                  );
                                },
                              ));
                            } else if (_currentIndex == 1) {
                              final myDoc = item.doc?[index].myDoc;
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return MyDocDetailScreen(
                                    myDoc: myDoc,
                                  );
                                },
                              ));
                            }
                          },
                          child: Icon(
                            Icons.arrow_forward_outlined,
                            color: blackColor,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
