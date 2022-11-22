import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/margin_height.dart';
import 'package:healthy_buddy_mobile_app/shared/theme.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: blackColor,
            )),
      ),
      backgroundColor: bgColor,
      body: SafeArea(
          child: Padding(
        padding: defaultPadding,
        child: ListView(
          children: [
            _headerSection(),
            MarginHeight(height: 4.h),
            _imageSection(),
            MarginHeight(height: 4.h),
            _mainContent(),
          ],
        ),
      )),
    );
  }

  Widget _headerSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pusat Bantuan',
          style: titleStyle.copyWith(color: greenColor),
        ),
        Text(
          'Healthy Buddy - Selalu ada untukmu',
          style: regularStyle.copyWith(color: greyTextColor),
        ),
      ],
    );
  }

  Widget _imageSection() {
    return SizedBox(
      height: 30.h,
      width: double.infinity,
      child: SvgPicture.asset('assets/svg/help-center.svg'),
    );
  }

  Widget _mainContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Kamu memiliki kendala saat menggunakan aplikasi ini? Adukan masalahmu dengan menekan tombol dibawah ini!',
          style: regularStyle,
          textAlign: TextAlign.center,
        ),
        ElevatedButton(
            onPressed: () async {
              const toEmail = 'bagussubagja74@gmail.com';
              const subject = 'Ada masalah pada aplikasi Healthy Buddy';
              final url = Uri.parse('mailto:$toEmail?subject=$subject');
              if (await canLaunchUrl(url)) {
                await launchUrl(url);
              }
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: greenColor, elevation: 0),
            child: Text(
              'Laporkan Masalahmu!',
              style: regularStyle,
            ))
      ],
    );
  }
}
