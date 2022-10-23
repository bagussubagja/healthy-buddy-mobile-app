import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthy_buddy_mobile_app/shared/assets_directory.dart';
import 'package:sizer/sizer.dart';

import '../../routes/routes.dart';
import '../../shared/theme.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/margin_height.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: SafeArea(
            child: Padding(
          padding: defaultPadding,
          child: Align(
            alignment: Alignment.center,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              children: [
                Text(
                  'Register',
                  style: titleStyle.copyWith(color: greenColor),
                ),
                Text(
                  'Makes your life better',
                  style: regularStyle.copyWith(color: Colors.grey),
                ),
                MarginHeight(height: 15),
                Container(
                  alignment: Alignment.center,
                  height: 250,
                  width: double.infinity,
                  child: SvgPicture.asset('$svgDirectory/register.svg'),
                ),
                MarginHeight(height: 15),
                CustomTextField(
                  titleText: "Email Address",
                  hintText: "your email here...",
                  color: greyColor,
                  controller: _emailController,
                  textInputType: TextInputType.emailAddress,
                ),
                MarginHeight(height: 10),
                CustomTextField(
                  titleText: "Password",
                  hintText: "your password here...",
                  color: greyColor,
                  controller: _passwordController,
                ),
                MarginHeight(height: 20),
                SizedBox(
                  height: 7.h,
                  child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: greenColor),
                    child: Text(
                      'Register',
                      style: regularStyle,
                    ),
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, AppRoutes.homePageScreen, (route) => false);
                    },
                  ),
                ),
                MarginHeight(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Already have an account?",
                      style: regularStyle,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, AppRoutes.loginScreen, (route) => false);
                      },
                      child: Text(
                        'Login Now!',
                        style: regularStyle.copyWith(
                            decoration: TextDecoration.underline),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
