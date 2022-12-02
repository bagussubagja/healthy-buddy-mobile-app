// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/shared/theme.dart';

class CustomTextField extends StatelessWidget {
  String? titleText;
  String? hintText;
  Color? color;
  TextEditingController? controller;
  bool? autofocus;
  Widget? widget;
  Widget? suffixIcon;
  int? maxLength;
  Widget? prefixIcon;
  Function()? onTap;
  Function(String)? onChanged;
  bool? obscureText;
  bool? readOnly;
  bool? isObscure;
  double? height;
  TextInputType? textInputType;
  CustomTextField(
      {Key? key,
      this.titleText,
      this.hintText,
      this.controller,
      this.autofocus,
      this.widget,
      this.maxLength,
      this.onTap,
      this.prefixIcon,
      this.suffixIcon,
      this.obscureText,
      this.readOnly,
      this.isObscure,
      this.textInputType,
      this.height,
      this.onChanged,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleText == null
            ? const SizedBox.shrink()
            : Text(
                titleText!,
                style: regularStyle,
              ),
        const SizedBox(
          height: 5,
        ),
        Container(
          height: height ?? 50,
          width: double.infinity,
          decoration: BoxDecoration(
              color: color ?? Colors.white,
              borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  autofocus: autofocus ?? false,
                  maxLength: maxLength,
                  onChanged: onChanged,
                  style: readOnly == true
                      ? regularStyle.copyWith(color: greenColor, fontSize: 16)
                      : regularStyle.copyWith(
                          color: greyTextColor, fontSize: 16),
                  cursorColor: greenColor,
                  keyboardType: textInputType,
                  obscureText: obscureText ?? false,
                  onTap: onTap,
                  readOnly: readOnly ?? false,
                  controller: controller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: suffixIcon,
                    counterText: "",
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: greenColor)),
                    prefixIcon: prefixIcon,
                    contentPadding:
                        const EdgeInsets.only(left: 10, bottom: 10, top: 10),
                    alignLabelWithHint: true,
                    hintText: hintText,
                    hintStyle: regularStyle.copyWith(color: Colors.grey),
                  ),
                ),
              ),
              widget == null
                  ? const SizedBox.shrink()
                  : Container(
                      child: widget,
                    )
            ],
          ),
        ),
      ],
    );
  }
}
