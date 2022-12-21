import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/routes/routes.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/margin_height.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/margin_width.dart';
import 'package:healthy_buddy_mobile_app/shared/theme.dart';
import 'package:sizer/sizer.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final List<IconData> _iconSettingMenu = [
    Icons.person_outline_outlined,
    Icons.supervised_user_circle_outlined,
    Icons.help_center_outlined,
    Icons.history
  ];

  final List<String> _nameSettingMenu = [
    "Akun",
    "Tentang Kami",
    "Pusat Bantuan",
    "Riwayat Pembelian"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(
          padding: defaultPadding,
          child: ListView(
            shrinkWrap: true,
            children: [
              _topSection(),
              MarginHeight(height: 6.h),
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
          'Pengaturan',
          style: titleStyle.copyWith(color: greenColor),
        ),
        Text(
          'Healthy Buddy - Selalu disampingmu',
          style: regularStyle.copyWith(color: greyTextColor),
        )
      ],
    );
  }

  Widget _menuSetting() {
    return ListView.separated(
        shrinkWrap: true,
        primary: false,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              if (index == 0) {
                Navigator.pushNamed(context, AppRoutes.accountSettingScreen);
              } else if (index == 1) {
                Navigator.pushNamed(context, AppRoutes.aboutUsScreen);
              } else if (index == 2) {
                Navigator.pushNamed(context, AppRoutes.helpCenterScreen);
              } else if (index == 3) {
                Navigator.pushNamed(context, AppRoutes.purchaseHistoryScreen);
              }
            },
            child: Row(
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
            ),
          );
        },
        separatorBuilder: (context, index) {
          return MarginHeight(height: 10);
        },
        itemCount: _iconSettingMenu.length);
  }
}
