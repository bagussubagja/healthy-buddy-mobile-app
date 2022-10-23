import 'package:flutter/material.dart';

class MarginHeight extends StatelessWidget {
  double height;
  MarginHeight({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}
