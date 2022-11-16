import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/margin_height.dart';
import 'package:healthy_buddy_mobile_app/shared/theme.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(
          padding: defaultPadding,
          child: ListView(
            children: [
              Text(
                'Whistlist',
                style: titleStyle.copyWith(color: greenColor),
              ),
              Text(
                'Healthy Buddy - Always by your side!',
                style: regularStyle.copyWith(color: greyTextColor),
              ),
              MarginHeight(height: 3.h),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    Icons.location_on,
                    color: greyTextColor,
                  ),
                  SizedBox(
                    width: 75.w,
                    child: Text(
                      'Jl. Pendidikan No.15, Kecamatan Cileunyi 40392',
                      style: regularStyle.copyWith(color: greyTextColor),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 50.h,
                width: double.infinity,
                child: Lottie.asset('assets/lotties/not-found-content.json'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
