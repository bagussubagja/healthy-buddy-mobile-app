import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cache_manager/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/core/authentication/user_notifier.dart';
import 'package:healthy_buddy_mobile_app/credentials/supabase_credential.dart';
import 'package:healthy_buddy_mobile_app/models/user_model/user_model.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/custom_textfield.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/margin_height.dart';
import 'package:healthy_buddy_mobile_app/shared/theme.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/authentication/auth_notifier.dart';
import '../../../widgets/margin_width.dart';

class AccountSettingScreen extends StatefulWidget {
  AccountSettingScreen({super.key});

  @override
  State<AccountSettingScreen> createState() => _AccountSettingScreenState();
}

class _AccountSettingScreenState extends State<AccountSettingScreen> {
  final List<String> _itemLabel = [
    "Ganti Nama",
    "Ganti Alamat",
    "Ganti Data Diri"
  ];

  final List<IconData> _itemIcon = [
    Icons.person,
    Icons.location_on_rounded,
    Icons.lock_person_rounded
  ];

  final _nameController = TextEditingController();
  final _addressController = TextEditingController();

  String? idUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final user = Provider.of<UserClass>(context, listen: false);
    ReadCache.getString(key: 'cache').then((value) {
      setState(() {
        user.getUser(context: context, idUser: value);
        idUser = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserClass>(context);
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
              'Akun',
              style: titleStyle.copyWith(color: greenColor),
            ),
            Text(
              'Healthy Buddy - Selalu ada untukmu',
              style: regularStyle.copyWith(color: greyTextColor),
            ),
            MarginHeight(height: 3.h),
            ListView.separated(
              separatorBuilder: (context, index) {
                return MarginHeight(height: 2.h);
              },
              shrinkWrap: true,
              itemCount: _itemIcon.length,
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (index == 0) {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.noHeader,
                            borderSide: BorderSide(
                              color: greenColor,
                              width: 2,
                            ),
                            width: double.infinity,
                            buttonsBorderRadius: const BorderRadius.all(
                              Radius.circular(2),
                            ),
                            dismissOnTouchOutside: false,
                            headerAnimationLoop: false,
                            animType: AnimType.bottomSlide,
                            title: 'Perbaharui Nama',
                            body: Column(
                              children: [
                                Text(
                                  'Perbaharui Nama',
                                  style: titleStyle,
                                ),
                                CustomTextField(
                                  controller: _nameController,
                                  hintText: user.users?[0].name,
                                  autofocus: true,
                                )
                              ],
                            ),
                            btnCancelOnPress: () {
                              _nameController.clear();
                            },
                            btnOkOnPress: () async {
                              UserModel updateName =
                                  UserModel(name: _nameController.text);
                              var provider = Provider.of<UserUpdateNameClass>(
                                  context,
                                  listen: false);
                              provider.updateName(updateName, idUser!, context);
                            },
                          ).show();
                        } else if (index == 1) {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.noHeader,
                            borderSide: BorderSide(
                              color: greenColor,
                              width: 2,
                            ),
                            width: double.infinity,
                            buttonsBorderRadius: const BorderRadius.all(
                              Radius.circular(2),
                            ),
                            dismissOnTouchOutside: false,
                            headerAnimationLoop: false,
                            animType: AnimType.bottomSlide,
                            title: 'Perbaharui Alamat',
                            body: Column(
                              children: [
                                Text(
                                  'Perbaharui Alamat',
                                  style: titleStyle,
                                ),
                                CustomTextField(
                                  controller: _addressController,
                                  hintText: user.users?[0].address,
                                  autofocus: true,
                                )
                              ],
                            ),
                            btnCancelOnPress: () async {
                              _addressController.clear();
                            },
                            btnOkOnPress: () async {
                              UserModel updateAddress =
                                  UserModel(address: _addressController.text);
                              var provider =
                                  Provider.of<UserUpdateAddressClass>(context,
                                      listen: false);

                              provider.updateAddress(
                                  updateAddress, idUser!, context);
                            },
                          ).show();
                        }
                      },
                      child: Row(
                        children: [
                          Container(
                            height: 7.h,
                            width: 7.h,
                            decoration: BoxDecoration(
                              color: greenColor.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(color: greenColor),
                            ),
                            child: Icon(
                              _itemIcon[index],
                              color: greenColor,
                            ),
                          ),
                          MarginWidth(width: 5.w),
                          Text(
                            _itemLabel[index],
                            style: regularStyle,
                          )
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: greyTextColor,
                    )
                  ],
                );
              },
            )
          ],
        ),
      )),
    );
  }
}
