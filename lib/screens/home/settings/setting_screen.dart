import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/margin_height.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/margin_width.dart';
import 'package:healthy_buddy_mobile_app/shared/theme.dart';
import 'package:sizer/sizer.dart';

class SettingScreen extends StatefulWidget {
  SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _isSelected = false;

  final List<IconData> _iconSettingMenu = [
    Icons.person_outline_outlined,
    Icons.supervised_user_circle_outlined,
    Icons.help_center_outlined
  ];

  final List<String> _nameSettingMenu = [
    "Account",
    "About Us",
    "Help Center",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: defaultPadding,
          child: ListView(
            shrinkWrap: true,
            children: [
              _topSection(),
              MarginHeight(height: 6.h),
              _userInformation(),
              MarginHeight(height: 3.h),
              _darkModeOption(),
              MarginHeight(height: 3.h),
              _menuSetting()
            ],
          ),
        ),
      ),
    );
  }

  Widget _topSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Setting',
          style: titleStyle.copyWith(color: greenColor),
        ),
        Text(
          'Healthy Buddy - Selalu disampingmu',
          style: regularStyle.copyWith(color: greyTextColor),
        )
      ],
    );
  }

  Widget _userInformation() {
    return Column(
      children: [
        UnconstrainedBox(
          child: SizedBox(
            height: 30.h,
            width: 60.w,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(1000),
              child: Image.asset(
                'assets/images/avatar-demo.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        MarginHeight(height: 3.h),
        Text(
          'Bagus Subagja',
          textAlign: TextAlign.center,
          style: titleStyle.copyWith(color: greyTextColor),
        ),
        Text(
          'bagussubagja99@gmail.com',
          textAlign: TextAlign.center,
          style: regularStyle.copyWith(color: greyTextColor),
        ),
      ],
    );
  }

  Widget _darkModeOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              height: 7.h,
              width: 7.h,
              decoration: BoxDecoration(
                color: greenColor.withOpacity(0.3),
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: greenColor),
              ),
              child: Icon(
                Icons.dark_mode_outlined,
                color: greenColor,
              ),
            ),
            MarginWidth(width: 5.w),
            Text(
              'Dark Mode',
              style: regularStyle,
            )
          ],
        ),
        Switch(
            activeColor: greenColor,
            value: _isSelected,
            onChanged: (value) {
              setState(() {
                _isSelected = value;
              });
            })
      ],
    );
  }

  Widget _menuSetting() {
    return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 7.h,
                    width: 7.h,
                    decoration: BoxDecoration(
                      color: greenColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: greenColor),
                    ),
                    child: Icon(
                      _iconSettingMenu[index],
                      color: greenColor,
                    ),
                  ),
                  MarginWidth(width: 5.w),
                  Text(
                    _nameSettingMenu[index],
                    style: regularStyle,
                  )
                ],
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: greyTextColor,
              )
            ],
          );
        },
        separatorBuilder: (context, index) {
          return MarginHeight(height: 10);
        },
        itemCount: _iconSettingMenu.length);
  }
}
