import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/shared/theme.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class ContentEmptyWidget extends StatefulWidget {
  String? content;
  ContentEmptyWidget({super.key, this.content});

  @override
  State<ContentEmptyWidget> createState() => _ContentEmptyWidgetState();
}

class _ContentEmptyWidgetState extends State<ContentEmptyWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50.h,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          LottieBuilder.asset('assets/lotties/not-found-content.json'),
          Text(
            widget.content!,
            style: regularStyle.copyWith(color: blackColor),
          )
        ],
      ),
    );
  }
}
