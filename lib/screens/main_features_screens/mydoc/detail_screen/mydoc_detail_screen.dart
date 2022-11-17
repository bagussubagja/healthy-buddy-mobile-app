import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/models/mydoc_model/mydoc_model.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/margin_height.dart';
import 'package:healthy_buddy_mobile_app/shared/assets_directory.dart';
import 'package:healthy_buddy_mobile_app/shared/theme.dart';
import 'package:indonesia/indonesia.dart';
import 'package:sizer/sizer.dart';

import '../../../widgets/margin_width.dart';

class MyDocDetailScreen extends StatefulWidget {
  MyDocModel? myDocModel;
  MyDocDetailScreen({super.key, this.myDocModel});

  @override
  State<MyDocDetailScreen> createState() => _MyDocDetailScreenState();
}

class _MyDocDetailScreenState extends State<MyDocDetailScreen> {
  final List<String> _docLabel = ["Patients", "Year exp", "Rating"];
  List<String> _numLabel = [];
  @override
  void initState() {
    super.initState();
    _numLabel.add(widget.myDocModel!.patients.toString());
    _numLabel.add(widget.myDocModel!.yearExp.toString());
    _numLabel.add(widget.myDocModel!.rating.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  _imageSection(context),
                  MarginHeight(height: 9.h),
                  Padding(
                    padding: defaultPadding.copyWith(bottom: 8.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _appointmentSection(),
                        _docdescription(),
                        MarginHeight(height: 2.h),
                        _detailDocData(),
                        MarginHeight(height: 4.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(width: 100.w, top: 0, child: _topSection()),
            Positioned(
              bottom: 0,
              child: _appointmentButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _topSection() {
    return Container(
      height: 6.h,
      color: Colors.black12,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: blackColor,
            ),
          ),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.favorite,
                color: blackColor,
              ))
        ],
      ),
    );
  }

  Widget _imageSection(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SizedBox(
          width: double.infinity,
          height: 50.h,
          child: Image.network(
            widget.myDocModel?.thumbnail ?? imgPlaceHolder,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 320,
          left: 20,
          right: 20,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                height: 20.h,
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: greyColor.withOpacity(0.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.myDocModel?.name ?? "Loading...",
                      style: titleStyle.copyWith(fontSize: 13.sp),
                      overflow: TextOverflow.ellipsis,
                    ),
                    MarginHeight(height: 1.h),
                    Text(
                      '${widget.myDocModel?.specialist} - ${widget.myDocModel?.hospital}',
                      style: regularStyle,
                      textAlign: TextAlign.center,
                    ),
                    MarginHeight(height: 1.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          color: blackColor,
                        ),
                        MarginWidth(width: 2.w),
                        Text(
                          '${widget.myDocModel?.operationalHour} WIB',
                          style: regularStyle.copyWith(fontSize: 10.sp),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _appointmentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Appointment',
          style: titleStyle.copyWith(color: greenColor),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Wednesday, 4th August 2022',
              style: regularStyle,
            ),
            OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: greenColor,
                ),
                onPressed: () {},
                child: Text(
                  'Change',
                  style: regularStyle,
                ))
          ],
        )
      ],
    );
  }

  Widget _docdescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About',
          style: titleStyle.copyWith(color: greenColor),
        ),
        Text(
          widget.myDocModel?.description ?? "Loading...",
          style: regularStyle,
          textAlign: TextAlign.justify,
        )
      ],
    );
  }

  Widget _detailDocData() {
    return SizedBox(
      height: 10.h,
      child: Center(
        child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                alignment: Alignment.center,
                width: 25.w,
                decoration: BoxDecoration(
                  color: greenColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _numLabel[index],
                      style: titleStyle.copyWith(color: greenColor),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      _docLabel[index],
                      style: regularStyle,
                    )
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return MarginWidth(width: 10);
            },
            itemCount: 3),
      ),
    );
  }

  Widget _appointmentButton() {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      height: 8.h,
      width: 100.w,
      decoration: BoxDecoration(
        color: greenColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            rupiah(widget.myDocModel?.price),
            style: regularStyle.copyWith(color: whiteColor),
          ),
          Container(
            height: 5.h,
            padding: const EdgeInsets.only(left: 15, right: 15),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: greenDarkerColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              'Appointment',
              style: regularStyle.copyWith(color: whiteColor),
            ),
          )
        ],
      ),
    );
  }
}
