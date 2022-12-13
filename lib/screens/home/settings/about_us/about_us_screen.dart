// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/margin_height.dart';
import 'package:healthy_buddy_mobile_app/shared/theme.dart';
import 'package:sizer/sizer.dart';

class AboutUsScreen extends StatelessWidget {
  AboutUsScreen({super.key});

  final List<String> _memberOfGroup = [
    'Arfi Triawan',
    'Bagus Subagja',
    'M. Faja Sumitra',
    'Riyandi Firman P.',
    'Suci Sukmawati'
  ];

  final List<String> _memberAvatar = [
    'arfi.png',
    'bagus.png',
    'faja.png',
    'riyandi.png',
    'suci.png'
  ];

  final List<String> _memberRoles = [
    'Backend Dev',
    'Mobile Dev',
    'UI/UX Designer',
    'Backend Dev',
    'Project Manager'
  ];

  String _description =
      "Healthy Buddy Mobile App merupakan sebuah aplikasi informatif seputar kesehatan. Aplikasi ini hadir sebagai bentuk kepedulian kami terhadap kesehatan manusia. Dengan menyediakan berbagai macam kebutuhan kesehatan seperti makanan sehat, daftar olahraga yang dapat kamu lakukan, serta layanan dokter yang siap memberikanmu pelayanan terbaik!";

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
              _description,
              style: regularStyle.copyWith(color: greyTextColor),
              textAlign: TextAlign.justify,
            ),
            MarginHeight(height: 4.h),
            Text(
              'Team Member :',
              style: regularStyle,
            ),
            MarginHeight(height: 1.5.h),
            ListView.separated(
              separatorBuilder: (context, index) {
                return MarginHeight(height: 2.h);
              },
              shrinkWrap: true,
              primary: false,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _memberOfGroup.length,
              itemBuilder: (context, index) {
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: greenColor,
                      borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Container(
                                height: 10.h,
                                width: 10.h,
                                padding: const EdgeInsets.all(8),
                                child: Image.asset(
                                    'assets/images/${_memberAvatar[index]}')),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                _memberOfGroup[index],
                                style: regularStyle.copyWith(
                                    color: whiteColor, fontSize: 12.sp),
                              ),
                              Text(
                                _nimOfGroup[index].toString(),
                                style: regularStyle.copyWith(
                                    color: whiteColor, fontSize: 10.sp),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        _memberRoles[index],
                        style: regularStyle.copyWith(
                            color: whiteColor, fontSize: 10.sp),
                      )
                    ],
                  ),
                );
              },
            )
          ],
        ),
      )),
    );
  }
}
