// ignore_for_file: must_be_immutable

import 'package:cache_manager/cache_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:healthy_buddy_mobile_app/core/authentication/user_notifier.dart';
import 'package:healthy_buddy_mobile_app/core/favorites/favorites_notifier.dart';
import 'package:healthy_buddy_mobile_app/models/favorite_model/fav_food_receipt_model.dart';
import 'package:healthy_buddy_mobile_app/models/foodies_model/food_receipt_model.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/margin_height.dart';
import 'package:healthy_buddy_mobile_app/shared/assets_directory.dart';
import 'package:healthy_buddy_mobile_app/shared/theme.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../widgets/margin_width.dart';

class FoodReceiptDetailScreen extends StatefulWidget {
  FoodReceiptModel? foodReceiptModel;
  FoodReceipt? foodReceipt;
  FoodReceiptDetailScreen({super.key, this.foodReceiptModel, this.foodReceipt});

  @override
  State<FoodReceiptDetailScreen> createState() =>
      _FoodReceiptDetailScreenState();
}

class _FoodReceiptDetailScreenState extends State<FoodReceiptDetailScreen> {
  late YoutubePlayerController controller;

  String? idUser;

  @override
  void initState() {
    super.initState();
    final user = Provider.of<UserClass>(context, listen: false);
    ReadCache.getString(key: 'cache').then((value) {
      setState(() {
        user.getUser(context: context, idUser: value);
        idUser = value;
      });
    });
    String url = widget.foodReceiptModel?.linkVideo ??
        widget.foodReceipt?.linkVideo ??
        vidPlaceHolder;
    controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(url)!,
        flags: const YoutubePlayerFlags(
          mute: false,
          loop: false,
          autoPlay: false,
        ));
  }

  @override
  void deactivate() {
    controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: controller,
        ),
        builder: (context, player) {
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
                  Icons.arrow_back_ios_new_rounded,
                  color: blackColor,
                ),
              ),
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    _youtubePlayer(player),
                    MarginHeight(height: 0.5.h),
                    _videoTitle(),
                    _ratingSection(),
                    MarginHeight(height: 1.h),
                    _estimationFoodLevel(),
                    MarginHeight(height: 2.h),
                    _foodServiceStyle(),
                    MarginHeight(height: 1.h),
                    _ingredientSection(),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget _youtubePlayer(Widget player) {
    return SizedBox(
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: player,
      ),
    );
  }

  Widget _videoTitle() {
    final fav = Provider.of<FavoriteClass>(context, listen: false);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 75.w,
          child: Text(
            widget.foodReceiptModel?.name ?? widget.foodReceipt!.name!,
            style: titleStyle.copyWith(color: blackColor),
          ),
        ),
        IconButton(
            onPressed: () async {
              FavFoodReceiptModel body = FavFoodReceiptModel(
                  idReceipt:
                      widget.foodReceiptModel?.id ?? widget.foodReceipt!.id!,
                  uniqueKey:
                      '${idUser}_${widget.foodReceiptModel?.id ?? widget.foodReceipt?.id}',
                  idUser: idUser);

              await fav.addFavFoodData(body, context);
            },
            icon: Icon(
              Icons.favorite_rounded,
              color: greyTextColor,
            ))
      ],
    );
  }

  Widget _ratingSection() {
    return RatingBarIndicator(
      rating: widget.foodReceiptModel?.rating ??
          widget.foodReceipt!.rating!.toDouble(),
      itemBuilder: (context, index) => Icon(
        Icons.star,
        color: greenColor,
      ),
      itemCount: 5,
      itemSize: 17.5,
      direction: Axis.horizontal,
    );
  }

  Widget _estimationFoodLevel() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              Icons.access_time_rounded,
              color: greyTextColor,
            ),
            MarginWidth(width: 3.w),
            Text(
              '${widget.foodReceiptModel?.duration ?? widget.foodReceipt?.duration} Min',
              style: regularStyle.copyWith(fontSize: 12, color: greyTextColor),
            )
          ],
        ),
        Row(
          children: [
            Icon(
              Icons.sentiment_satisfied_rounded,
              color: greyTextColor,
            ),
            MarginWidth(width: 3.w),
            Text(
              widget.foodReceiptModel?.levelOfMaking ??
                  widget.foodReceipt!.levelOfMaking!,
              style: regularStyle.copyWith(fontSize: 12, color: greyTextColor),
            )
          ],
        )
      ],
    );
  }

  Widget _ingredientSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          'Bahan Baku',
          style: titleStyle.copyWith(color: blackColor),
        ),
        Wrap(
          alignment: WrapAlignment.spaceAround,
          runSpacing: 10,
          children: List.generate(
              widget.foodReceiptModel?.ingredients.length ??
                  widget.foodReceipt!.ingredients!.length, (index) {
            return GestureDetector(
              onTap: () {},
              child: Container(
                alignment: Alignment.center,
                height: 14.h,
                width: 14.h,
                decoration: BoxDecoration(
                  color: greenColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  widget.foodReceiptModel?.ingredients[index] ??
                      widget.foodReceipt!.ingredients![index],
                  style: regularStyle.copyWith(color: blackColor),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  // Widget _ingredientSection() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     mainAxisSize: MainAxisSize.min,
  //     children: [
  //       Text(
  //         'Bahan Baku',
  //         style: titleStyle.copyWith(color: blackColor),
  //       ),
  //       GridView.builder(
  //           gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
  //               maxCrossAxisExtent: 15.h,
  //               childAspectRatio: 2 / 2,
  //               crossAxisSpacing: 10,
  //               mainAxisSpacing: 10),
  //           shrinkWrap: true,
  //           primary: false,
  //           itemBuilder: (context, index) {
  //             return Container(
  //               alignment: Alignment.center,
  //               margin: const EdgeInsets.all(10),
  //               decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(10),
  //                 color: greenColor.withOpacity(0.3),
  //               ),
  //               height: 10.h,
  //               width: double.infinity,
  //               child: Text(
  //                 widget.foodReceiptModel?.ingredients[index] ??
  //                     widget.foodReceipt!.ingredients![index],
  //                 style: regularStyle.copyWith(color: blackColor),
  //                 textAlign: TextAlign.center,
  //               ),
  //             );
  //           },
  //           itemCount: widget.foodReceiptModel?.ingredients.length ??
  //               widget.foodReceipt!.ingredients!.length),
  //     ],
  //   );
  // }

  Widget _foodServiceStyle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gaya Penyajian Makanan',
          style: titleStyle.copyWith(
            color: blackColor,
          ),
        ),
        MarginHeight(height: 1.h),
        SizedBox(
          height: 15.h,
          child: ListView.builder(
            itemCount: 5,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                width: 20.h,
                margin: const EdgeInsets.only(left: 0, right: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ClipRRect(
                    child: CachedNetworkImage(
                      imageUrl: widget.foodReceiptModel?.galleryPhoto[index] ??
                          widget.foodReceipt!.galleryPhoto![index],
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
              );
            },
          ),
        )
      ],
    );
  }
}
