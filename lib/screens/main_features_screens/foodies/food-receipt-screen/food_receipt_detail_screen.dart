import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/margin_height.dart';
import 'package:healthy_buddy_mobile_app/shared/theme.dart';
import 'package:sizer/sizer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../widgets/margin_width.dart';

class FoodReceiptDetailScreen extends StatefulWidget {
  const FoodReceiptDetailScreen({super.key});

  @override
  State<FoodReceiptDetailScreen> createState() =>
      _FoodReceiptDetailScreenState();
}

class _FoodReceiptDetailScreenState extends State<FoodReceiptDetailScreen> {
  late YoutubePlayerController controller;

  @override
  void initState() {
    super.initState();
    const url = 'https://www.youtube.com/watch?v=u7QfzLYeBBY';
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
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.more_horiz_rounded,
                    color: blackColor,
                  ),
                )
              ],
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
                    _ingredientSection(),
                    MarginHeight(height: 1.h),
                    _foodServiceStyle()
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Pancakes",
          style: titleStyle.copyWith(color: blackColor),
        ),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.favorite_rounded,
              color: greyTextColor,
            ))
      ],
    );
  }

  Widget _ratingSection() {
    return RatingBarIndicator(
      rating: 4,
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
              '10 Min',
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
              'Easy',
              style: regularStyle.copyWith(fontSize: 12, color: greyTextColor),
            )
          ],
        )
      ],
    );
  }

  Widget _ingredientSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Ingredients',
          style: titleStyle.copyWith(color: blackColor),
        ),
        GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 15.h,
                childAspectRatio: 2 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
            shrinkWrap: true,
            primary: false,
            itemBuilder: (context, index) {
              return Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: greenColor.withOpacity(0.3),
                ),
                height: 100,
                width: double.infinity,
                child: Text(
                  'Blueberry',
                  style: regularStyle.copyWith(color: blackColor),
                ),
              );
            },
            itemCount: 6),
      ],
    );
  }

  Widget _foodServiceStyle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Food Service Style',
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
                  child: Image.asset(
                    'assets/images/onboardscreen.png',
                    fit: BoxFit.cover,
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
