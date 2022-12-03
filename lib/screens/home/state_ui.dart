import 'dart:async';

import 'package:cache_manager/cache_manager.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/routes/routes.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/margin_height.dart';
import 'package:healthy_buddy_mobile_app/shared/theme.dart';
import 'package:sizer/sizer.dart';

class StatePageUI extends StatefulWidget {
  const StatePageUI({super.key});

  @override
  State<StatePageUI> createState() => _StatePageUIState();
}

class _StatePageUIState extends State<StatePageUI> {
  bool hasInternet = false;
  bool isLoading = true;
  ConnectivityResult result = ConnectivityResult.none;

  Future initiateCache() async {}

  @override
  void initState() {
    Timer(const Duration(seconds: 4), resultStateUI);
    super.initState();
  }

  Future resultStateUI() async {
    getConnectionResult();
    if (result == ConnectivityResult.none) {
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.notInternetScreen, (route) => false);
    } else {
      CacheManagerUtils.conditionalCache(
          key: 'cache',
          valueType: ValueType.StringValue,
          actionIfNull: () {
            Navigator.pushNamedAndRemoveUntil(
                context, AppRoutes.loginScreen, (route) => false);
          },
          actionIfNotNull: () {
            Navigator.pushNamedAndRemoveUntil(
                context, AppRoutes.bodyScreen, (route) => false);
          });
      isLoading = false;
    }
  }

  getConnectionResult() async {
    result = await Connectivity().checkConnectivity();
  }

  @override
  Widget build(BuildContext context) {
    getConnectionResult();
    return Scaffold(
      backgroundColor: bgColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: defaultPadding,
            child: Image.asset(
              'assets/images/logos/full_logo.png',
              fit: BoxFit.fill,
            ),
          ),
          MarginHeight(height: 1.5.h),
          Center(
            child: CircularProgressIndicator(
              color: greenColor,
            ),
          ),
        ],
      ),
    );
  }
}
