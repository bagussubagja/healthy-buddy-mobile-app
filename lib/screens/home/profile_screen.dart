import 'package:cache_manager/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/core/authentication/user_notifier.dart';
import 'package:healthy_buddy_mobile_app/routes/routes.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/custom_textfield.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/margin_height.dart';
import 'package:healthy_buddy_mobile_app/shared/theme.dart';
import 'package:indonesia/indonesia.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../shared/assets_directory.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserClass>(context, listen: false);
    ReadCache.getString(key: 'cache').then((value) {
      setState(() {
        user.getUser(context: context, idUser: value);
      });
    });
    return Scaffold(
      backgroundColor: greenColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Profile Saya',
          style: titleStyle.copyWith(color: whiteColor),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: whiteColor,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: defaultPadding,
          child: ListView(
            children: [
              MarginHeight(height: 2.h),
              _headerSection(),
              MarginHeight(height: 2.h),
              _mainSection()
            ],
          ),
        ),
      ),
    );
  }

  Widget _headerSection() {
    final user = Provider.of<UserClass>(context);
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: SizedBox(
            height: 20.h,
            width: 20.h,
            child: user.users?[0].gender == "Laki-laki"
                ? Image.asset(
                    '$imageDirectory/ava1.png',
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    '$imageDirectory/ava2.png',
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        MarginHeight(height: 1.h),
        Text(
          '${user.users?[0].name}',
          style: titleStyle.copyWith(
            color: whiteColor,
            fontSize: 16.sp,
          ),
        ),
        MarginHeight(height: 0.5.h),
        Text(
          "Saldo : ${rupiah(user.users?[0].balance)}",
          style: regularStyle.copyWith(
            color: whiteColor,
            fontSize: 13.sp,
          ),
        ),
        MarginHeight(height: 0.5.h),
        Text(
          '${user.users?[0].age} Tahun\t|\t${user.users?[0].height} cm\t|\t${user.users?[0].weight} kg',
          style: regularStyle.copyWith(
            color: whiteColor,
            fontSize: 11.sp,
          ),
        ),
        MarginHeight(height: 0.5.h),
        Text(
          '${user.users?[0].dailyActivity} - ${user.users?[0].dailyCalories} kkal',
          style: regularStyle.copyWith(
            color: whiteColor,
            fontSize: 11.sp,
          ),
        ),
      ],
    );
  }

  Widget _mainSection() {
    final user = Provider.of<UserClass>(context);
    return Column(
      children: [
        CustomTextField(
          readOnly: true,
          prefixIcon: Icon(
            Icons.email_outlined,
            color: greenColor,
          ),
          hintText: '${user.users?[0].email}',
        ),
        MarginHeight(height: 2.h),
        CustomTextField(
          readOnly: true,
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${user.users?[0].address}')));
          },
          prefixIcon: Icon(
            Icons.location_on_outlined,
            color: greenColor,
          ),
          hintText: '${user.users?[0].address}',
        ),
        MarginHeight(height: 4.h),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.accountSettingScreen);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: whiteColor,
          ),
          child: Text(
            'Update Profil',
            style: regularStyle.copyWith(color: greenColor),
          ),
        )
      ],
    );
  }
}
