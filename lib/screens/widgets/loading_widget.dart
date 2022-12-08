// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';


class LoadingWidget extends StatelessWidget {
  Color? color;
   LoadingWidget({super.key, this.color});
  @override
  Widget build(BuildContext context) {
    return  Center(
      child: CircularProgressIndicator(color: color),
    );
  }
}