import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/margin_height.dart';
import 'package:healthy_buddy_mobile_app/shared/theme.dart';
import 'package:sizer/sizer.dart';

import '../../../widgets/margin_width.dart';

class SportWebsiteScreen extends StatelessWidget {
  SportWebsiteScreen({super.key});

  final List<String> _itemLabel = ["Ganti Nama", "Ganti Alamat"];
  final List<IconData> _itemIcon = [Icons.person, Icons.location_on_rounded];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: blackColor,
            )),
      ),
      body: SafeArea(
          child: Padding(
        padding: defaultPadding,
        child: ListView(
          children: [
            Text(
              'Sport Website',
              style: titleStyle.copyWith(color: greenColor),
            ),
            Text(
              'Healthy Buddy - Update Berita Seputar Olahraga!',
              style: regularStyle.copyWith(color: greyTextColor),
            ),
            MarginHeight(height: 3.h),
            ListView.separated(
              separatorBuilder: (context, index) {
                return MarginHeight(height: 2.h);
              },
              shrinkWrap: true,
              itemCount: _itemIcon.length,
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Row(
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
                              _itemIcon[index],
                              color: greenColor,
                            ),
                          ),
                          MarginWidth(width: 5.w),
                          Text(
                            _itemLabel[index],
                            style: regularStyle,
                          )
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: greyTextColor,
                    )
                  ],
                );
                ;
              },
            )
          ],
        ),
      )),
    );
  }
}
