import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/shared/theme.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/mydoc/mydoc_notifier.dart';
import '../../../../routes/routes.dart';
import '../../../../shared/assets_directory.dart';
import '../../../widgets/margin_height.dart';
import '../../../widgets/margin_width.dart';

class TopDoctorScreen extends StatefulWidget {
  const TopDoctorScreen({super.key});

  @override
  State<TopDoctorScreen> createState() => _TopDoctorScreenState();
}

class _TopDoctorScreenState extends State<TopDoctorScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
              Icons.arrow_back_ios_new_rounded,
              color: blackColor,
            )),
      ),
      backgroundColor: bgColor,
      body: SafeArea(
          child: Padding(
        padding: defaultPadding,
        child: ListView(
          children: [
            _headerSection(),
            MarginHeight(height: 2.h),
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
          'Dokter Terbaik',
          style: titleStyle.copyWith(color: greenColor),
        ),
        Text(
          'Yang terbaik pada bidangnya!',
          style: regularStyle.copyWith(color: greyTextColor),
        ),
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
