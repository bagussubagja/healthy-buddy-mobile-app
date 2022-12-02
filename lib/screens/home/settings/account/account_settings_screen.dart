import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
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

  final _ageController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();

  List<String> _activityLabel = [
    "Sangat Rendah",
    "Cukup Rendah",
    "Normal",
    "Cukup Padat",
    "Sangat Padat"
  ];
  String? _selectedActivityValue = 'Normal';

  double? _dailyCaloriesValue = 0;

  double _calorieCalculator(
      String gender, int age, int height, int weight, double activityValue) {
    if (gender == "Laki-laki") {
      return ((66.5 + (13.75 * weight) + (5.003 * height) - (6.75 * age)) *
          activityValue);
    } else if (gender == "Perempuan") {
      return ((655.1 + (9.563 * weight) + (1.850 * height) - (4.676 * age)) *
          activityValue);
    } else {
      return 0;
    }
  }

  double _activityValue(String activity) {
    if (activity == "Sangat Rendah") {
      return 1.2;
    } else if (activity == "Cukup Rendah") {
      return 1.35;
    } else if (activity == "Normal") {
      return 1.5;
    } else if (activity == "Cukup Padat") {
      return 1.7;
    } else if (activity == "Sangat Padat") {
      return 1.9;
    } else {
      return 0;
    }
  }

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
                          changeName(user);
                        } else if (index == 1) {
                          changeAddress(user);
                        } else if (index == 2) {
                          changeSelfData(user);
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

  Future changeName(UserClass user) async {
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
        if (_nameController.text.isNotEmpty) {
          UserModel updateName = UserModel(name: _nameController.text);
          var provider =
              Provider.of<UserUpdateNameClass>(context, listen: false);
          provider.updateName(updateName, idUser!, context);
        }
      },
    ).show();
  }

  Future changeAddress(UserClass user) async {
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
        UserModel updateAddress = UserModel(address: _addressController.text);
        var provider =
            Provider.of<UserUpdateAddressClass>(context, listen: false);

        provider.updateAddress(updateAddress, idUser!, context);
      },
    ).show();
  }

  Future changeSelfData(UserClass user) async {
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
      title: 'Perbaharui Data Diri',
      body: StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Perbaharui Data Diri',
                  style: titleStyle.copyWith(color: blackColor),
                ),
                MarginHeight(height: 2.h),
                Text(
                  'Usia',
                  style: regularStyle.copyWith(
                      fontSize: 11.sp, color: greyTextColor),
                ),
                CustomTextField(
                  controller: _ageController,
                  hintText: '${user.users?[0].age} Tahun',
                  autofocus: true,
                  textInputType: TextInputType.number,
                ),
                MarginHeight(height: 1.h),
                Text(
                  'Berat Badan',
                  style: regularStyle.copyWith(
                      fontSize: 11.sp, color: greyTextColor),
                ),
                CustomTextField(
                  controller: _weightController,
                  hintText: '${user.users?[0].weight} kg',
                  autofocus: true,
                  textInputType: TextInputType.number,
                ),
                MarginHeight(height: 1.h),
                Text(
                  'Tinggi Badan',
                  style: regularStyle.copyWith(
                      fontSize: 11.sp, color: greyTextColor),
                ),
                CustomTextField(
                  controller: _heightController,
                  hintText: '${user.users?[0].height} cm',
                  autofocus: true,
                  textInputType: TextInputType.number,
                ),
                MarginHeight(height: 1.h),
                Text(
                  'Bobot Aktivitas Harian',
                  style: regularStyle.copyWith(
                      fontSize: 11.sp, color: greyTextColor),
                ),
                DropdownButton<String>(
                  dropdownColor: Colors.white,
                  alignment: AlignmentDirectional.center,
                  elevation: 0,
                  isExpanded: true,
                  items: _activityLabel
                      .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e,
                            style: regularStyle,
                          )))
                      .toList(),
                  value: _selectedActivityValue,
                  onChanged: (value) {
                    setState(() {
                      _selectedActivityValue = value;
                    });
                  },
                ),
              ],
            ),
          );
        },
      ),
      btnCancelOnPress: () {
        _nameController.clear();
        _addressController.clear();
        _ageController.clear();
        _heightController.clear();
        _weightController.clear();
      },
      btnOkOnPress: () async {
        if (_ageController.text.isNotEmpty &&
            _weightController.text.isNotEmpty &&
            _heightController.text.isNotEmpty &&
            _selectedActivityValue!.isNotEmpty) {
          UserModel self = UserModel(
            age: int.parse(_ageController.text),
            weight: int.parse(_weightController.text),
            height: int.parse(_heightController.text),
            dailyActivity: _selectedActivityValue,
            dailyCalories: _calorieCalculator(
                user.users?[0].gender ?? "Laki-laki",
                int.parse(_ageController.text),
                int.parse(_heightController.text),
                int.parse(_weightController.text),
                _activityValue(_selectedActivityValue!)),
          );
          var provider =
              Provider.of<UserUpdateSelfDataClass>(context, listen: false);
          provider.updateSelfData(self, idUser!, context);
        } else {
          final snackBar = SnackBar(
            elevation: 0,
            width: double.infinity,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'Field Tidak Boleh Kosong!',
              message: 'Kamu harus mengisi semua field yang ada!',
              contentType: ContentType.warning,
            ),
          );
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
        }
      },
    ).show();
  }
}
