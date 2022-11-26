import 'dart:async';

import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/routes/routes.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/loading_widget.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/margin_height.dart';
import 'package:healthy_buddy_mobile_app/shared/theme.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class FoodStoreStatusOrderScreen extends StatefulWidget {
  const FoodStoreStatusOrderScreen({super.key});

  @override
  State<FoodStoreStatusOrderScreen> createState() =>
      _FoodStoreStatusOrderScreenState();
}

class _FoodStoreStatusOrderScreenState
    extends State<FoodStoreStatusOrderScreen> {
  bool isLoading = true;
  void showContent() {
    if (mounted) {
      setState(() {
        isLoading = !isLoading;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 3), showContent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: isLoading
          ? Center(
              child: LoadingWidget(),
            )
          : SafeArea(
              child: Padding(
              padding: defaultPadding,
              child: Center(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 50.h,
                      child: LottieBuilder.asset(
                          'assets/lotties/order-success.json'),
                    ),
                    Center(
                      child: Column(
                        children: [
                          Text(
                            'Selamat!',
                            style: titleStyle,
                          ),
                          MarginHeight(height: 1.h),
                          Text(
                            'Pesanan kamu sedang kami proses, tunggu sampai kurir kami mengirimkan barang ke rumahmu!',
                            style: regularStyle.copyWith(color: greyTextColor),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                    MarginHeight(height: 3.h),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, AppRoutes.bodyScreen, (route) => false);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: greenColor),
                        child: Text(
                          'Kembali ke Menu Utama',
                          style: regularStyle,
                        ))
                  ],
                ),
              ),
            )),
    );
  }
}
