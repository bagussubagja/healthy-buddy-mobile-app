import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/routes/routes.dart';
import 'package:healthy_buddy_mobile_app/shared/theme.dart';

class StatePageUI extends StatefulWidget {
  const StatePageUI({super.key});

  @override
  State<StatePageUI> createState() => _StatePageUIState();
}

class _StatePageUIState extends State<StatePageUI> {
  bool hasInternet = false;
  ConnectivityResult result = ConnectivityResult.none;

  @override
  void initState() {
    Timer(const Duration(seconds: 4), resultStateUI);
    super.initState();
  }

  resultStateUI() async {
    getConnectionResult();
    if (result == ConnectivityResult.none) {
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.notInternetScreen, (route) => false);
    } else {
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.bodyScreen, (route) => false);
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
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
