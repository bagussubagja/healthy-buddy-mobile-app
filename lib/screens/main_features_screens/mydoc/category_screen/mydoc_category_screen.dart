import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/shared/theme.dart';

class MyDocCategoryScreen extends StatelessWidget {
  const MyDocCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: blackColor,
          ),
        ),
      ),
    );
  }
}
