import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/routes/routes.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/margin_height.dart';
import 'package:healthy_buddy_mobile_app/shared/theme.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class NoInternetFoundScreen extends StatelessWidget {
  const NoInternetFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            height: 40.h,
            child:
                LottieBuilder.asset('assets/lotties/not-found-internet.json'),
          ),
          MarginHeight(height: 3.h),
          Text(
            'No Internet Connection Found!',
            style: titleStyle,
          ),
          MarginHeight(height: 3.h),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: greenColor,
              ),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, AppRoutes.statePageUI, (route) => false);
              },
              child: Text(
                'Try Again!',
                style: regularStyle,
              ))
        ],
      ),
    );
  }
}
