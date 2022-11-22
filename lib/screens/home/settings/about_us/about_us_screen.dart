import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/margin_height.dart';
import 'package:healthy_buddy_mobile_app/shared/theme.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class AboutUsScreen extends StatelessWidget {
  AboutUsScreen({super.key});

  final List<String> _memberOfGroup = [
    'Arfi Triawan',
    'Bagus Subagja',
    'M. Faja Sumitra',
    'Riyandi Firman Pratama',
    'Suci Sukmawati'
  ];

  final List<int> _nimOfGroup = [2002890, 2008315, 2007669, 2008672, 2008656];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: blackColor,
            )),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
          child: Padding(
        padding: defaultPadding,
        child: ListView(
          children: [
            Text(
              'Tentang Kami',
              style: titleStyle.copyWith(color: greenColor),
            ),
            Text(
              'Healthy Buddy - Selalu ada untukmu',
              style: regularStyle.copyWith(color: greyTextColor),
            ),
            MarginHeight(height: 3.h),
            SizedBox(
              height: 30.h,
              width: double.infinity,
              child: SvgPicture.asset('assets/svg/about-us.svg'),
            ),
            MarginHeight(height: 3.h),
            Text(
              'Healthy Buddy is here as a form of our concern for human health. We created an app that caters to a healthy lifestyle for everyone. By providing various kinds of health needs such as healthy food, sports that can improve body fitness, as well as professional doctors who are ready to provide the best service to you!',
              style: regularStyle,
              textAlign: TextAlign.justify,
            ),
            MarginHeight(height: 4.h),
            Text(
              'Team Member :',
              style: regularStyle,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: _memberOfGroup.length,
              itemBuilder: (context, index) {
                return Text(
                  '- ${(_memberOfGroup[index])} | ${_nimOfGroup[index]}',
                  style: regularStyle,
                );
              },
            )
          ],
        ),
      )),
    );
  }
}
