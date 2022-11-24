import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthy_buddy_mobile_app/routes/routes.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/custom_textfield.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/margin_height.dart';
import 'package:healthy_buddy_mobile_app/shared/assets_directory.dart';
import 'package:healthy_buddy_mobile_app/shared/theme.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../core/authentication/auth_notifier.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  bool _isVisible = true;

  @override
  Widget build(BuildContext context) {
    final AuthenticationNotifier authenticationNotifier =
        Provider.of<AuthenticationNotifier>(context, listen: false);
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
                  'Login',
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
                  child: SvgPicture.asset('$svgDirectory/login.svg'),
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
                  isObscure: _isVisible,
                  obscureText: _isVisible,
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isVisible = !_isVisible;
                        });
                      },
                      icon: Icon(
                        Icons.visibility,
                        color: greyTextColor,
                      )),
                ),
                MarginHeight(height: 20),
                SizedBox(
                  height: 7.h,
                  child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: greenColor),
                    child: Text(
                      'Login',
                      style: regularStyle,
                    ),
                    onPressed: () async {
                      if (_emailController.text.isNotEmpty &&
                          _passwordController.text.isNotEmpty) {
                        authenticationNotifier.loginUser(
                          context: context,
                            email: _emailController.text,
                            password: _passwordController.text);
                      } else {
                        final snackBar = SnackBar(
                          elevation: 0,
                          width: double.infinity,
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.transparent,
                          content: AwesomeSnackbarContent(
                            title: 'Field Tidak Boleh Kosong!',
                            message:
                                'Kamu harus memasukan email dan password untuk melakukan register!',
                            contentType: ContentType.warning,
                          ),
                        );
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(snackBar);
                      }
                      // Navigator.pushNamedAndRemoveUntil(
                      //     context, AppRoutes.bodyScreen, (route) => false);
                    },
                  ),
                ),
                MarginHeight(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Didn't have any account?",
                      style: regularStyle,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(context,
                            AppRoutes.registerScreen, (route) => false);
                      },
                      child: Text(
                        'Register Now!',
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
