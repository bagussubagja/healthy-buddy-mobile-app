import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/shared/theme.dart';

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
            Text(
              'Healthy Buddy',
              style: titleStyle.copyWith(color: greenColor),
            ),
            Text(
              'Kesehatan Kamu yang Paling Penting!',
              style: regularStyle.copyWith(color: greyTextColor),
            ),
            
          ],
        ),
      )),
    );
  }
}
