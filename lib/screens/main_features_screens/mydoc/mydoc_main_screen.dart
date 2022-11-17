import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/core/mydoc/mydoc_notifier.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/custom_textfield.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/margin_height.dart';
import 'package:healthy_buddy_mobile_app/shared/theme.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../routes/routes.dart';
import '../../../shared/assets_directory.dart';
import '../../widgets/margin_width.dart';

class MyDocMainScreen extends StatefulWidget {
  MyDocMainScreen({super.key});

  @override
  State<MyDocMainScreen> createState() => _MyDocMainScreenState();
}

class _MyDocMainScreenState extends State<MyDocMainScreen> {
  final List<String> _iconImage = [
    "mydoc-pulmonology.png",
    "mydoc-cardiology.png",
    "mydoc-mentalhealth.png",
    "mydoc-hepatology.png"
  ];

  final List<String> _iconLabel = [
    "Pulmonology",
    "Cardiology",
    "Mental Health",
    "Hepatology"
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final doctorItemPulmonology =
        Provider.of<MyDocByPulmonologyClass>(context, listen: false);
    doctorItemPulmonology.getDoctor(
        context: context, specialist: "Pulmonology");
    final doctorItemCardiology =
        Provider.of<MyDocByCardiologyClass>(context, listen: false);
    doctorItemCardiology.getDoctor(context: context, specialist: "Cardiology");
    final doctorItemMentalHealth =
        Provider.of<MyDocByMentalHealthClass>(context, listen: false);
    doctorItemMentalHealth.getDoctor(
        context: context, specialist: "Mental Health");
    final doctorItemHepatology =
        Provider.of<MyDocByHepatologyClass>(context, listen: false);
    doctorItemHepatology.getDoctor(context: context, specialist: "Hepatology");
    final doctorItemExp =
        Provider.of<MyDocByExperienceClass>(context, listen: false);
    doctorItemExp.getDoctor(context: context, isExperience: "true");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        padding: defaultPadding,
        child: ListView(
          children: [
            _headerSection(),
            MarginHeight(height: 3.h),
            _doctorCategory(context),
            _topDoctorSection(),
            _topDoctorList()
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
          'MyDoc',
          style: titleStyle.copyWith(color: greenColor),
        ),
        Text(
          'Cari dokter terbaik untuk kesehatan mu!',
          style: regularStyle.copyWith(color: greyTextColor),
        ),
        MarginHeight(height: 5.h),
        Text(
          'Find your specialist',
          style: titleStyle.copyWith(color: greenColor),
        ),
        CustomTextField(
          color: greyColor,
          prefixIcon: Icon(
            Icons.search_rounded,
            color: greyTextColor,
          ),
          hintText: "try find 'dentist'",
        ),
      ],
    );
  }

  Widget _doctorCategory(BuildContext context) {
    return SizedBox(
      height: 14.5.h,
      width: double.infinity,
      child: Center(
        child: ListView.separated(
          separatorBuilder: (context, index) {
            return MarginWidth(width: 5.w);
          },
          itemCount: _iconImage.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 7.h,
                    decoration: BoxDecoration(
                      color: greenColor.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.asset(
                      '$iconDirectory/${_iconImage[index]}',
                      scale: 1.5.h,
                    ),
                  ),
                ),
                Text(
                  _iconLabel[index].replaceAll(" ", "\n"),
                  style: regularStyle.copyWith(fontSize: 10.sp),
                  textAlign: TextAlign.center,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _topDoctorSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Dokter Terbaik',
          style: titleStyle.copyWith(color: greenColor),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            'Lihat Semua',
            style: regularStyle.copyWith(color: greyTextColor),
          ),
        )
      ],
    );
  }

  Widget _topDoctorList() {
    final itemExp = Provider.of<MyDocByExperienceClass>(context);
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(8),
            width: double.infinity,
            decoration: BoxDecoration(
              color: greyColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 110,
                  width: 110,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CachedNetworkImage(
                      imageUrl: itemExp.mydocModel?[index].thumbnail ??
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
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  width: 50.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        itemExp.mydocModel?[index].name ?? "Loading",
                        style: titleStyle.copyWith(fontSize: 12.sp),
                      ),
                      Text(
                        'Dentist - Bandung Hospital',
                        style: regularStyle.copyWith(
                            fontSize: 10.sp, color: greyTextColor),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time_rounded,
                            color: greyTextColor,
                          ),
                          MarginWidth(width: 2.w),
                          Text(
                            '7.00 AM - 4.30 PM',
                            style: regularStyle.copyWith(
                                fontSize: 10.sp, color: greyTextColor),
                          )
                        ],
                      ),
                      Text(
                        'Fee : \$ 100',
                        style: regularStyle.copyWith(
                            fontSize: 10.sp, color: greyTextColor),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: greenColor,
                          elevation: 0,
                        ),
                        onPressed: () {
                          final topDoctor = itemExp.mydocModel?[index];
                          Navigator.pushNamed(
                              context, AppRoutes.myDocDetailScreen,
                              arguments: topDoctor);
                        },
                        child: Text(
                          'Appointment',
                          style: regularStyle,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return MarginHeight(height: 2.h);
        },
        itemCount: itemExp.mydocModel?.length ?? 0);
  }
}
