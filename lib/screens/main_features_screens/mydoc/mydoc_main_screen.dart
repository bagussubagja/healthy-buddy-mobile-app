import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/core/mydoc/mydoc_notifier.dart';
import 'package:healthy_buddy_mobile_app/screens/main_features_screens/mydoc/category_screen/mydoc_category_screen.dart';
import 'package:healthy_buddy_mobile_app/screens/main_features_screens/mydoc/mydoc_search_result_screen.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/custom_textfield.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/loading_widget.dart';
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
  bool _isLoading = true;

  void showContent() {
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

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
    Timer(const Duration(seconds: 1), showContent);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topDoctor = Provider.of<MyDocByExperienceClass>(context);
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            PopupMenuButton(
                elevation: 0,
                icon: Icon(
                  Icons.more_horiz_rounded,
                  color: blackColor,
                ),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                color: Colors.white,
                itemBuilder: (context) => [
                      PopupMenuItem(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context,
                                AppRoutes.myDocAppointmentHistoryScreen);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(
                                Icons.people,
                                color: blackColor,
                              ),
                              Text(
                                'Riwayat Janji Temu',
                                style: regularStyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ])
          ],
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: blackColor,
            ),
          ),
        ),
        body: SafeArea(
            child: _isLoading
                ? LoadingWidget(
                    color: greenColor,
                  )
                : Padding(
                    padding: defaultPadding,
                    child: ListView(
                      children: [
                        _headerSection(),
                        MarginHeight(height: 3.h),
                        _doctorCategory(context),
                        _topDoctorSection(),
                        topDoctor.isloading == true
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : _topDoctorList()
                      ],
                    ),
                  )),
      ),
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
          'Cari dokter spesialis',
          style: titleStyle.copyWith(color: greenColor),
        ),
        CustomTextField(
          color: Colors.white,
          readOnly: true,
          prefixIcon: Icon(
            Icons.search_rounded,
            color: greyTextColor,
          ),
          onTap: () {
            showSearch(context: context, delegate: MyDocSearchResultScreen());
          },
          hintText: "cari dokter spesialist kamu disini..",
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
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.myDocCategoryScreen,
                        arguments: index);
                  },
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
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.myDocTopDocScreen);
          },
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
              color: Colors.white,
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
                        '${itemExp.mydocModel?[index].specialist} - ${itemExp.mydocModel?[index].hospital}',
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
                            '${itemExp.mydocModel?[index].operationalHour} WIB',
                            style: regularStyle.copyWith(
                                fontSize: 10.sp, color: greyTextColor),
                          )
                        ],
                      ),
                      Text(
                        'RP : ${itemExp.mydocModel?[index].price}',
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
