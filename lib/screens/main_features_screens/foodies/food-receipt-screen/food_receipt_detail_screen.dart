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
                    ))
              ],
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: player,
                      ),
                    ),
                    MarginHeight(height: 2.h),
                    Text(
                      controller.metadata.title,
                      style: titleStyle.copyWith(color: blackColor),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              style: regularStyle.copyWith(fontSize: 12),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.emoji_emotions_rounded,
                              color: greyTextColor,
                            ),
                            MarginWidth(width: 5),
                            Text(
                              'Easy',
                              style: regularStyle.copyWith(fontSize: 12),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
