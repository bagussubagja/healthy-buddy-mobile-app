import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/margin_height.dart';
import 'package:healthy_buddy_mobile_app/shared/theme.dart';
import 'package:indonesia/indonesia.dart';
import 'package:sizer/sizer.dart';

class PurchaseHistoryScreen extends StatelessWidget {
  const PurchaseHistoryScreen({super.key});

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
            _topSection(),
            MarginHeight(height: 3.h),
            ListView.separated(
                shrinkWrap: true,
                primary: false,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(10),
                    width: double.infinity,
                    height: 15.h,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nama Item',
                          style: titleStyle,
                        ),
                        Text(
                          'Harga : ${rupiah(1000000)}',
                          style: regularStyle.copyWith(color: greyTextColor),
                        ),
                        Text(
                          'Waktu : ${DateTime.now().toString()}',
                          style: regularStyle.copyWith(color: greyTextColor),
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return MarginHeight(height: 3.h);
                },
                itemCount: 10)
          ],
        ),
      )),
    );
  }

  Widget _topSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Healthy Buddy',
          style: titleStyle.copyWith(color: greenColor),
        ),
        Text(
          'Kesehatan Kamu yang Paling Penting',
          style: regularStyle.copyWith(color: greyTextColor),
        ),
      ],
    );
  }
}
