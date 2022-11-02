import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/margin_height.dart';
import 'package:healthy_buddy_mobile_app/shared/theme.dart';
import 'package:sizer/sizer.dart';

import '../../../widgets/margin_width.dart';

class MyDocDetailScreen extends StatelessWidget {
  const MyDocDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            _imageSection(context),
            MarginHeight(height: 9.h),
            Padding(
              padding: defaultPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _appointmentSection(),
                  _docdescription(),
                  MarginHeight(height: 2.h),
                  _detailDocData(),
                  MarginHeight(height: 4.h),
                  Positioned(
                    child: _appointmentButton(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _imageSection(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SizedBox(
          width: double.infinity,
          height: 400,
          child: Image.asset(
            'assets/images/dokter1.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Row(
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
        Positioned(
          top: 320,
          left: 20,
          right: 20,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                height: 135,
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
                      'Prof. Dr. Arfi Firman Pradipta',
                      style: titleStyle.copyWith(fontSize: 13.sp),
                      overflow: TextOverflow.ellipsis,
                    ),
                    MarginHeight(height: 1.h),
                    Text(
                      'Hepatology - Rancaekek Hospital',
                      style: regularStyle,
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
                          '7.00 AM - 4.30 PM',
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
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
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
                      '242',
                      style: titleStyle.copyWith(color: greenColor),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Patients',
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
      width: double.infinity,
      decoration: BoxDecoration(
        color: greenColor.withOpacity(0.7),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Fee : \$150',
            style: regularStyle.copyWith(color: whiteColor),
          ),
          Container(
            height: 5.h,
            padding: const EdgeInsets.only(left: 15, right: 15),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: greenColor.withOpacity(0.7),
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
