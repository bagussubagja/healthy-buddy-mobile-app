// ignore_for_file: prefer_final_fields

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/core/sport/sport_exercise_notifier.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/loading_widget.dart';
import 'package:healthy_buddy_mobile_app/shared/assets_directory.dart';
import 'package:healthy_buddy_mobile_app/shared/theme.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../widgets/margin_height.dart';
import '../../../widgets/margin_width.dart';

class SportExerciseScreen extends StatefulWidget {
  const SportExerciseScreen({super.key});

  @override
  State<SportExerciseScreen> createState() => _SportExerciseScreenState();
}

class _SportExerciseScreenState extends State<SportExerciseScreen> {
  @override
  void initState() {
    super.initState();
    final item = Provider.of<SportExerciseAllClass>(context, listen: false);
    item.getSport(context: context);
  }

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
              Icons.arrow_back_ios_new_rounded,
              color: blackColor,
            )),
      ),
      body: SafeArea(
          child: Padding(
        padding: defaultPadding,
        child: ListView(
          children: [
            _headerSection(),
            MarginHeight(height: 3.h),
            _exerciseSection(),
          ],
        ),
      )),
    );
  }

  Widget _exerciseSection() {
    final item = Provider.of<SportExerciseAllClass>(context);

    if (item.isLoading == true) {
      return LoadingWidget(
        color: greenColor,
      );
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
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 3,
                  blurRadius: 10,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    height: 20.h,
                    width: 30.w,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: CachedNetworkImage(
                          imageUrl: item.sportExercise?[index].thumbnail ??
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
                        ))),
                MarginWidth(width: 4.w),
                SizedBox(
                    width: 50.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${item.sportExercise?[index].name}',
                          style: titleStyle.copyWith(
                              color: blackColor, fontSize: 14.sp),
                        ),
                        Text(
                          '${item.sportExercise?[index].description.substring(0, 80)}...',
                          style: regularStyle.copyWith(
                              fontSize: 10.sp, color: greyTextColor),
                        ),
                        Container(
                          alignment: Alignment.bottomRight,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: greenColor, elevation: 0),
                            onPressed: () async {
                              final url = Uri.parse(
                                  item.sportExercise![index].linkVideo);
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
        itemCount: item.sportExercise?.length ?? 0);
  }

  Widget _headerSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sport Exercise',
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
}
