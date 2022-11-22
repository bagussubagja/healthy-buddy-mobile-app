import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/core/mydoc/mydoc_notifier.dart';
import 'package:healthy_buddy_mobile_app/routes/routes.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/loading_widget.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/margin_height.dart';
import 'package:healthy_buddy_mobile_app/shared/theme.dart';
import 'package:indonesia/indonesia.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../shared/assets_directory.dart';
import '../../../widgets/margin_width.dart';

class MyDocCategoryScreen extends StatefulWidget {
  int? index;
  MyDocCategoryScreen({super.key, this.index});
  @override
  State<MyDocCategoryScreen> createState() => _MyDocCategoryScreenState();
}

class _MyDocCategoryScreenState extends State<MyDocCategoryScreen> {
  final List<String> _categoryLabel = [
    "Pulmonology",
    "Cardiology",
    "Mental Health",
    "Hepatology"
  ];

  bool isloading = true;

  void showContent() {
    if (mounted) {
      setState(() {
        isloading = !isloading;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    final itemPulmonology =
        Provider.of<MyDocByPulmonologyClass>(context, listen: false);
    itemPulmonology.getDoctor(context: context, specialist: "Pulmonology");
    final itemCardiology =
        Provider.of<MyDocByCardiologyClass>(context, listen: false);
    itemCardiology.getDoctor(context: context, specialist: "Cardiology");
    final itemMentalHealth =
        Provider.of<MyDocByMentalHealthClass>(context, listen: false);
    itemMentalHealth.getDoctor(context: context, specialist: "Mental+Health");
    final itemHepatology =
        Provider.of<MyDocByHepatologyClass>(context, listen: false);
    itemHepatology.getDoctor(context: context, specialist: "Hepatology");
    Timer(const Duration(seconds: 3), showContent);
    print(widget.index);
  }

  @override
  Widget build(BuildContext context) {
    final pulmonology = Provider.of<MyDocByPulmonologyClass>(context);
    final cardiology = Provider.of<MyDocByCardiologyClass>(context);
    final mentalHealth = Provider.of<MyDocByMentalHealthClass>(context);
    final hepatology = Provider.of<MyDocByHepatologyClass>(context);
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
        padding: defaultPadding,
        child: ListView(
          children: [
            _topSection(),
            MarginHeight(height: 2.h),
            pulmonology.isLoading ||
                    cardiology.isLoading ||
                    mentalHealth.isLoading ||
                    hepatology.isLoading
                ? LoadingWidget()
                : _itemList(),
          ],
        ),
      )),
    );
  }

  Widget _topSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Healthy Buddy',
          style: titleStyle.copyWith(color: greenColor),
        ),
        Text(
          'Kategori Dokter - ${_categoryLabel[widget.index ?? 0]}',
          style: regularStyle.copyWith(color: greyTextColor),
        )
      ],
    );
  }

  Widget _itemList() {
    final pulmonology = Provider.of<MyDocByPulmonologyClass>(context);
    final cardiology = Provider.of<MyDocByCardiologyClass>(context);
    final mentalHealth = Provider.of<MyDocByMentalHealthClass>(context);
    final hepatology = Provider.of<MyDocByHepatologyClass>(context);

    int itemCount(int x) {
      if (x == 0) {
        return pulmonology.mydocModel?.length ?? 0;
      } else if (x == 1) {
        return cardiology.mydocModel?.length ?? 0;
      } else if (x == 2) {
        return mentalHealth.mydocModel?.length ?? 0;
      } else if (x == 3) {
        return hepatology.mydocModel?.length ?? 0;
      } else {
        return 0;
      }
    }

    return ListView.separated(
      separatorBuilder: (context, index) {
        return MarginHeight(height: 2.h);
      },
      itemCount: itemCount(widget.index ?? 0),
      shrinkWrap: true,
      primary: false,
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
                height: 15.h,
                width: 15.h,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CachedNetworkImage(
                    imageUrl: widget.index == 0
                        ? pulmonology.mydocModel![index].thumbnail
                        : widget.index == 1
                            ? cardiology.mydocModel![index].thumbnail
                            : widget.index == 2
                                ? mentalHealth.mydocModel![index].thumbnail
                                : hepatology.mydocModel![index].thumbnail,
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
                    widget.index == 0
                        ? Text(
                            "${pulmonology.mydocModel?[index].name}",
                            style: titleStyle.copyWith(fontSize: 12.sp),
                          )
                        : widget.index == 1
                            ? Text(
                                "${cardiology.mydocModel?[index].name}",
                                style: titleStyle.copyWith(fontSize: 12.sp),
                              )
                            : widget.index == 2
                                ? Text(
                                    "${mentalHealth.mydocModel?[index].name}",
                                    style: titleStyle.copyWith(fontSize: 12.sp),
                                  )
                                : Text(
                                    "${hepatology.mydocModel?[index].name}",
                                    style: titleStyle.copyWith(fontSize: 12.sp),
                                  ),
                    widget.index == 0
                        ? Text(
                            '${pulmonology.mydocModel?[index].specialist} - ${pulmonology.mydocModel?[index].hospital}',
                            style: regularStyle.copyWith(
                                fontSize: 10.sp, color: greyTextColor),
                          )
                        : widget.index == 1
                            ? Text(
                                '${cardiology.mydocModel?[index].specialist} - ${cardiology.mydocModel?[index].hospital}',
                                style: regularStyle.copyWith(
                                    fontSize: 10.sp, color: greyTextColor),
                              )
                            : widget.index == 2
                                ? Text(
                                    '${mentalHealth.mydocModel?[index].specialist} - ${mentalHealth.mydocModel?[index].hospital}',
                                    style: regularStyle.copyWith(
                                        fontSize: 10.sp, color: greyTextColor),
                                  )
                                : Text(
                                    '${hepatology.mydocModel?[index].specialist} - ${hepatology.mydocModel?[index].hospital}',
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
                        widget.index == 0
                            ? Text(
                                '${pulmonology.mydocModel?[index].operationalHour}',
                                style: regularStyle.copyWith(
                                    fontSize: 10.sp, color: greyTextColor),
                              )
                            : widget.index == 1
                                ? Text(
                                    '${cardiology.mydocModel?[index].operationalHour}',
                                    style: regularStyle.copyWith(
                                        fontSize: 10.sp, color: greyTextColor),
                                  )
                                : widget.index == 2
                                    ? Text(
                                        '${mentalHealth.mydocModel?[index].operationalHour}',
                                        style: regularStyle.copyWith(
                                            fontSize: 10.sp,
                                            color: greyTextColor),
                                      )
                                    : Text(
                                        '${hepatology.mydocModel?[index].operationalHour}',
                                        style: regularStyle.copyWith(
                                            fontSize: 10.sp,
                                            color: greyTextColor),
                                      )
                      ],
                    ),
                    widget.index == 0
                        ? Text(
                            rupiah(pulmonology.mydocModel?[index].price),
                            style: regularStyle.copyWith(
                                fontSize: 10.sp, color: greyTextColor),
                          )
                        : widget.index == 1
                            ? Text(
                                rupiah(cardiology.mydocModel?[index].price),
                                style: regularStyle.copyWith(
                                    fontSize: 10.sp, color: greyTextColor),
                              )
                            : widget.index == 2
                                ? Text(
                                    rupiah(
                                        mentalHealth.mydocModel?[index].price),
                                    style: regularStyle.copyWith(
                                        fontSize: 10.sp, color: greyTextColor),
                                  )
                                : Text(
                                    rupiah(hepatology.mydocModel?[index].price),
                                    style: regularStyle.copyWith(
                                        fontSize: 10.sp, color: greyTextColor),
                                  ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: greenColor,
                        elevation: 0,
                      ),
                      onPressed: () {
                        if (widget.index == 0) {
                          var itemPulmonology = pulmonology.mydocModel?[index];
                          Navigator.pushNamed(
                              context, AppRoutes.myDocDetailScreen,
                              arguments: itemPulmonology);
                        } else if (widget.index == 1) {
                          var itemCardiology = cardiology.mydocModel?[index];
                          Navigator.pushNamed(
                              context, AppRoutes.myDocDetailScreen,
                              arguments: itemCardiology);
                        } else if (widget.index == 2) {
                          var itemMentalHealth =
                              mentalHealth.mydocModel?[index];
                          Navigator.pushNamed(
                              context, AppRoutes.myDocDetailScreen,
                              arguments: itemMentalHealth);
                        } else if (widget.index == 3) {
                          var itemHepatology = hepatology.mydocModel?[index];
                          Navigator.pushNamed(
                              context, AppRoutes.myDocDetailScreen,
                              arguments: itemHepatology);
                        }
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
    );
  }
}
